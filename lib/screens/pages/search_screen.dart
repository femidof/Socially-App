import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:socially/components/firebase_methods.dart';
import 'package:socially/models/user.dart';
import 'package:socially/models/widgets/custom_tile.dart';
import 'package:socially/screens/pages/callscreens/pickup/pickup_layout.dart';
import 'package:socially/screens/pages/chatscreens/chat_screens.dart';
import 'package:socially/utils/universal_variables.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMethods firebaseMeth = FirebaseMethods();

  List<User> userList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.currentUser().then((FirebaseUser user) {
      firebaseMeth.fetchAllUsers(user).then((List<User> list) {
        setState(() {
          userList = list;
        });
      });
    });
  }

  searchAppBar(BuildContext context) {
    return NewGradientAppBar(
      gradient: LinearGradient(colors: [
        UniversalVariables.gradientColorStarthmm,
        UniversalVariables.gradientColorEndhmm,
      ]),
      // backgroundColorStart: UniversalVariables.gradientColorStarthmm,
      // backgroundColorEnd: UniversalVariables.gradientColorEndhmm,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: UniversalVariables.blackColor,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => searchController.clear());
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query) {
    List<User> suggestionList = query.isEmpty
        ? []
        : userList != null
            ? userList.where((User user) {
                String _getUsername = user.username.toLowerCase();
                String _query = query.toLowerCase();
                String _getName = user.displayName.toLowerCase();
                bool matchesUsername = _getUsername.contains(_query);
                bool matchesName = _getName.contains(_query);

                return (matchesUsername || matchesName);

                // (User user) => (user.username.toLowerCase().contains(query.toLowerCase()) ||
                //     (user.name.toLowerCase().contains(query.toLowerCase()))),
              }).toList()
            : [];
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: ((context, index) {
        User searchedUser = User(
            uid: suggestionList[index]?.uid,
            profilePhoto: suggestionList[index]?.profilePhoto,
            displayName: suggestionList[index]?.displayName,
            username: suggestionList[index]?.username);

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(receiver: searchedUser)));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(searchedUser?.profilePhoto),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.username,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedUser.displayName,
            style: TextStyle(color: UniversalVariables.greyColor),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.gradientColorEndhmm,
        appBar: searchAppBar(context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: buildSuggestions(query),
        ),
      ),
    );
  }
}
