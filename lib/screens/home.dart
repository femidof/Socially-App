import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socially/services/theme_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: ThemeService().switchTheme,
            child: const Text("Change Theme"),
          ),
          const Text(
            "HOME",
            // style: TextStyle(color: Colors.white),
          ),
        ],
      )),
    );
  }
}
