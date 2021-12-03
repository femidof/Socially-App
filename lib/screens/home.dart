import 'package:flutter/material.dart';
import 'package:socially/screens/home_launch_screen.dart';
import 'package:super_easy_permissions/super_easy_permissions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<bool> checkForPermission() async {
    if (await SuperEasyPermissions.isGranted(Permissions.camera) &&
        await SuperEasyPermissions.isGranted(Permissions.contacts)) {
      return true;
    }
    return false;
  }

  Future<bool> askForPermission() async {
    if (await SuperEasyPermissions.askPermission(Permissions.camera) &&
        await SuperEasyPermissions.askPermission(Permissions.contacts)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkForPermission(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            // Permission is granted, do something
            return HomeLaunchScreen();
          } else if (snapshot.data == false) {
            return FutureBuilder(
                future: askForPermission(),
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return HomeLaunchScreen();
                  } else if (snapshot.data == false) {
                    return Scaffold(
                      body: Center(
                        child: GestureDetector(
                            onTap: () async {
                              print("ask");
                              askForPermission();
                            },
                            child: Text("Failed to accept permission")),
                      ),
                    );
                  }
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                });
          } else
            return Scaffold(
              body: Center(
                child: GestureDetector(
                    onTap: () async {
                      await askForPermission();
                    },
                    child:
                        Text("Problem with Permissions, tap on me to retry")),
              ),
            );
        });
    // Scaffold(
    //   body: Center(
    //       child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       ElevatedButton(
    //         onPressed: ThemeService().switchTheme,
    //         child: const Text("Change Theme"),
    //       ),
    //       const Text(
    //         "HOME",
    //         // style: TextStyle(color: Colors.white),
    //       ),
    //       ObxValue(
    //         (data) => Switch(
    //           value: _isLightTheme.value,
    //           onChanged: (val) {
    //             _isLightTheme.value = val;
    //             Get.changeThemeMode(
    //               _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
    //             );
    //             Themees().saveThemeStatus();
    //           },
    //         ),
    //         false.obs,
    //       ),
    //     ],
    //   )),
    // );
  }
}
