import 'package:comnote/api.dart';
import 'package:comnote/api/login.dart';
import 'package:comnote/loginbrowser.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final Loginbrowser _loginbrowser = Loginbrowser();
  final MALApi apiClient = MALApi();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(onPressed: () async {
              var resp =(await _loginbrowser.openLogin()).getOrThrow();
              developer.log("[LOGIN_BROWSER] Code: ${resp["code"]}, Verifier: ${resp["verifier"]}");
              
              var auth_resp = (await apiClient.login.oauthAction(verifier: resp["verifier"], action: OAuthAction.authorize, code: resp["code"])).getOrThrow();
              developer.log("[AUTH] Token: ${auth_resp.accessToken}\nRefresh: ${auth_resp.refreshToken}\nExpires: ${auth_resp.expiresAt.toString()}");
            }, child: const Text("Pls click"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }
}
