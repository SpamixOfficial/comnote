import 'dart:developer';

import 'package:comnote/api/anime.dart';
import 'package:comnote/api/login.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

final clientId = "df368c0b8286b739ee77f0b905960700";
final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.myanimelist.net/v3",
      headers: {
        "Host": "api.myanimelist.net",
        "X-Mal-Client-Id": clientId,
        "User-Agent": "MAL (android, 2.3.15)",
      },
    ),
  );

class MALApi {
  final AnimeApi anime = AnimeApi(dio);
  final LoginApi login = LoginApi(dio);
}

Future<ResultDart<ST, ET>> apiCall<ST extends Object, ET extends Object>(
  Future<Response<dynamic>> Function() cb,
  ST Function(Map<String, dynamic> json) scb,
  ET Function(Map<String, dynamic> json) ecb,
) async {
  try {
    var resp = await cb();
    ST respVal = scb(resp.data);
    return Success(respVal);
  } on DioException catch (e) {
    log("Error encountered.\n---- Metadata ----\nUri: ${e.requestOptions.uri}\nResponse:\n${e.response?.data ?? "---- No data! ----"}");
    ET err = ecb(e.response?.data);
    return Failure(err);
  }
}
