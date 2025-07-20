import 'package:comnote/api.dart';
import 'package:comnote/api/login.dart';
import 'package:comnote/models/state.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class PreferencesHandler extends ChangeNotifier {
  final AppState state = AppState();
  final MALApi apiClient = MALApi();

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
}
