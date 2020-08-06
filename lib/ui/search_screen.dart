import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/profile_store.dart';
import 'package:instaclone/stores/user_store.dart';
import 'package:instaclone/ui/profile_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:instaclone/ui/widgets/custom_icon_button.dart';
import 'package:instaclone/ui/widgets/custom_text_field.dart';
import 'package:instaclone/ui/widgets/navigation_bottom_bar.dart';
import 'package:instaclone/ui/widgets/storie_avatar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  UserStore userStore = UserStore();
  TextEditingController controller = TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    userStore.buildUserList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userStore.searchUser();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 38,
                        margin: EdgeInsets.fromLTRB(12, 12, 0, 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFE5E5E4)),
                        child: TextFormField(
                          controller: controller,
                          onChanged: userStore.setSearch,
                          decoration: InputDecoration(
                            icon: Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                              child: CustomIcon(
                                icon: "search_bold",
                                width: 13,
                                height: 13,
                              ),
                            ),
                            hintText: "Pesquisar",
                            hintStyle: TextStyle(color: Color(0xFF777777)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        )),
                  ],
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.75,
                        color: Color(0xFFCCCCCC)
                      )
                    )
                  ),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[Expanded(child:
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.75,
                                  color: Colors.black
                              )
                          )
                      ),
                      child:
                      Center(
                        child: Text("Principais"
                        ),
                      ),
                    ),),
                      Expanded(
                        child:
                        Center(
                          child: Text("Contas"
                          ),
                        ),
                      ),
                      Expanded(
                        child:
                        Center(
                          child: Text("Tags"
                          ),
                        ),
                      ),
                      Expanded(
                        child:
                        Center(
                          child: Text("Locais"
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(120)),
      body: Container(
        child: Observer(
          builder: (_) {
            return Scrollbar(
              child: ListView.builder(
                itemCount: userStore.userListGetter.length,
                itemBuilder: (BuildContext context, int index) {
                  print("away malhuco ${userStore.search}");
                  return Observer(
                    builder: (_) {
                      return userStore.search != null && userStore.search != ""
                          ? userStore.userListGetter[index].nickname
                                      .contains(userStore.search) ||
                                  userStore.userListGetter[index].name
                                      .contains(userStore.search)
                              ? Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      child:
                                      StorieAvatar(
                                        nickname: userStore
                                            .userListGetter[index].nickname,
                                        image:
                                        userStore.userListGetter[index].image,
                                        size: 48,
                                        borderSize: 2.5,
                                        canPost: false,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen(userStore
                                                      .userListGetter[index]
                                                      .nickname),
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            userStore
                                                .userListGetter[index].nickname,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 3,
                                          ),
                                          Text(userStore
                                              .userListGetter[index].name),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container()
                          : Container();
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
