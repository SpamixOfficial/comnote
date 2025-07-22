import 'dart:convert';
import 'dart:io';

import 'package:comnote/api.dart';
import 'package:comnote/api/login.dart';
import 'package:comnote/models/state.dart';

import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

import 'package:result_dart/result_dart.dart';
import 'package:path_provider/path_provider.dart';

class PreferencesHandler extends ChangeNotifier {
  AppState state = AppState();
  final MALApi apiClient = MALApi();
  File? stateFile;

  bool get loggedIn => state.login.loggedIn;

  Future<bool> login(Map<String, dynamic> loginBrowserResponse) async {
    developer.log(
      "[LOGIN_BROWSER] Code: ${loginBrowserResponse["code"]}, Verifier: ${loginBrowserResponse["verifier"]}",
    );

    var authResp = await apiClient.login.oauthAction(
      verifier: loginBrowserResponse["verifier"],
      action: OAuthAction.authorize,
      code: loginBrowserResponse["code"],
    );

    if (authResp.isError()) {
      state.login.loggedIn = false;
      return false;
    }

    var authRespValue = authResp.getOrThrow();
    state.login.loggedIn = true;
    state.login.expires = authRespValue.expiresAt;
    state.login.refreshToken = authRespValue.refreshToken;
    state.login.token = authRespValue.accessToken;

    apiClient.setLoginState(state.login);

    notifyListeners();

    return true;
  }

  Future<Result<File>> get_statefile() async {
    if (stateFile == null) {
      var docPath = (await getApplicationDocumentsDirectory()).path;
      File f = File("${docPath}/state.json");
      stateFile = f;
    }

    return Success(stateFile!); // should be safe
  }

  Future<Result<()>> load_data() async {
    File sFile = (await get_statefile()).getOrThrow();
    var contents = await sFile.readAsString();
    var jsonContents = jsonDecode(contents);
    state = AppState.fromJson(jsonContents);

    if (state.login.loggedIn) {
      apiClient.setLoginState(state.login);
    }

    return Success(());
  }

  Future<Result<()>> save_data() async {
    File sFile = (await get_statefile()).getOrThrow();
    var contents = state.toJson();

    stateFile = await sFile.writeAsString(jsonEncode(contents));
    return Success(());
  }
}
