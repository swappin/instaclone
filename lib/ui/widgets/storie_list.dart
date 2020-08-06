import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/stores/storie_store.dart';
import 'package:instaclone/ui/widgets/storie_avatar.dart';

class StorieList extends StatefulWidget {
  @override
  _StorieListState createState() => _StorieListState();
}

class _StorieListState extends State<StorieList> {
  StorieStore storieStore = StorieStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    storieStore.getFollowingStories();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return storieStore.storieList.length > 0
            ? Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 1,
                  color: Color(0xFFCCCCCC),
                ))),
                width: double.infinity,
                height: 104,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: storieStore.storieList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: StorieAvatar(
                              nickname: storieStore
                                  .storieList[index].storieUserNickname,
                              image:
                                  storieStore.storieList[index].storieUserImage,
                              size: 62,
                              borderSize: 3,
                              canPost: true,
                            ),
                          ),
                          Container(
width: 70,
                            padding: EdgeInsets.only(top: 5),
                            alignment: Alignment.center,
                            child: Text(
                              storieStore.storieList[index].storieUserNickname,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Container();
      },
    );
  }
}
