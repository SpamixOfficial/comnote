// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthResponse _$OAuthResponseFromJson(Map<String, dynamic> json) =>
    OAuthResponse(
      json['access_token'] as String,
      json['refresh_token'] as String,
      OAuthResponse._expiresAtFromMilliseconds(
        (json['expires_in'] as num).toInt(),
      ),
    );

Map<String, dynamic> _$OAuthResponseToJson(OAuthResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresAt.toIso8601String(),
    };

AnimeResponse _$AnimeResponseFromJson(Map<String, dynamic> json) =>
    AnimeResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => AnimeSummaryWrapper.fromJson(e as Map<String, dynamic>))
          .toList(),
      paging: ApiPaging.fromJson(json['paging'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeResponseToJson(AnimeResponse instance) =>
    <String, dynamic>{'data': instance.data, 'paging': instance.paging};

AnimeSummaryWrapper _$AnimeSummaryWrapperFromJson(Map<String, dynamic> json) =>
    AnimeSummaryWrapper(
      node: AnimeSummary.fromJson(json['node'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeSummaryWrapperToJson(
  AnimeSummaryWrapper instance,
) => <String, dynamic>{'node': instance.node};

AnimeSummary _$AnimeSummaryFromJson(Map<String, dynamic> json) => AnimeSummary(
  alternativeTitles: AlternativeTitles.fromJson(
    json['alternative_titles'] as Map<String, dynamic>,
  ),
  averageEpisodeDuration: (json['average_episode_duration'] as num).toInt(),
  background: json['background'] as String?,
  broadcast: json['broadcast'] == null
      ? null
      : Broadcast.fromJson(json['broadcast'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['created_at'] as String),
  endDate: json['end_date'] as String?,
  favoritesInfo: json['favorites_info'] == null
      ? null
      : FavoriteInfo.fromJson(json['favorites_info'] as Map<String, dynamic>),
  genres: (json['genres'] as List<dynamic>)
      .map((e) => Genre.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: (json['id'] as num).toInt(),
  mainPicture: MainImageAsset.fromJson(
    json['main_picture'] as Map<String, dynamic>,
  ),
  rating: (json['rating'] as num?)?.toDouble(),
  mediaType: $enumDecode(_$AnimeTypeEnumMap, json['media_type']),
  numEpisodes: (json['num_episodes'] as num).toInt(),
  numFavorites: (json['num_favorites'] as num).toInt(),
  numInLists: (json['num_in_lists'] as num).toInt(),
  rankInLists: (json['rank_in_lists'] as num).toInt(),
  rank: (json['rank'] as num?)?.toInt(),
  startDate: json['start_date'] as String?,
  startSeason: json['start_season'] == null
      ? null
      : Season.fromJson(json['start_season'] as Map<String, dynamic>),
  status: $enumDecodeNullable(_$AiringStatusEnumMap, json['status']),
  synopsis: json['synopsis'] as String,
  title: json['title'] as String,
  updatedAt: DateTime.parse(json['updated_at'] as String),
  ranking: json['ranking'] == null
      ? null
      : Ranking.fromJson(json['ranking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AnimeSummaryToJson(AnimeSummary instance) =>
    <String, dynamic>{
      'alternative_titles': instance.alternativeTitles,
      'average_episode_duration': instance.averageEpisodeDuration,
      'background': instance.background,
      'broadcast': instance.broadcast,
      'created_at': instance.createdAt.toIso8601String(),
      'end_date': instance.endDate,
      'favorites_info': instance.favoritesInfo,
      'genres': instance.genres,
      'id': instance.id,
      'main_picture': instance.mainPicture,
      'rating': instance.rating,
      'media_type': _$AnimeTypeEnumMap[instance.mediaType]!,
      'num_episodes': instance.numEpisodes,
      'num_favorites': instance.numFavorites,
      'num_in_lists': instance.numInLists,
      'rank_in_lists': instance.rankInLists,
      'rank': instance.rank,
      'start_date': instance.startDate,
      'start_season': instance.startSeason,
      'status': _$AiringStatusEnumMap[instance.status],
      'synopsis': instance.synopsis,
      'title': instance.title,
      'updated_at': instance.updatedAt.toIso8601String(),
      'ranking': instance.ranking,
    };

const _$AnimeTypeEnumMap = {
  AnimeType.tv: 'tv',
  AnimeType.movie: 'movie',
  AnimeType.ova: 'ova',
  AnimeType.ona: 'ona',
  AnimeType.pv: 'pv',
  AnimeType.cm: 'cm',
  AnimeType.music: 'music',
  AnimeType.tvSpecial: 'tv_special',
  AnimeType.special: 'special',
  AnimeType.unknown: 'unknown',
};

const _$AiringStatusEnumMap = {
  AiringStatus.notYetAired: 'not_yet_aired',
  AiringStatus.currentlyAiring: 'currently_airing',
  AiringStatus.finishedAiring: 'finished_airing',
};
