import 'package:json_annotation/json_annotation.dart';
part 'generic.g.dart';

@JsonSerializable()
class ApiError {
  final String error, message;
  ApiError(this.error, this.message);

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}

@JsonSerializable()
class ApiPaging {
  final Uri next;

  ApiPaging({required this.next});

  factory ApiPaging.fromJson(Map<String, dynamic> json) =>
      _$ApiPagingFromJson(json);
  Map<String, dynamic> toJson() => _$ApiPagingToJson(this);
}

@JsonSerializable()
class AlternativeTitles {
  final String en;
  final String ja;
  final List<String> synonyms;

  AlternativeTitles({
    required this.en,
    required this.ja,
    required this.synonyms,
  });

  factory AlternativeTitles.fromJson(Map<String, dynamic> json) =>
      _$AlternativeTitlesFromJson(json);
  Map<String, dynamic> toJson() => _$AlternativeTitlesToJson(this);
}

@JsonSerializable()
class Broadcast {
  final WeekDay dayOfTheWeek;
  final DateTime startTime;

  Broadcast({required this.dayOfTheWeek, required this.startTime});

  factory Broadcast.fromJson(Map<String, dynamic> json) =>
      _$BroadcastFromJson(json);
  Map<String, dynamic> toJson() => _$BroadcastToJson(this);
}

@JsonSerializable()
class FavoriteInfo {
  final DateTime addedAt;

  FavoriteInfo({required this.addedAt});

  factory FavoriteInfo.fromJson(Map<String, dynamic> json) =>
      _$FavoriteInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteInfoToJson(this);
}

@JsonSerializable()
class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@JsonSerializable()
class MainImageAsset {
  final Uri medium, large;

  MainImageAsset({required this.medium, required this.large});

  factory MainImageAsset.fromJson(Map<String, dynamic> json) =>
      _$MainImageAssetFromJson(json);
  Map<String, dynamic> toJson() => _$MainImageAssetToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum AnimeType {
  tv,
  movie,
  ova,
  ona,
  pv,
  cm,
  music,
  tvSpecial,
  special,
  unknown,
}

@JsonSerializable()
class Season {
  final SeasonEnum season;
  final int year;

  Season({required this.season, required this.year});

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum SeasonEnum { autumn, summer, spring, fall, winter }

@JsonEnum(fieldRename: FieldRename.snake)
enum AiringStatus { notYetAired, currentlyAiring, finishedAiring }

@JsonEnum(fieldRename: FieldRename.snake)
enum AgeRating { pg13, rx, rPlus, pg, r, g }

@JsonEnum(fieldRename: FieldRename.snake)
enum SearchRanking {
  justAdded,
  mostPopular,
  nowWatching,
  top10Airing,
  top10Upcoming,
  topAnime,
  trending,
}

@JsonSerializable()
class Ranking {
  final int rank;
  final int? previousRank;

  Ranking({required this.rank, this.previousRank});

  factory Ranking.fromJson(Map<String, dynamic> json) =>
      _$RankingFromJson(json);
  Map<String, dynamic> toJson() => _$RankingToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum SearchSort { scoreVal, totalMembers, startDate, defaultSort }

@JsonEnum(fieldRename: FieldRename.snake)
enum WeekDay { monday, tuesday, wednsday, thursday, friday, saturday, sundayP }