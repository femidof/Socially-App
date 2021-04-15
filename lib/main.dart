import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socially/models/user.dart';
import 'package:socially/provider/image_upload_provider.dart';
import 'package:socially/provider/user_provider.dart';
import 'package:socially/screens/pages/chat_list_screen.dart';
import 'package:socially/screens/pages/search_screen.dart';
import 'package:socially/screens/wrapper.dart';
import 'package:socially/services/auth.dart';

void main() => runApp(
      BaseStart(),
    );

class BaseStart extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        StreamProvider(create: (_) => AuthService().user),
      ],
      child: StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Socially',
          theme: ThemeData.dark().copyWith(
            primaryColor: Color.fromRGBO(3, 9, 23, 1),
            accentColor: Colors.purple[600],
            backgroundColor: Color.fromRGBO(3, 9, 23, 1),
            // brightness: Brightness.dark,
          ),
          initialRoute: '/',
          routes: {
            '/search_screen': (context) => SearchScreen(),
            '/chat_list': (context) => ChatListScreen(),
          },
          home: Wrapper(),

        ),
        initialRoute: '/',
        routes: {
          '/search_screen': (context) => SearchScreen(),
        },
        home: Wrapper(),
      ),
    );
  }
}
