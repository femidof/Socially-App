import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/demo/chat.dart';
import 'package:socially/demo/users.dart';
import 'package:socially/demo/util.dart';
import 'package:socially/screens/home_launch_screen.dart';
import 'package:socially/shared/theme.dart';
import 'package:socially/shared/universal_variables.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  User? _user = FirebaseChatCore.instance.firebaseUser;

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    // print("tryingn to print room ID to see whats in there ${room.id}");
    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      // margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 24,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Text('No rooms'),
            );
          }
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            // separatorBuilder: (_, __) => Divider(
            //   color: UniversalVariables.separatorColor,
            //   height: 0.5,
            // ),
            shrinkWrap: true,
            padding: EdgeInsets.all(0.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room = snapshot.data![index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        room: room,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: UniversalVariables.separatorColor,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildAvatar(room),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              room.name ?? '',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              '${room.lastMessages!.first.toJson()["text"]}',
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreenChild extends StatelessWidget {
  const ChatScreenChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor:
            //  Color(0xff120827),
            context.theme.scaffoldBackgroundColor,
        foregroundColor: UniversalVariables.lightBlueColor,
        title: GestureDetector(
          child: Shimmer.fromColors(
            child: Text(
              "Socially",
              style: GoogleFonts.pacifico(
                fontSize: 24,
              ),
            ),
            baseColor: UniversalVariables.gradientColorEnd,
            highlightColor: UniversalVariables.gradientColorStart,
          ),
          onTap: () {
            Get.to(() => TestPage());
          },
        ),
        centerTitle: true,
        actions: [
          ObxValue(
            (data) => Switch(
              activeColor: Colors.blue,
              value: Themees.isLightTheme.value,
              onChanged: (val) {
                Themees.isLightTheme.value = val;
                Get.changeThemeMode(
                  Themees.isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                );
                Themees().saveThemeStatus();
              },
            ),
            false.obs,
          ),
        ],
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    "New Group Chat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => UsersPage());
                  },
                  child: Text(
                    "New Chat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: UniversalVariables.separatorColor,
            height: 0.5,
          ),
          ChatListScreen(),
        ],
      ),
    );
  }
}
