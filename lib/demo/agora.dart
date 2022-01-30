import 'package:agora_rtm/agora_rtm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/src/room.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

const String appId = 'e3251b08fecf4e399c40cf5d128ddef0';

class AgoraSetup extends StatefulWidget {
  const AgoraSetup({Key? key, required this.room}) : super(key: key);
  final Room room;

  @override
  State<AgoraSetup> createState() => _AgoraSetupState();
}

class _AgoraSetupState extends State<AgoraSetup> {
  late AgoraRtmClient _client;

  late AgoraRtmChannel _channel;
  late bool _isLogin;
  late bool _isInChannel;

  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseChatCore.instance.firebaseUser!;
    _createClient();
  }

  void _createClient() async {
    _client = await AgoraRtmClient.createInstance(appId);
    _client.onConnectionStateChanged = (int state, int reason) {
      if (state == 5) {
        _client.logout();
        print('Logout.');
        setState(() {
          _isLogin = false;
        });
      }
    }; //onConnectionStateChange

    String userId = user.uid;
    await _client.login(null, userId); //TODO null supposed to be token
    print('Login success: ' + userId);
    setState(() {
      _isLogin = true;
    });

    _channel = (await _createChannel("${widget.room.id}"))!;
    await _channel.join();
    print('RTM Join channel success.');
    setState(() {
      _isInChannel = true;
    });
  }

  Future<AgoraRtmChannel?> _createChannel(String name) async {
    AgoraRtmChannel? channel = await _client.createChannel(name);
    channel!.onMemberJoined = (AgoraRtmMember member) async {
      print(
          "Member joined: " + member.userId + ', channel: ' + member.channelId);
    };
    _client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        _client.logout();
        print('Logout.');
        setState(() {
          _isLogin = false;
        });
      }
    };
    return channel;
  }

  @override
  Widget build(BuildContext context) {
    return CallPage();
  }
}

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
