import 'package:comnote/data.dart';
import 'package:comnote/loginbrowser.dart';
import 'package:comnote/ui/components.dart';
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
  routes: [GoRoute(path: '/', builder: (context, state) => HomePage())],
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

List<TopBarEntry> topBarEntries = [
  TopBarEntry(
    label: "Top 10 Airing",
    onSelected: (TopBarEntry val) {
      print(val);
    },
  ),
  TopBarEntry(
    label: "Just Added",
    onSelected: (TopBarEntry val) {
      print(val);
    },
  ),
];

List<NavItem> navBarEntries = [
  NavItem(
    type: NavItemType.settings,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icon(Icons.settings, size: 48.0),
  ),
  NavItem(
    type: NavItemType.community,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icon(Icons.groups, size: 48.0),
  ),
  NavItem(
    type: NavItemType.home,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icon(Icons.home, size: 48.0),
  ),
  NavItem(
    type: NavItemType.search,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icon(Icons.search, size: 48.0),
  ),
  NavItem(
    type: NavItemType.lists,
    onSelected: (NavItemType val) {
      print(val);
    },
    icon: Icon(Icons.format_list_bulleted, size: 48.0),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Loginbrowser _loginbrowser = Loginbrowser();

  @override
  void initState() {
    super.initState();
    Provider.of<AppHandler>(context, listen: false).load_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: TopBar(entries: topBarEntries),
      bottomNavigationBar: BottomNavBar(
        navigationItems: navBarEntries,
        initialItemIndex: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<AppHandler>(
              builder: (context, state, child) {
                if (!state.state.login.loggedIn) {
                  return const Text("You're not logged in!");
                }
                return const Text("Woah you're actually logged in!?");
              },
            ),
            ComButton(
              onPressed: () async {
                var resp = (await _loginbrowser.openLogin()).getOrThrow();
                await Provider.of<AppHandler>(
                  context,
                  listen: false,
                ).login(resp);
              },
              content: "Pls click",
            ),
          ],
        ),
      ),
    );
  }
}
