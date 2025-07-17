import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

final clientId = "df368c0b8286b739ee77f0b905960700";

class MALApi {
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
}

Future<ResultDart<ST, ET>> apiCall<ST extends Object, ET extends Object>(
  Future<Response<dynamic>> Function() cb,
  ST Function(Map<String, dynamic> json) scb,
  ET Function(Map<String, dynamic> json) ecb,
) async {
  try {
    var resp = await cb();
    ST respVal = scb(jsonDecode(resp.data) as Map<String, dynamic>);
    return Success(respVal);
  } on DioException catch (e) {
    var errMap = jsonDecode(e.response?.data) as Map<String, dynamic>;
    ET err = ecb(errMap);
    return Failure(err);
  }
}
