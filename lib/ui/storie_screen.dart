import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:instaclone/ui/home.dart';
import 'package:instaclone/ui/storie_effect_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class StorieScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const StorieScreen({
    Key key,
    @required this.cameras,
  }) : super(key: key);

  @override
  _StorieScreenState createState() => _StorieScreenState();
}

class _StorieScreenState extends State<StorieScreen> {
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
    final size = MediaQuery.of(context).size;

    final deviceRatio = size.width / size.height;
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Transform.scale(
                      scale: controller.value.aspectRatio / deviceRatio,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: CameraPreview(controller),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.brightness_5,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                      height: 100,
                      child: Stack(
                        children: <Widget>[
//                      Container(
//                        child:
//                        ListView(
//                          scrollDirection: Axis.horizontal,
//                          children: <Widget>[
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                            Center(
//                              child:
//                              Container(
//                                  width: 60,
//                                  height: 60,
//                                  margin: EdgeInsets.only(right: 15),
//                                padding: EdgeInsets.symmetric(horizontal: 10),
//                                child: Image.network("https://www.ucan2.com.br/wp-content/uploads/2018/07/306467.png")
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                          Align(
                            alignment: Alignment.center,
                            child: FlatButton(
                              onPressed: () {
                                _captureImage(context);
                              },
                              child: Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                          color: Colors.white, width: 5)),
                                  child: Align(
                                    child: SizedBox(
                                      width: 58,
                                      height: 58,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.only(left: 5),
              child: GestureDetector(
                onTap: () {
                  print("Clicou em Biblioteca");
                },
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://petapixel.com/assets/uploads/2013/05/iTBs0eu.jpg",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 22),
                alignment: Alignment.center,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Ao Vivo",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Criar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Cenas",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Normal",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Boomerang",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Layout",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Superzoom",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Mãos Livres",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                isFrontCamera ? cameraConfiguration(0) : cameraConfiguration(1);

                isFrontCamera = !isFrontCamera;
              },
              child: Container(
                padding: EdgeInsets.all(10),
                  child: CustomIcon(
                    icon: "camera_change",
                    width: 33,
                  )),
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

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _captureImage(BuildContext context) {
    takePicture().then(
      (String filePath) async {
        if (mounted) {
          imagePath = filePath;
          if (filePath != null) {
            var imageFile = File(imagePath);
            var image = imageLib.decodeImage(imageFile.readAsBytesSync());
            image = imageLib.copyResize(image, width: 600);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StorieEffectScreen(
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

  void setCameraResult(BuildContext context) {
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

class DisplayPictureScreen extends StatelessWidget {
  final imageLib.Image image;
  final String path;

  DisplayPictureScreen({Key key, this.image, this.path}) : super(key: key);
  String fileName;
  Filter _filter;
  List<Filter> filters = presetFiltersList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.border_color,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: 60,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                },
                child: Text(
                  "Avançar",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment(0.0, 0.0),
        child: image == null
            ? new Text('No image selected.')
            : new PhotoFilterSelector(
                image: image,
                filters: presetFiltersList,
                filename: fileName,
                loader: Center(child: CircularProgressIndicator()),
              ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                width: 60,
                child: GestureDetector(
                  onTap: () {
                    print("Clicou em Filtro");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Filtro",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print("Clicou em Editar");
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Editar",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
