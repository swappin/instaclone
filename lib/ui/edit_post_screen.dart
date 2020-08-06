import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/home.dart';
import 'package:instaclone/ui/location_screen.dart';
import 'package:path_provider/path_provider.dart';

class EditPostScreen extends StatefulWidget {
  final String path;
  List<int> bytes;

  EditPostScreen({this.path, this.bytes});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  PostStore _postStore = PostStore();
  TextEditingController _controller = new TextEditingController();
  var result;

  @override
  void initState() {
    super.initState();
    _postStore.focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _postStore.focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    _postStore.setFocus(_postStore.focus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 12),
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 22,
            ),
          ),
        ),
        title: Observer(builder: (_){
          return Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Text(
              _postStore.hasFocus ? "Legenda" : "Nova publicação",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          );
        }),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 12),
              width: 120,
            alignment: Alignment.centerRight,
            child: Observer(
              builder: (_){
                return _postStore.hasFocus ? GestureDetector(
                  onTap: () {
                    _postStore.setUnfocusNode();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ) : GestureDetector(
                  onTap: () {
                    _postStore.setPostLocation(
                        result != null ? result[0] + ", " + result[1] : "");
                    saveFilteredImage()
                        .then((onFile) => _postStore.uploadFile(onFile))
                        .then(
                          (onUpload) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Compartilhar",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            )
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFDDDDDD)))),
              height: 100,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                    height: 93,
                    child: Image.memory(widget.bytes),
                  ),
                  Observer(
                    builder: (_) {
                      return Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: 90,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 8),
                          child: TextFormField(
                            maxLines: null,
                            focusNode: _postStore.focus,
                            controller: _controller,
                            onChanged: _postStore.setPostDescription,
                            decoration: InputDecoration(
                                hintText: "Escreva uma legenda...",
                                hintStyle: TextStyle(
                                  color: Color(0xFF777777),
                                ),
                                contentPadding: EdgeInsets.all(12),
                                filled: true,
                                border: InputBorder.none),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    "Marcar pessoas",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFDDDDDD),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Icon(Icons.arrow_forward_ios,
                                    size: 16, color: Color(0xFFBBBBBB)),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFDDDDDD),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
//                      GestureDetector(
//                        onTap: () {},
//                        child: Container(
//                          child: Row(
//                            children: <Widget>[
//                              Expanded(
//                                child: Container(
//                                  padding: EdgeInsets.all(16),
//                                  child: Text("Marcar parceiros de negócio"),
//                                  decoration: BoxDecoration(
//                                      border: Border(
//                                          bottom: BorderSide(
//                                              color: Color(0xFFDDDDDD)))),
//                                ),
//                              ),
//                              Container(
//                                padding: EdgeInsets.all(16),
//                                child: Icon(Icons.arrow_forward_ios,
//                                    size: 16, color: Color(0xFFBBBBBB)),
//                                decoration: BoxDecoration(
//                                  border: Border(
//                                    bottom: BorderSide(
//                                      color: Color(0xFFDDDDDD),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
                      GestureDetector(
                        onTap: () {
                          getLocationContext();
                        },
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Observer(builder: (_) {
                                return result != null
                                    ? Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(result[0],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),),
                                              Text(
                                                result[1],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFDDDDDD),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFDDDDDD),
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            "Adicionar Localização",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      );
                              }),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Icon(Icons.arrow_forward_ios,
                                    size: 16, color: Color(0xFFBBBBBB)),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFFDDDDDD)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(child: Observer(builder: (_) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Facebook",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _postStore.toggleShareOnFacebook();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 16),
                                child: AnimatedContainer(
                                  width: 52,
                                  height: 32,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _postStore.shareOnFacebook
                                        ? Colors.blue
                                        : Color(0x99CCC7C8),
                                  ),
                                  alignment: _postStore.shareOnFacebook
                                      ? Alignment.centerRight
                                      : AlignmentDirectional.centerStart,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.fastOutSlowIn,
                                  child: Container(
                                    width: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Color(0x99999999),
                                          offset: Offset(0, 0),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })),
                      Container(child: Observer(
                        builder: (_) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    "Twitter",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _postStore.toggleShareOnTwitter();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 16),
                                  child: AnimatedContainer(
                                    width: 52,
                                    height: 32,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: _postStore.shareOnTwitter
                                          ? Colors.blue
                                          : Color(0x99CCC7C8),
                                    ),
                                    alignment: _postStore.shareOnTwitter
                                        ? Alignment.centerRight
                                        : AlignmentDirectional.centerStart,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.fastOutSlowIn,
                                    child: Container(
                                      width: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Color(0x99999999),
                                            offset: Offset(0, 0),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                        child: Observer(
                          builder: (_) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "Tumblr",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _postStore.toggleShareOnTumblr();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 16),
                                    child: AnimatedContainer(
                                      width: 52,
                                      height: 32,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: _postStore.shareOnTumblr
                                            ? Colors.blue
                                            : Color(0x99CCC7C8),
                                      ),
                                      alignment: _postStore.shareOnTumblr
                                          ? Alignment.centerRight
                                          : AlignmentDirectional.centerStart,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.fastOutSlowIn,
                                      child: Container(
                                        width: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Color(0x99999999),
                                              offset: Offset(0, 0),
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Configurações avançadas",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Observer(
                    builder: (_) {
                      return GestureDetector(
                        onTap: () {
                          _postStore.setUnfocusNode();
                        },
                        child: Opacity(
                          opacity: _postStore.hasFocus ? 0.75 : 0,
                          child: Container(
                            width: double.infinity,
                            height: _postStore.hasFocus ? double.infinity : 1,
                            color: Color(0xFF2b2824),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void getLocationContext() async {
    result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LocationScreen(),
          fullscreenDialog: true,
        ));
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
    await imageFile.writeAsBytes(widget.bytes);
    print("File: ${imageFile.path}");
    return imageFile;
  }
}
