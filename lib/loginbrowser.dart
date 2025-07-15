import 'dart:developer';

import 'package:comnote/models/generic.dart';
import 'package:comnote/models/responses.dart';
import 'package:flutter/services.dart';
import 'package:result_dart/result_dart.dart';

class Loginbrowser {
  static const platform = MethodChannel("comnote.spamix.se/loginBrowser");
  Future<ResultDart<OAuthResponse,ApiError>> openLogin() async {
    try {
      final result_raw = Map<String, dynamic>.from((await platform.invokeMethod('openLogin')) as Map) ;
      OAuthResponse result = OAuthResponse(result_raw['code'], result_raw['verifier']);
      return Success(result);
    } on PlatformException catch (e) {
      ApiError error = ApiError("Webview Error", e.toString());
      log(error.message);
      return Failure(error);
    }
  }
}
