import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image/image.dart' as imageLib;
import 'package:instaclone/models/filter.dart';
import 'package:instaclone/stores/effect_store.dart';
import 'package:instaclone/ui/edit_post_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:instaclone/ui/widgets/filter_item.dart';
import 'package:instaclone/ui/widgets/filter_list.dart';

class EffectScreen extends StatefulWidget {
  final imageLib.Image image;
  final String path;

  EffectScreen({this.image, this.path});

  @override
  _EffectScreenState createState() => _EffectScreenState();
}

class _EffectScreenState extends State<EffectScreen> {
  EffectStore effectStore = EffectStore();
  List<bool> isFilterSelected = [];

  @override
  void initState() {
    super.initState();
    effectStore.filterList.forEach((filter) => isFilterSelected.add(false));
    effectStore.initImage(widget.image);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 22,
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: CustomIcon(
            icon: "edit_effect",
            width: 22,
          )
        ),
        actions: <Widget>[
          Observer(builder: (_){
            return Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPostScreen(
                        path: widget.path,
                        bytes: effectStore.bytes,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Avançar",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            );
          })
        ],
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          return effectStore.filterList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.memory(effectStore.bytes),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: effectStore.filterList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  effectStore.setEffect(effectStore
                                      .filterList[index].filterBytes);
                                  effectStore.filterList.forEach((item) => item.toggledFilter = false);
                                  effectStore.filterList[index].toggleFilter =
                                      !effectStore
                                          .filterList[index].toggleFilter;
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: index == 0 ?  18 : 0, right: index == effectStore.filterList.length - 1 ?  18 : 0),
                                  child: FilterItem(
                                    bytes:
                                    effectStore.filterList[index].filterBytes,
                                    name:
                                    effectStore.filterList[index].filterName,
                                    isFilterSelected: effectStore
                                        .filterList[index].toggleFilter,
                                  ),
                                )
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : CircularProgressIndicator();
        },
      ),
      //body: FilterList(image: effectStore.bytes, bytes: effectStore.filterList., names: effectStore.filterNameList, functions: effectStore.filterFunctionList,),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            Expanded(
                child: GestureDetector(
              onTap: () {
                print("Clicou em Editar");
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "Filtro",
                  style: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 16
                  ),
                ),
              ),
            )),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print("Clicou em Editar");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                    "Editar",
                    style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 16,
                    color: Color(0xFF888888)),
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
