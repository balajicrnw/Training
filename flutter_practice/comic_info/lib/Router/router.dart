import 'package:comic_info/Models/ComicModel.dart';
import 'package:comic_info/Pages/details_page.dart';
import 'package:comic_info/Router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:comic_info/Pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:comic_info/Pages/characters.dart';

class AppRouter {
  GoRouter router = GoRouter(routes: [
    GoRoute(
        name: RouterNames.home,
        path: "/",
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: MyHomePage(),
          );
        }),
    GoRoute(
        name: RouterNames.characters,
        path: "/characters",
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: CharactersPage(),
          );
        }),
    GoRoute(
        name: RouterNames.detail,
        path: "/detail/:name",
        pageBuilder: (context, state) {
          final hero = state.extra as Comicmodel;
          final charName = state.pathParameters['name'];
          return MaterialPage(
            child: DetailPage(hero: hero, charName: charName ?? " "),
          );
        })
  
  ],
      );
}
