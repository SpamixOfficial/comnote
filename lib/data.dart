import 'dart:convert';
import 'dart:io';

import 'package:comnote/api.dart';
import 'package:comnote/api/login.dart';
import 'package:comnote/models/state.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;

import 'package:result_dart/result_dart.dart';
import 'package:path_provider/path_provider.dart';

class PreferencesHandler extends ChangeNotifier {
  AppState state = AppState();
  final MALApi apiClient = MALApi();
  File? stateFile;
  FlutterSecureStorage? storage;

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

    (await save_data()).getOrThrow();

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

  Result<FlutterSecureStorage> get_storage() {
    storage ??= FlutterSecureStorage();

    return Success(storage!);
  }

  Future<Result<()>> load_data() async {
    File sFile = (await get_statefile()).getOrThrow();
    var contents = await sFile.readAsString();

    if (contents.isNotEmpty) {
      var jsonContents = jsonDecode(contents);
      state = AppState.fromJson(jsonContents);

      if (state.login.loggedIn) {
        Map<String, String> storageVals = await (get_storage().getOrThrow())
            .readAll();
        state.login.token = storageVals["token"];
        state.login.refreshToken = storageVals["refreshToken"];

        apiClient.setLoginState(state.login);
      }

      notifyListeners();
    }

    return Success(());
  }

  Future<Result<()>> save_data() async {
    File sFile = (await get_statefile()).getOrThrow();
    var contents = state.toJson();
    var st = get_storage().getOrThrow();

    stateFile = await sFile.writeAsString(jsonEncode(contents));
    if (state.login.loggedIn) {
      st.write(key: "token", value: state.login.token);
      st.write(key: "refreshToken", value: state.login.refreshToken);
    }

    return Success(());
  }
}
