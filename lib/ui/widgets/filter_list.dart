//import 'package:flutter/material.dart';
//import 'package:instaclone/stores/effect_store.dart';
//import 'package:instaclone/ui/widgets/filter_item.dart';
//
//class FilterList extends StatelessWidget {
//  final List<int> image;
//  final List<int> bytes;
//  final List<String> names;
//  final List<Function> functions;
//
//  FilterList({this.image, this.bytes, this.names, this.functions});
//
//  EffectStore effectStore = EffectStore();
//
//  @override
//  Widget build(BuildContext context) {
//    print("BNytes na lista $bytes");
//    print("Names na List $names");
//    print("FUnctions na Lista $functions");
//    return Column(
//      children: <Widget>[
//        Container(
//          height: 400,
//          width: double.infinity,
//          child: Image.memory(image),
//        ),
//        Expanded(
//          child: Container(
//            child: ListView.builder(
//              scrollDirection: Axis.horizontal,
//              itemCount: bytes.length,
//              itemBuilder: (BuildContext context, int index) {
//                return FilterItem(
//                  bytes: bytes[index],
//                  name: names[index],
//                  onPressed: () => functions[index],
//                );
//              },
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
