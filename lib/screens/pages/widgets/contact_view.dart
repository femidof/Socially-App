import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socially/components/firebase_methods.dart';
import 'package:socially/models/contact.dart';
import 'package:socially/models/user.dart';
import 'package:socially/models/widgets/custom_tile.dart';
import 'package:socially/models/widgets/progress_bar.dart';
import 'package:socially/provider/user_provider.dart';
import 'package:socially/screens/pages/chatscreens/chat_screens.dart';
import 'package:socially/screens/pages/chatscreens/widgets/cached_images.dart';
import 'package:socially/screens/pages/widgets/last_message_container.dart';
import 'package:socially/screens/pages/widgets/online_dot_indicator.dart';
import 'package:socially/utils/universal_variables.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final FirebaseMethods _authMethods = FirebaseMethods();
  ContactView({this.contact});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(contact: user);
        }
        return Center(
          child: ProgressBar.circularStylishProgress(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final FirebaseMethods _chatMethods = FirebaseMethods();

  ViewLayout({@required this.contact});
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        contact?.displayName ?? "..",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Arial",
          fontSize: 19,
        ),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(uid: contact.uid),
          ],
        ),
      ),
    );
  }
}
