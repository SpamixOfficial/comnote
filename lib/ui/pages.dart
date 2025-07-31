import 'package:comnote/data.dart';
import 'package:comnote/loginbrowser.dart';
import 'package:comnote/models/generic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var state = Provider.of<AppHandler>(context, listen: false);
    state.load_data();
    state.loadHomePageData(ranking: SearchRanking.top10Airing);
  }

  @override
  Widget build(BuildContext context) {
    /*return Center(
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
              await Provider.of<AppHandler>(context, listen: false).login(resp);
            },
            content: "Pls click",
          ),
        ],
      ),
    );*/

    return Center(
      child: Consumer<AppHandler>(
        builder: (context, value, child) => ListView(
          itemExtent: 20.0,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Loginbrowser _loginbrowser = Loginbrowser();

  @override
  void initState() {
    super.initState();
    Provider.of<AppHandler>(context, listen: false).load_data();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[const Text("Rich bitch")],
      ),
    );
  }
}
