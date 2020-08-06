import 'package:camera/camera.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/stores/profile_store.dart';
import 'package:instaclone/ui/conversation_screen.dart';
import 'package:instaclone/ui/storie_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';

class ProfileScreen extends StatefulWidget {
  final String nickname;

  ProfileScreen(this.nickname);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PostStore postStore = PostStore();
  ProfileStore profileStore = ProfileStore();
  static List<CameraDescription> cameras;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Future<void> initCamera() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postStore.getDescriptionLanguage();
    profileStore.builtUserProfile(widget.nickname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 20,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      print("Clicou no nickname para trocar de conta");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.nickname == currentUserNickname
                            ? Icon(
                                Icons.lock,
                                color: Colors.black,
                                size: 16,
                              )
                            : Container(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            widget.nickname,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        widget.nickname == currentUserNickname
                            ? Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 6),
                  width: 70,
                  child: GestureDetector(
                    onTap: () {
                      print("Clicou no Menu do canto superior direito");
                    },
                    child: Container(
                        child: CustomIcon(
                      icon: "menu",
                      width: 21,
                    )),
                  ),
                )
              ],
            ),
          )),
      body: Container(
        child: Observer(
          builder: (_) {
            return profileStore.profile.image != null
                ? CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            initCamera().then(
                                              (onInitialize) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          StorieScreen(
                                                        cameras: cameras,
                                                      ),
                                                    ));
                                              },
                                            );
                                            print("Abriu edição do perfil");
                                          },
                                          onLongPress: () {
                                            print("Abriu edição do perfil");
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 15),
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  width: 75,
                                                  height: 75,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              profileStore
                                                                  .profile
                                                                  .image),
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
                                                    width: 26,
                                                    height: 26,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blueAccent,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(65),
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 16,
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
                                            print("Clicou em Publicações");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  profileStore.profile.posts,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                Text(
                                                  "Publicações",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print("Clicou em Seguidores");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: <Widget>[
                                                Observer(builder: (_) {
                                                  //PEsquisar o porque da reação apnas ocorrer com o isFollowing
                                                  return profileStore
                                                          .isFollowing
                                                      ? Text(
                                                          profileStore.profile
                                                              .followers,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,

                                                          ),
                                                        )
                                                      : Text(
                                                          profileStore.profile
                                                              .followers,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        );
                                                }),
                                                Text(
                                                  "Seguidores",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print("Clicou em Seguindo");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  profileStore
                                                      .profile.following,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                Text(
                                                  "Seguindo",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(child: Observer(builder: (_) {
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            profileStore.profile.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        profileStore.profile.bio != null &&
                                                profileStore.profile.bio != ""
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    profileStore.profile.bio),
                                              )
                                            : Container(),
                                        profileStore.profile.website != null &&
                                                profileStore.profile.website !=
                                                    ""
                                            ? GestureDetector(
                                                onTap: () {
                                                  postStore.launchURL();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    profileStore
                                                        .profile.website,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF093d75),
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        profileStore.isForeignLanguage
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                alignment: Alignment.centerLeft,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    profileStore.isTranslated !=
                                                            true
                                                        ? profileStore
                                                            .translateToUserNativeLanguage(
                                                                profileStore
                                                                    .profile
                                                                    .bio)
                                                        : profileStore
                                                            .translateToOriginalLanguage(
                                                                profileStore
                                                                    .profile
                                                                    .bio);
                                                  },
                                                  child: Text(
                                                    profileStore.isTranslated !=
                                                            false
                                                        ? "Ver original"
                                                        : "Ver tradução",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Observer(builder: (_) {
                                          return profileStore
                                                      .profile.nickname ==
                                                  currentUserNickname
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(top: 14),
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 30,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFBBBBBB),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Text(
                                                        "Editar Perfil",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : profileStore.isFollowing
                                                  ? Container(
                                                      child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              profileStore
                                                                  .unfollowUser(
                                                                      widget
                                                                          .nickname);
                                                            },
                                                            child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              Colors.grey,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Seguindo",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down,
                                                                      size: 18,
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ConversationScreen(
                                                                          profileStore
                                                                              .profile
                                                                              .nickname,
                                                                          profileStore
                                                                              .profile
                                                                              .image)));
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                              child: Text(
                                                                "Mensagem",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            alignment: Alignment
                                                                .center,
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                            child: Icon(Icons
                                                                .keyboard_arrow_down),
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                                  : Container(
                                                      child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              profileStore
                                                                  .followUser(widget
                                                                      .nickname);
                                                            },
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Text(
                                                                "Seguir",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => ConversationScreen(
                                                                      profileStore
                                                                          .profile
                                                                          .nickname,
                                                                      profileStore
                                                                          .profile
                                                                          .image),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                              child: Text(
                                                                "Mensagem",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            alignment: Alignment
                                                                .center,
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                            child: Icon(Icons
                                                                .keyboard_arrow_down),
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                        })
                                      ],
                                    );
                                  })),
                                ],
                              ),
                            ),
                            widget.nickname == currentUserNickname
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xFFDBDBDB),
                                    ))),
                                    padding: EdgeInsets.only(left: 20),
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Destaque dos stories",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                              "Mantenha suas histórias favoritas no  seu perfil"),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 12),
                                          height: 105,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: 12,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return index == 0
                                                        ? Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                print(
                                                                    "Clicou no botão Novo para Add um Storie Salvo");
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    width: 60,
                                                                    height: 60,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(60)),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      size: 30,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                4),
                                                                    child: Text(
                                                                      "Novo",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                print(
                                                                    "Clicou nos stories para add um storie salvo");
                                                              },
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    width: 60,
                                                                    height: 60,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFFDDDDDD),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(60)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                4),
                                                                    child: Text(
                                                                      "",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              padding: EdgeInsets.all(1),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print(
                                            "Clicou para ver as fotos do feed do usuário");
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            width: 1.5,
                                            color: Color(0xFF666666),
                                          ))),
                                          alignment: Alignment.center,
                                          child: CustomIcon(
                                            icon: "grid",
                                            width: 20,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print(
                                            "Clicou para ver as fotos do feed do usuário");
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: CustomIcon(
                                            icon: "files",
                                            width: 24,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              print(
                                  "Clicou aqui na foto para abrir o feed do usuário");
                            },
                            onLongPress: () {
                              print("Segurou o clique para pré-visualizar");
                            },
                            child: Container(
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(profileStore
                                          .profile.postList[index].postImage),
                                      fit: BoxFit.cover),
                                  border: Border.all(
                                      color: Colors.white, width: 0.5)),
                            ),
                          );
                        }, childCount: profileStore.profile.postList.length),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
