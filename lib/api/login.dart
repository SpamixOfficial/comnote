import 'package:comnote/api.dart';
import 'package:comnote/models/generic.dart';
import 'package:comnote/models/responses.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

enum OAuthAction {
  authorize("authorization_code"),
  refresh("refresh_token");

  final String oauthString;
  const OAuthAction(this.oauthString);
}

class LoginApi extends BaseApi {
  final Dio dio;

  /// refreshToken is optional if loginItem contains a valid refreshToken!
  Future<ResultDart<OAuthResponse, ApiError>> oauthAction({
    required String verifier,
    required OAuthAction action,
    String? code,
    refreshToken,
  }) async {
    var form = {
      "client_id": clientId,
      "redirect_uri":
          "net.myanimelist://login.input", // must be present, otherwise the flow will fail!
      "code_verifier": verifier,
      "grant_type": action.oauthString,
    };

    switch (action) {
      case OAuthAction.authorize:
        code ?? (throw "Can't do authorization without a code!");
        form["code"] = code;
        break;
      case OAuthAction.refresh:
        refreshToken = loginItem.refreshToken;
        refreshToken ?? (throw "Can't do refresh without a token!");
        form["refresh_token"] = refreshToken;
        break;
    }

    var cleanDio = Dio();

    return await apiCall(
      () => cleanDio.post(
        "https://myanimelist.net/v1/oauth2/token",
        data: form,
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
      ),
      OAuthResponse.fromJson,
      ApiError.fromJson,
    );
  }

  LoginApi(this.dio);
}
