import 'package:flutter/material.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';

const AR_KIT_KEY =
    "69122d4f1038b2d791da418d346267273e1fe1151a01da6cf454eb3958f73210ef092d3293081a8a";

class ARService extends StatefulWidget {
  @override
  _ARServiceState createState() => _ARServiceState();
}

class _ARServiceState extends State<ARService> {
  CameraDeepArController cameraDeepArController;
  int effectCount = 0;
  String _platformVersion = 'Unknown';
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('DeepAR Camera Example'),
      ),
      body: Stack(
        children: [
          CameraDeepAr(
              onCameraReady: (isReady) {
                _platformVersion = "Camera status $isReady";
                setState(() {});
              },
              onImageCaptured: (path) {
                _platformVersion = "Image Taken @ $path";
                setState(() {});
              },
              onVideoRecorded: (path) {
                _platformVersion = "Video Recorded @ $path";
                isRecording = false;
                setState(() {});
              },
              androidLicenceKey: AR_KIT_KEY,
              iosLicenceKey: AR_KIT_KEY,
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              }),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(20),
              child: FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                child: Icon(Icons.navigate_next_outlined),
                onPressed: () {
                  cameraDeepArController.changeMask(effectCount);
                  if (effectCount == 7) {
                    effectCount = 0;
                  }
                  print(effectCount);
                  effectCount++;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
