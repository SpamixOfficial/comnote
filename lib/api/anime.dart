import 'package:comnote/api.dart';
import 'package:comnote/models/generic.dart';
import 'package:comnote/models/responses.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class SearchFieldsConstants {
  static String generic = "alternative_titles,media_type,num_episodes,status,start_date,end_date,average_episode_duration,synopsis,mean,genres,rank,popularity,num_list_users,num_favorites,favorites_info,num_scoring_users,start_season,broadcast,my_list_status{start_date,finish_date},nsfw,created_at,updated_at";
}

class AnimeApi extends BaseApi {
  final Dio dio;

  Future<ResultDart<AnimeResponse, ApiError>> getJustAdded({int limit = 10, int offset = 0}) async {
    var queryParams = {
            "total_members": 50,
            "limit": limit,
            "offset": offset, // must be present, otherwise the flow will fail!
            "sort": "created_at",
            "fields": SearchFieldsConstants.generic,
    };

    return await apiCall(() => dio.get("/anime", queryParameters: queryParams), AnimeResponse.fromJson, ApiError.fromJson);
  }

  Future<ResultDart<AnimeResponse, ApiError>> searchByRanking({required SearchRanking ranking, int limit = 10, int offset = 0}) async {
    var queryParams = {
      "ranking_type": ranking.value ?? ranking.name,
      "limit": limit,
      "offset": offset,
      "fields": SearchFieldsConstants.generic
    };

    return await apiCall(() => dio.get("/anime/ranking", queryParameters: queryParams), AnimeResponse.fromJson, ApiError.fromJson);
  }

  AnimeApi(this.dio);
}