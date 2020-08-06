import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:instaclone/stores/effect_store.dart';
import 'package:instaclone/ui/filter_screen.dart';
import 'package:instaclone/ui/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as imageLib;

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String imagePath;
  CameraController controller;
  bool isFrontCamera = false;

  cameraConfiguration(int index) {
    controller =
        CameraController(widget.cameras[index], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    onCameraSelected(widget.cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cameras.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No Camera Found',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      );
    }

    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 70,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Foto",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                width: 70,
                color: Colors.blue,
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              isFrontCamera
                                  ? cameraConfiguration(0)
                                  : cameraConfiguration(1);

                              isFrontCamera = !isFrontCamera;
                            },
                            child: CustomIcon(
                              icon: "loop",
                              width: 29,
                            )
                        ),
                        GestureDetector(
                            onTap: () {
                              isFrontCamera
                                  ? cameraConfiguration(0)
                                  : cameraConfiguration(1);

                              isFrontCamera = !isFrontCamera;
                            },
                            child: Icon(
                              Icons.flash_off,
                              color: Colors.white,
                              size: 30,
                            ),
                        ),
                      ],
                    )
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD2D4D5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _captureImage();
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x22222222),
                                        blurRadius: 8,
                                        spreadRadius: 4,
                                        offset: Offset(
                                          0,
                                          0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 18),
              width: MediaQuery.of(context).size.width * 0.25,
              child: GestureDetector(
                onTap: () {
                  print("Clicou em Biblioteca");
                },
                child: Text(
                  "Biblioteca",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Foto",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 18),
              width: MediaQuery.of(context).size.width * 0.25,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  print("Clicou em Biblioteca");
                },
                child: Text(
                  "Video",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showMessage('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showException(e);
    }

    if (mounted) setState(() {});
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  EffectStore effectStore = EffectStore();

  Future<void> _captureImage() {
    takePicture().then(
      (String filePath) async {
        if (mounted) {
          imagePath = filePath;
          if (filePath != null) {
            var imageFile = File(imagePath);
            var image = imageLib.decodeImage(imageFile.readAsBytesSync());
            image = imageLib.copyResize(image, width: 600);
            image = imageLib.copyCrop(image, 0, 0, 600, 600);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EffectScreen(
                  image: image,
                  path: imagePath,
                ),
              ),
            );
          }
        }
      },
    );
  }

  void setCameraResult() {
    Navigator.pop(context, imagePath);
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showMessage('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Images';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      showException(e);
      return null;
    }
    print("hsauhsauashuas $filePath");
    return filePath;
  }

  void showException(CameraException e) {
    logError(e.code, e.description);
    showMessage('Error: ${e.code}\n${e.description}');
  }

  void showMessage(String message) {
    print(message);
  }

  void logError(String code, String message) =>
      print('Error: $code\nMessage: $message');
}
