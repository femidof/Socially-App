import 'package:flutter/cupertino.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:flutter/material.dart';

class GiphyWay extends StatefulWidget {
  const GiphyWay({Key? key}) : super(key: key);

  @override
  State<GiphyWay> createState() => _GiphyWayState();
}

class _GiphyWayState extends State<GiphyWay> {
  var gif;
  final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initsome();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GiphyImage.original(gif: gif),
    );
  }

  void initsome() async {
    gif = await GiphyPicker.pickGif(
        context: context, apiKey: 'iCi5UFsgw4FlYQZF3TbD4SmnClI7vwRw');
  }

  _selectGif(BuildContext context) {}
}
