import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socially/services/theme_service.dart';
import 'package:socially/main.dart';
import 'package:socially/shared/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  RxBool _isLightTheme = false.obs;

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
          ObxValue(
            (data) => Switch(
              value: _isLightTheme.value,
              onChanged: (val) {
                _isLightTheme.value = val;
                Get.changeThemeMode(
                  _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                );
                Themees().saveThemeStatus();
              },
            ),
            false.obs,
          ),
        ],
      )),
    );
  }
}
