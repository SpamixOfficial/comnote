// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) =>
    ApiError(json['error'] as String, json['message'] as String);

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
  'error': instance.error,
  'message': instance.message,
};

ApiPaging _$ApiPagingFromJson(Map<String, dynamic> json) =>
    ApiPaging(next: Uri.parse(json['next'] as String));

Map<String, dynamic> _$ApiPagingToJson(ApiPaging instance) => <String, dynamic>{
  'next': instance.next.toString(),
};

AlternativeTitles _$AlternativeTitlesFromJson(Map<String, dynamic> json) =>
    AlternativeTitles(
      en: json['en'] as String,
      ja: json['ja'] as String,
      synonyms: (json['synonyms'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AlternativeTitlesToJson(AlternativeTitles instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ja': instance.ja,
      'synonyms': instance.synonyms,
    };

Broadcast _$BroadcastFromJson(Map<String, dynamic> json) => Broadcast(
  dayOfTheWeek: $enumDecode(_$WeekDayEnumMap, json['dayOfTheWeek']),
  startTime: DateTime.parse(json['startTime'] as String),
);

Map<String, dynamic> _$BroadcastToJson(Broadcast instance) => <String, dynamic>{
  'dayOfTheWeek': _$WeekDayEnumMap[instance.dayOfTheWeek]!,
  'startTime': instance.startTime.toIso8601String(),
};

const _$WeekDayEnumMap = {
  WeekDay.monday: 'monday',
  WeekDay.tuesday: 'tuesday',
  WeekDay.wednsday: 'wednsday',
  WeekDay.thursday: 'thursday',
  WeekDay.friday: 'friday',
  WeekDay.saturday: 'saturday',
  WeekDay.sundayP: 'sunday_p',
};

FavoriteInfo _$FavoriteInfoFromJson(Map<String, dynamic> json) =>
    FavoriteInfo(addedAt: DateTime.parse(json['addedAt'] as String));

Map<String, dynamic> _$FavoriteInfoToJson(FavoriteInfo instance) =>
    <String, dynamic>{'addedAt': instance.addedAt.toIso8601String()};

Genre _$GenreFromJson(Map<String, dynamic> json) =>
    Genre(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

MainImageAsset _$MainImageAssetFromJson(Map<String, dynamic> json) =>
    MainImageAsset(
      medium: Uri.parse(json['medium'] as String),
      large: Uri.parse(json['large'] as String),
    );

Map<String, dynamic> _$MainImageAssetToJson(MainImageAsset instance) =>
    <String, dynamic>{
      'medium': instance.medium.toString(),
      'large': instance.large.toString(),
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
  season: $enumDecode(_$SeasonEnumEnumMap, json['season']),
  year: (json['year'] as num).toInt(),
);

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
  'season': _$SeasonEnumEnumMap[instance.season]!,
  'year': instance.year,
};

const _$SeasonEnumEnumMap = {
  SeasonEnum.autumn: 'autumn',
  SeasonEnum.summer: 'summer',
  SeasonEnum.spring: 'spring',
  SeasonEnum.fall: 'fall',
  SeasonEnum.winter: 'winter',
};

Ranking _$RankingFromJson(Map<String, dynamic> json) => Ranking(
  rank: (json['rank'] as num).toInt(),
  previousRank: (json['previousRank'] as num?)?.toInt(),
);

Map<String, dynamic> _$RankingToJson(Ranking instance) => <String, dynamic>{
  'rank': instance.rank,
  'previousRank': instance.previousRank,
};
