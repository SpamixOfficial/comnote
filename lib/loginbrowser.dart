import 'dart:developer';

import 'package:comnote/models/generic.dart';
import 'package:flutter/services.dart';
import 'package:result_dart/result_dart.dart';

class Loginbrowser {
  static const platform = MethodChannel("comnote.spamix.se/loginBrowser");
  Future<ResultDart<Map<String, dynamic>,ApiError>> openLogin() async {
    try {
      final result = Map<String, dynamic>.from((await platform.invokeMethod('openLogin')) as Map) ;
      return Success(result);
    } on PlatformException catch (e) {
      ApiError error = ApiError("Webview Error", e.toString());
      log(error.message);
      return Failure(error);
    }
  }
}
