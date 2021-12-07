import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreScreenChild extends StatefulWidget {
  const ExploreScreenChild({Key? key}) : super(key: key);

  @override
  State<ExploreScreenChild> createState() => _ExploreScreenChildState();
}

class _ExploreScreenChildState extends State<ExploreScreenChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Explore",
          style: GoogleFonts.pacifico(
              fontSize: 20, color: context.textTheme.bodyText1!.color),
        ),
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: ListView(
        children: [
          buildSearchField(context),
          buildNoContent(),
        ],
      ),
    );
  }
}

buildNoContent() {
  return Container(
    child: Center(
      child: ListView(),
    ),
  );
}

buildSearchField(BuildContext c) {
  return AppBar(
    elevation: 0,
    backgroundColor: c.theme.scaffoldBackgroundColor,
    title: TextFormField(
      decoration: InputDecoration(
        hintText: "Search for a user...",
        filled: true,
        prefixIcon: Icon(
          Icons.account_box,
          size: 28,
        ),
        suffixIcon: IconButton(
            onPressed: () {
              print("cleared search");
            },
            icon: Icon(
              Icons.clear,
            )),
      ),
    ),
  );
}