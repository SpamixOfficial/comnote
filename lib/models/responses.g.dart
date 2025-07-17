// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
    json['alternativeTitles'] as Map<String, dynamic>,
  ),
  averageEpisodeDuration: (json['averageEpisodeDuration'] as num).toInt(),
  background: json['background'] as String?,
  broadcast: json['broadcast'] == null
      ? null
      : Broadcast.fromJson(json['broadcast'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  endDate: json['endDate'] as String?,
  favoritesInfo: json['favoritesInfo'] == null
      ? null
      : FavoriteInfo.fromJson(json['favoritesInfo'] as Map<String, dynamic>),
  genres: (json['genres'] as List<dynamic>)
      .map((e) => Genre.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: (json['id'] as num).toInt(),
  mainPicture: MainImageAsset.fromJson(
    json['mainPicture'] as Map<String, dynamic>,
  ),
  rating: (json['rating'] as num?)?.toDouble(),
  mediaType: $enumDecode(_$AnimeTypeEnumMap, json['mediaType']),
  numEpisodes: (json['numEpisodes'] as num).toInt(),
  numFavorites: (json['numFavorites'] as num).toInt(),
  numInLists: (json['numInLists'] as num).toInt(),
  rankInLists: (json['rankInLists'] as num).toInt(),
  rank: (json['rank'] as num?)?.toInt(),
  startDate: json['startDate'] as String?,
  startSeason: json['startSeason'] == null
      ? null
      : Season.fromJson(json['startSeason'] as Map<String, dynamic>),
  status: $enumDecodeNullable(_$AiringStatusEnumMap, json['status']),
  synopsis: json['synopsis'] as String,
  title: json['title'] as String,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  ranking: json['ranking'] == null
      ? null
      : Ranking.fromJson(json['ranking'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AnimeSummaryToJson(AnimeSummary instance) =>
    <String, dynamic>{
      'alternativeTitles': instance.alternativeTitles,
      'averageEpisodeDuration': instance.averageEpisodeDuration,
      'background': instance.background,
      'broadcast': instance.broadcast,
      'createdAt': instance.createdAt.toIso8601String(),
      'endDate': instance.endDate,
      'favoritesInfo': instance.favoritesInfo,
      'genres': instance.genres,
      'id': instance.id,
      'mainPicture': instance.mainPicture,
      'rating': instance.rating,
      'mediaType': _$AnimeTypeEnumMap[instance.mediaType]!,
      'numEpisodes': instance.numEpisodes,
      'numFavorites': instance.numFavorites,
      'numInLists': instance.numInLists,
      'rankInLists': instance.rankInLists,
      'rank': instance.rank,
      'startDate': instance.startDate,
      'startSeason': instance.startSeason,
      'status': _$AiringStatusEnumMap[instance.status],
      'synopsis': instance.synopsis,
      'title': instance.title,
      'updatedAt': instance.updatedAt.toIso8601String(),
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
