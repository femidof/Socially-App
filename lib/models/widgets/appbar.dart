import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/utils/universal_variables.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  const CustomAppBar({
    Key key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color:
            // Color(0xff000111),
            Color(0xff120827),

        // UniversalVariables.gradientColorEndhmm,
        border: Border(
          // buttom: ,
          bottom: BorderSide(
            color: UniversalVariables.separatorColor,
            width: 1.4,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor:
            // Color(0xff9E90A2),
            // Color(0xff4D7EA8),
            // Color(0xff000111),
            Color(0xff120827),

        // UniversalVariables.gradientColorEndhmm,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTitle,
        title: title,
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}

AppBar header(BuildContext context, String text) {
  return AppBar(
    title: text == "Socially"
        ? Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: UniversalVariables.greyColor,
            child: Text(
              "Socially",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Pacifico",
                fontSize: 30,
              ),
            ),
          )
        : Text(
            text,
            style: TextStyle(
              color: Colors.white,
//              fontFamily: "Pacifico",
              fontSize: 18,
            ),
          ),
    centerTitle: true,
    backgroundColor: Color(0xff120827),
  );
}
