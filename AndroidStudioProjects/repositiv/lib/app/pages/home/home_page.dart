import 'package:flutter/material.dart';
import 'package:repositiv/app/shared/models/git_repo_model.dart';
import 'package:repositiv/app/pages/home/home_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repositórios'),
        actions: [
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Modular.to.pushNamed('/favorite');
              },
              child: Observer(builder: (_) {
                return Text('H ${controller.totalFavorite}');
              }),
            ),
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.gitRepo.error != null) {
            return Center(
              child: RaisedButton(
                onPressed: () {
                  controller.fetchGitRepos();
                },
                child: Text('Tente Novamente'),
              ),
            );
          } else if (controller.gitRepo.value == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var list = controller.gitRepo.value;

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(list[index].name),
                    ),
                    FlatButton(
                      child: Text("Salvar Repositório"),
                      onPressed: () {
                        GitRepoModel model = GitRepoModel();
                        model.id = list[index].id;
                        model.name = list[index].name;
                        model.description = list[index].description;
                        model.language = list[index].language;
                        model.createdAt = list[index].createdAt;
                        model.stargazersCount = list[index].stargazersCount;
                        controller.saveRepo(model);
                        //Modular.to.pushNamed('/favorites');
                        _showDialog();
                      },
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _showDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert Dialog titulo"),
          content: Observer(builder: (_){
            if(controller.isTotalIncreased) return Text("Repositório Adicionado com Sucesso!");
            else return Text("Repositório já foi favoritado anteriormente. Visite seus favoritos!");
          }),
          actions: <Widget>[
            FlatButton(
              child: Text("Ver"),
              onPressed: () {
                Modular.to.pushNamed("/favorite");
              },
            ),
            // define os botões na base do dialogo
            FlatButton(
              child: Text("Fechar"),
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
