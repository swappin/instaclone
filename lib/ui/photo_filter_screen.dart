//import 'dart:async';
//import 'dart:io';
//
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:instaclone/stores/post_store.dart';
//import 'package:instaclone/ui/edit_post_screen.dart';
//import 'package:photofilters/filters/filters.dart';
//import 'package:image/image.dart' as imageLib;
//import 'package:path_provider/path_provider.dart';
//
//class PhotoFilter extends StatelessWidget {
//  final imageLib.Image image;
//  final String filename;
//  final Filter filter;
//  final BoxFit fit;
//  final Widget loader;
//
//  PhotoFilter({
//    @required this.image,
//    @required this.filename,
//    @required this.filter,
//    this.fit = BoxFit.fill,
//    this.loader = const Center(child: CircularProgressIndicator()),
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<List<int>>(
//      future: compute(applyFilter, <String, dynamic>{
//        "filter": filter,
//        "image": image,
//        "filename": filename,
//      }),
//      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//            return loader;
//          case ConnectionState.active:
//          case ConnectionState.waiting:
//            return loader;
//          case ConnectionState.done:
//            if (snapshot.hasError)
//              return Center(child: Text('Error: ${snapshot.error}'));
//            return Image.memory(
//              snapshot.data,
//              fit: fit,
//            );
//        }
//        return null; // unreachable
//      },
//    );
//  }
//}
//
/////The PhotoFilterSelector Widget for apply filter from a selected set of filters
//class PhotoFilterSelector extends StatefulWidget {
//  final Widget title;
//
//  final List<Filter> filters;
//  final imageLib.Image image;
//  final Widget loader;
//  final BoxFit fit;
//  final String filename;
//  final bool circleShape;
//
//  const PhotoFilterSelector({
//    Key key,
//    @required this.title,
//    @required this.filters,
//    @required this.image,
//    this.loader = const Center(child: CircularProgressIndicator()),
//    this.fit = BoxFit.fill,
//    @required this.filename,
//    this.circleShape = false,
//  }) : super(key: key);
//
//  @override
//  State<StatefulWidget> createState() => new _PhotoFilterSelectorState();
//}
//
//class _PhotoFilterSelectorState extends State<PhotoFilterSelector> {
//  PostStore postStore = PostStore();
//  String filename;
//  Map<String, List<int>> cachedFilters = {};
//  Filter _filter;
//  imageLib.Image blaImage;
//  bool loading;
//
//  @override
//  void initState() {
//    super.initState();
//    loading = false;
//    _filter = widget.filters[0];
//    filename = widget.filename;
//    blaImage = widget.image;
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        backgroundColor: Colors.white,
//        elevation: 0,
//        title: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              child: GestureDetector(
//                onTap: () {},
//                child: Icon(
//                  Icons.arrow_back_ios,
//                  color: Colors.black,
//                ),
//              ),
//            ),
//            Expanded(
//              child: Container(
//                alignment: Alignment.center,
//                child: Icon(
//                  Icons.border_color,
//                  color: Colors.black,
//                ),
//              ),
//            ),
//            Container(
//              width: 60,
//              child: GestureDetector(
//                onTap: () {
//                  saveFilteredImage().then(
//                    (onSave) {
//                      print(onSave);
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => EditPostScreen(image: onSave),
//                        ),
//                      );
//                    }
//                  );
//                },
//                child: Text(
//                  "Avançar",
//                  style: TextStyle(color: Colors.blueAccent, fontSize: 13),
//                ),
//              ),
//            ),
//          ],
//        ),
//        centerTitle: true,
//      ),
//      body: Container(
//        width: double.infinity,
//        height: double.infinity,
//        child: loading
//            ? widget.loader
//            : Column(
//                mainAxisSize: MainAxisSize.max,
//                children: [
//                  Expanded(
//                    flex: 6,
//                    child: Container(
//                      width: double.infinity,
//                      height: double.infinity,
//                      child: _buildFilteredImage(
//                        _filter,
//                        blaImage,
//                        filename,
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    flex: 4,
//                    child: Container(
//                      padding: EdgeInsets.only(top: 40),
//                      child: ListView.builder(
//                        scrollDirection: Axis.horizontal,
//                        itemCount: widget.filters.length,
//                        itemBuilder: (BuildContext context, int index) {
//                          return InkWell(
//                            child: Container(
//                              padding: EdgeInsets.all(5.0),
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: <Widget>[
//                                  Text(
//                                    widget.filters[index].name,
//                                  ),
//                                  _buildFilterThumbnail(
//                                      widget.filters[index], blaImage, filename),
//                                  SizedBox(
//                                    height: 5.0,
//                                  ),
//                                ],
//                              ),
//                            ),
//                            onTap: () => setState(() {
//                              _filter = widget.filters[index];
//                            }),
//                          );
//                        },
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//      ),
//      bottomNavigationBar: Container(
//        width: double.infinity,
//        height: 60,
//        padding: EdgeInsets.all(10),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Expanded(
//              child: Container(
//                width: 60,
//                child: GestureDetector(
//                  onTap: () {
//                    print("Clicou em Filtro");
//                  },
//                  child: Container(
//                    alignment: Alignment.center,
//                    child: Text(
//                      "Filtro",
//                      style: TextStyle(
//                        fontSize: 15,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.black,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            Expanded(
//              child: GestureDetector(
//                onTap: () {
//                  print("Clicou em Editar");
//                },
//                child: Container(
//                  alignment: Alignment.center,
//                  child: Text(
//                    "Editar",
//                    style: TextStyle(
//                      fontSize: 15,
//                      fontWeight: FontWeight.bold,
//                      color: Colors.grey,
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  _buildFilterThumbnail(Filter filter, imageLib.Image image, String filename) {
//    if (cachedFilters[filter?.name ?? "_"] == null) {
//      print("2 PASSOU AQUI");
//      return FutureBuilder<List<int>>(
//        future: compute(applyFilter, <String, dynamic>{
//          "filter": filter,
//          "image": image,
//          "filename": filename,
//        }),
//        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
//          switch (snapshot.connectionState) {
//            case ConnectionState.none:
//            case ConnectionState.active:
//            case ConnectionState.waiting:
//              return Container(
//                width: 100,
//                height: 100,
//                child: Center(
//                  child: widget.loader,
//                ),
//                color: Colors.white,
//              );
//            case ConnectionState.done:
//              if (snapshot.hasError)
//                return Center(child: Text('Error: ${snapshot.error}'));
//              cachedFilters[filter?.name ?? "_"] = snapshot.data;
//              return Container(
//                width: 100,
//                height: 100,
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  image: DecorationImage(
//                    image: MemoryImage(
//                      snapshot.data,
//                    ),
//                    fit: BoxFit.cover,
//                  ),
//                ),
//              );
//          }
//          return null; // unreachable
//        },
//      );
//    } else {
//      print("1 PASSOU AQUI");
//      return Container(
//        width: 100,
//        height: 100,
//        decoration: BoxDecoration(
//          color: Colors.white,
//          image: DecorationImage(
//            image: MemoryImage(
//              cachedFilters[filter?.name ?? "_"],
//            ),
//            fit: BoxFit.cover,
//          ),
//        ),
//      );
//    }
//  }
//
//  Future<String> get _localPath async {
//    print("_localPath");
//    final directory = await getApplicationDocumentsDirectory();
//
//    return directory.path;
//  }
//
//  Future<File> get _localFile async {
//    print("_localFile");
//    final path = await _localPath;
//    return File('$path/filtered_${_filter?.name ?? "_"}_$filename');
//  }
//
//  Future<File> saveFilteredImage() async {
//    print("saveFilteredImage");
//    var imageFile = await _localFile;
//    await imageFile.writeAsBytes(cachedFilters[_filter?.name ?? "_"]);
//    return imageFile;
//  }
//
//  Widget _buildFilteredImage(
//      Filter filter, imageLib.Image image, String filename) {
//    print("buildFilteredImage");
//    if (cachedFilters[filter?.name ?? "_"] == null) {
//      return FutureBuilder<List<int>>(
//        future: compute(applyFilter, <String, dynamic>{
//          "filter": filter,
//          "image": image,
//          "filename": filename,
//        }),
//        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
//          switch (snapshot.connectionState) {
//            case ConnectionState.none:
//              return widget.loader;
//            case ConnectionState.active:
//            case ConnectionState.waiting:
//              return widget.loader;
//            case ConnectionState.done:
//              if (snapshot.hasError)
//                return Center(child: Text('Error: ${snapshot.error}'));
//              cachedFilters[filter?.name ?? "_"] = snapshot.data;
//
//              print("buildFilteredImage 124233432434232");
//              return widget.circleShape
//                  ? SizedBox(
//                      height: MediaQuery.of(context).size.width / 3,
//                      width: MediaQuery.of(context).size.width / 3,
//                      child: Center(
//                        child: CircleAvatar(
//                          radius: MediaQuery.of(context).size.width / 3,
//                          backgroundImage: MemoryImage(
//                            snapshot.data,
//                          ),
//                        ),
//                      ),
//                    )
//                  : Image.memory(
//                      snapshot.data,
//                      fit: BoxFit.cover,
//                    );
//          }
//          print("buildFilteredImage 222222222");
//          return null;
//        },
//      );
//    } else {
//      print("buildFilteredImage 87767676767766776");
//
//      return widget.circleShape
//          ? SizedBox(
//              height: MediaQuery.of(context).size.width / 3,
//              width: MediaQuery.of(context).size.width / 3,
//              child: Center(
//                child: CircleAvatar(
//                  radius: MediaQuery.of(context).size.width / 3,
//                  backgroundImage: MemoryImage(
//                    cachedFilters[filter?.name ?? "_"],
//                  ),
//                ),
//              ),
//            )
//          : Image.memory(
//              cachedFilters[filter?.name ?? "_"],
//              fit: BoxFit.cover,
//              //fit: widget.fit,
//            );
//    }
//  }
//}
//
/////The global applyfilter function
//Future<List<int>> applyFilter(Map<String, dynamic> params) async {
//  print("applyFilters");
//  Filter filter = await params["filter"];
//  imageLib.Image image = await params["image"];
//  String filename = await params["filename"];
//  List<int> _bytes = image.getBytes();
//  if (filter != null) {
//    filter.apply(_bytes);
//  }
//  imageLib.Image _image =
//      imageLib.Image.fromBytes(image.width, image.height, _bytes);
//  _bytes = imageLib.encodeNamedImage(_image, filename);
//
//  return _bytes;
//}
//
//Future<List<int>> buildThumbnail(Map<String, dynamic> params) {
//  print("buildThumbnil");
//  int width = params["width"];
//  params["image"] = imageLib.copyResize(params["image"], width: width);
//  return applyFilter(params);
//}
