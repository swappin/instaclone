import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:repositiv/app/shared/repositories/git_repo_repository.dart';
import 'package:repositiv/app/pages/favorite/favorite_page.dart';
import 'package:repositiv/app/shared/repositories/favorite_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'pages/favorite/favorite_controller.dart';
import 'pages/home/home_controller.dart';
import 'pages/home/home_page.dart';
import 'shared/utils/constants.dart';
import 'shared/repositories/git_repo_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => HomeController(repository: i.get<GitRepoRepository>())),
        Bind((i) => FavoriteController(repository: i.get<FavoriteRepository>())),
        Bind((i) => FavoriteRepository(firestore: FirebaseFirestore.instance)),
        Bind((i) => GitRepoRepository(dio: i.get<Dio>(), firestore: FirebaseFirestore.instance)),
        Bind((i) => Dio(BaseOptions(baseUrl: URL_BASE))),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        //ModularRouter(Modular.initialRoute, child: (_, args) => FavoritesPage()),
        ModularRouter('/favorite', child: (_, __) => FavoritePage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
