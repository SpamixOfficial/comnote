import 'package:comnote/models/generic.dart';
import 'package:json_annotation/json_annotation.dart';
part 'settings.g.dart';

@JsonSerializable()
class Settings {
  final ContentSettings contentSettings;

  const Settings({this.contentSettings = const ContentSettings.defaults()});

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}

@JsonSerializable()
class ContentSettings {
  final AgeRating ageRating;
  final NsfwRating nsfwRating;

  const ContentSettings({this.ageRating = AgeRating.pg13, this.nsfwRating = NsfwRating.white});
  const factory ContentSettings.defaults() = ContentSettings;

  factory ContentSettings.fromJson(Map<String, dynamic> json) =>
      _$ContentSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$ContentSettingsToJson(this);
}