import 'package:comnote/api.dart';
import 'package:comnote/api/login.dart';
import 'dart:developer' as developer;

import 'package:comnote/models/state.dart';

class Commands {
  final MALApi apiClient = MALApi();

  Future<bool> login(AppState state, Map<String, dynamic> loginBrowserResponse) async {
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

    return true;
  }
}