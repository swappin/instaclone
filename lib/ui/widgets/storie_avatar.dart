import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/stores/storie_store.dart';
import 'package:instaclone/ui/storie_watch_screen.dart';

import '../profile_screen.dart';

class StorieAvatar extends StatefulWidget {
  final String nickname;
  final String image;
  final double size;
  final double borderSize;
  final bool canPost;

  StorieAvatar({this.nickname, this.image, this.size, this.borderSize, this.canPost});

  @override
  _StorieAvatarState createState() => _StorieAvatarState();
}

class _StorieAvatarState extends State<StorieAvatar> {
  StorieStore storieStore = StorieStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    storieStore.getStories(widget.nickname);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(builder: (_) {
        return storieStore.hasStorie
            ? GestureDetector(onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  StorieWatchScreen(storieStore.storieList,
                    widget.nickname,
                    widget.image
                  ),
            ),
          );
        }, child:
        Container(
          width: widget.size + widget.borderSize,
          height:widget.size + widget.borderSize,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9, 0.5],
              colors: [
                Color(0xFF515BD4),
                Color(0xFF8134AF),
                Color(0xFFDD2A7B),
                Color(0xFFFEDA77),
                Color(0xFFF58529),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover),
              color: Colors.grey,
              border: Border.all(
                color: Colors.white,
                width: widget.borderSize,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),)
            : GestureDetector(
          onTap: (){

          },
          child:
          widget.canPost ? Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(widget.borderSize),
                width: widget.size - widget.borderSize,
                height:widget.size - widget.borderSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.image),
                        fit: BoxFit.cover),
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(
                            65))),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 19,
                  height: 19,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius:
                    BorderRadius.all(
                      Radius.circular(18),
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ) : Container(
            margin: EdgeInsets.all(widget.borderSize),
            width: widget.size - widget.borderSize,
            height:widget.size - widget.borderSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        );
      }),
    );
  }
}
