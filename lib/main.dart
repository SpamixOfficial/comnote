import 'package:comnote/data.dart';
import 'package:comnote/loginbrowser.dart';
import 'package:comnote/ui/components.dart';
import 'package:comnote/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppHandler(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: comLight,
      darkTheme: comDark,
      home: const HomePage(title: 'Flutter Demo Home Page'),
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
];

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

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
