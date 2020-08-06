import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image/image.dart' as imageLib;
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/effect_store.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/home.dart';
import 'package:instaclone/ui/widgets/swiper.dart';
import 'package:path_provider/path_provider.dart';

class StorieEffectScreen extends StatefulWidget {
  final imageLib.Image image;
  final String path;

  StorieEffectScreen({Key key, this.image, this.path}) : super(key: key);

  @override
  _StorieEffectScreenState createState() => _StorieEffectScreenState();
}

class _StorieEffectScreenState extends State<StorieEffectScreen> {
  PostStore postStore = PostStore();
  EffectStore effectStore = EffectStore();
  List<bool> isFilterSelected = [];
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    effectStore.filterList.forEach((filter) => isFilterSelected.add(false));
    effectStore.initImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: Observer(
            builder: (_) {
              return ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: effectStore.filterList.length,
                itemBuilder: (context, index) {
                  print(effectStore.filterList[index].filterName);
                  return SwipeDetector(
                    child: Center(child: Observer(builder: (_) {
                      return Stack(
                        children: <Widget>[

                          ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child:Container(
                                width: MediaQuery.of(context).size.width,
                                height:  MediaQuery.of(context).size.height,
                                child: Image.memory(effectStore.bytes,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                effectStore.filterList[index].filterName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    Shadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                      color: Color.fromARGB(125, 0, 0, 255),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
                    onSwipeLeft: () {
                      index--;
                      if (index > 0) {
                        print(
                            "Filtro  ${index}: ${effectStore.filterList[index].filterName}");
                        effectStore.setEffect(
                            effectStore.filterList[index].filterBytes);
                        effectStore.filterList
                            .forEach((item) => item.toggledFilter = false);
                        effectStore.filterList[index].toggleFilter =
                            !effectStore.filterList[index].toggleFilter;
                      }
                    },
                    onSwipeRight: () {
                      index++;
                      if (index < effectStore.filterList.length) {
                        effectStore.setEffect(
                            effectStore.filterList[index].filterBytes);
                        effectStore.filterList
                            .forEach((item) => item.toggledFilter = false);
                        effectStore.filterList[index].toggleFilter =
                            !effectStore.filterList[index].toggleFilter;
                      }
                    },
                    swipeConfiguration: SwipeConfiguration(
                        verticalSwipeMinVelocity: 100.0,
                        verticalSwipeMinDisplacement: 50.0,
                        verticalSwipeMaxWidthThreshold: 100.0,
                        horizontalSwipeMaxHeightThreshold: 50.0,
                        horizontalSwipeMinDisplacement: 50.0,
                        horizontalSwipeMinVelocity: 100.0),
                  );
                },
              );
            },
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
            GestureDetector(
                onTap: () {},
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        margin: EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(
                              currentUserImage,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Seu Story",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )),
            GestureDetector(
                onTap: () {},
                child: Container(
                  width: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        margin: EdgeInsets.only(bottom: 6),
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.lightGreen,
                        ),
                      ),
                      Text(
                        "Amigos Próximos",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 110,
                    height: 44,
                    child: GestureDetector(
                      onTap: () {saveFilteredImage()
                          .then((onFile) => postStore.uploadStorie(onFile))
                          .then(
                            (onUpload) =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            ),
                      );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Enviar para",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                ),
                              ),
                            ],
                          )),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );

  }

  Future<String> get _localPath async {
    print("_localPath");
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    print("_localFile");
    final path = await _localPath;
    return File(widget.path);
  }

  Future<File> saveFilteredImage() async {
    print("saveFilteredImage");
    var imageFile = await _localFile;
    await imageFile.writeAsBytes(effectStore.bytes);
    print("File: ${imageFile.path}");
    return imageFile;
  }
}
