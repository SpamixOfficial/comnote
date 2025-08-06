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
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppHandler>(create: (_) => AppHandler()),
        ChangeNotifierProvider<ElementsDraw>(create: (_) => ElementsDraw()),
      ],
      child: App(),
    ),
  );
}

// GoRouter Config
final _router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(path: "/", redirect: (_, _) => "/home"),
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceDim,
          appBar: TopBar(
            entries: topBarEntries,
            homeBar: state.fullPath == "/home",
          ),
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
    GoRoute(
      path: "/settings/content",
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: "/settings/account",
      builder: (context, state) => const Placeholder(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var handler = Provider.of<AppHandler>(context, listen: false);
    var elementDraw = Provider.of<ElementsDraw>(context, listen: false);
    handler.elementsState = elementDraw; // set handler child rq;

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
  handler.loadHomePageData(ranking: val.value, updateChosenList: true);
}

List<TopBarEntry<SearchRanking>> topBarEntries = [
  TopBarEntry(
    label: "Now Watching",
    onSelected: setTopList,
    value: SearchRanking.nowWatching,
  ),
  TopBarEntry(
    label: "Trending",
    onSelected: setTopList,
    value: SearchRanking.trending,
  ),
  TopBarEntry(
    label: "Just Added",
    onSelected: setTopList,
    value: SearchRanking.justAdded,
  ),
  TopBarEntry(
    label: "Top 10 Airing",
    onSelected: setTopList,
    value: SearchRanking.top10Airing,
  ),
  TopBarEntry(
    label: "Top 10 Upcoming",
    onSelected: setTopList,
    value: SearchRanking.top10Upcoming,
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
