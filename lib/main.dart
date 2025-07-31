import 'dart:developer';

import 'package:comnote/data.dart';
import 'package:comnote/models/generic.dart';
import 'package:comnote/ui/components.dart';
import 'package:comnote/ui/pages.dart';
import 'package:comnote/ui/theme.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppHandler(),
      child: const App(),
    ),
  );
}

// GoRouter Config
final _router = GoRouter(
  initialLocation: "/home",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceDim,
          appBar: TopBar(entries: topBarEntries, homeBar: state.fullPath == "/home"),
          bottomNavigationBar: BottomNavBar(
            navigationItems: navBarEntries,
            initialItemIndex: 2,
          ),
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: "/home",
          pageBuilder: (context, state) {
            return fadeTransition(
              child: HomePage(),
              state: state,
              context: context,
            );
          },
        ),
        GoRoute(
          path: "/settings",
          pageBuilder: (context, state) {
            return fadeTransition(
              child: SettingsPage(),
              state: state,
              context: context,
            );
          },
        ),
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ComNote',
      theme: comLight,
      darkTheme: comDark,
      routerConfig: _router,
    );
  }
}

void setTopList(TopBarEntry val, BuildContext context) {
  var handler = Provider.of<AppHandler>(context, listen: false);
  handler.state.currentTopList = val.value;
  handler.loadHomePageData(ranking: val.value);
}

List<TopBarEntry<SearchRanking>> topBarEntries = [
  TopBarEntry(
    label: "Top 10 Airing",
    onSelected: setTopList,
    value: SearchRanking.top10Airing
  ),
  TopBarEntry(
    label: "Just Added",
    onSelected: setTopList,
    value: SearchRanking.justAdded
  ),
];

List<NavItem> navBarEntries = [
  NavItem(
    type: NavItemType.settings,
    onSelected: (NavItemType val) {
      _router.go("/settings");
    },
    icon: Icons.settings,
  ),
  NavItem(
    type: NavItemType.community,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icons.groups,
  ),
  NavItem(
    type: NavItemType.home,
    onSelected: (NavItemType val) {
      _router.go("/home");
    },
    icon: Icons.home,
  ),
  NavItem(
    type: NavItemType.search,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icons.search,
  ),
  NavItem(
    type: NavItemType.lists,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icons.format_list_bulleted,
  ),
];
