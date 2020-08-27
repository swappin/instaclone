import 'package:flutter/material.dart';
import 'package:repositiv/app/pages/favorite/favorite_controller.dart';
import 'package:repositiv/app/shared/models/git_repo_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';


class FavoritePage extends StatefulWidget {

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends ModularState<FavoritePage, FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: Observer(builder: (_) {
        if (controller.favoriteList.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.favoriteList.hasError) {
          return Center(
            child: RaisedButton(
              onPressed: controller.getList,
              child: Text('Error'),
            ),
          );
        } else {
          List<GitRepoModel> list = controller.favoriteList.data;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var model = list[index];
                return ListTile(
                  onTap: () {
                  },
                  title: Text(model.name),
                  leading: IconButton(
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      controller.delete(model);
                    },
                  ),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (v) {
                    },
                  ),
                );
              });
        }
      }),
    );
  }

}
