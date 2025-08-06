// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
  contentSettings: json['contentSettings'] == null
      ? const ContentSettings.defaults()
      : ContentSettings.fromJson(
          json['contentSettings'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
  'contentSettings': instance.contentSettings,
};

ContentSettings _$ContentSettingsFromJson(Map<String, dynamic> json) =>
    ContentSettings(
      ageRating:
          $enumDecodeNullable(_$AgeRatingEnumMap, json['ageRating']) ??
          AgeRating.pg13,
      nsfwRating:
          $enumDecodeNullable(_$NsfwRatingEnumMap, json['nsfwRating']) ??
          NsfwRating.white,
    );

Map<String, dynamic> _$ContentSettingsToJson(ContentSettings instance) =>
    <String, dynamic>{
      'ageRating': _$AgeRatingEnumMap[instance.ageRating]!,
      'nsfwRating': _$NsfwRatingEnumMap[instance.nsfwRating]!,
    };

const _$AgeRatingEnumMap = {
  AgeRating.pg13: 'pg13',
  AgeRating.rx: 'rx',
  AgeRating.rPlus: 'r_plus',
  AgeRating.pg: 'pg',
  AgeRating.r: 'r',
  AgeRating.g: 'g',
};

const _$NsfwRatingEnumMap = {
  NsfwRating.white: 'white',
  NsfwRating.gray: 'gray',
  NsfwRating.black: 'black',
};
