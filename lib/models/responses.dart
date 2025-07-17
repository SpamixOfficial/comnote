import 'package:json_annotation/json_annotation.dart';
import 'generic.dart';

part 'responses.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OAuthResponse {
  final String accessToken, refreshToken;

  @JsonKey(name: "expires_in", fromJson: _expiresAtFromMilliseconds)
  DateTime expiresAt;

  OAuthResponse(this.accessToken, this.refreshToken, this.expiresAt);

  factory OAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OAuthResponseToJson(this);

  static DateTime _expiresAtFromMilliseconds(int ms) =>
      DateTime.now().add(Duration(milliseconds: ms));
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeResponse {
  final List<AnimeSummaryWrapper> data;
  final ApiPaging paging;

  AnimeResponse({required this.data, required this.paging});

  factory AnimeResponse.fromJson(Map<String, dynamic> json) =>
      _$AnimeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeSummaryWrapper {
  final AnimeSummary node;

  AnimeSummaryWrapper({required this.node});

  factory AnimeSummaryWrapper.fromJson(Map<String, dynamic> json) =>
      _$AnimeSummaryWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeSummaryWrapperToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimeSummary {
  final AlternativeTitles alternativeTitles;
  final int averageEpisodeDuration;
  final String? background;
  final Broadcast? broadcast;
  final DateTime createdAt;
  // TODO: get YYYY-[MM]-[DD] parsing working
  final String? endDate;
  final FavoriteInfo? favoritesInfo;
  final List<Genre> genres;
  final int id;
  final MainImageAsset mainPicture;
  final double? rating;
  final AnimeType mediaType;
  final int numEpisodes;
  final int numFavorites;
  final int numInLists;
  final int rankInLists;
  final int?
  rank; // never seen this but their Java models says it exists????? Putting option for now...
  final String? startDate; // TODO: get YYYY-[MM]-[DD] parsing working
  final Season? startSeason;
  final AiringStatus? status;
  final String synopsis;
  final String title;
  final DateTime updatedAt;
  final Ranking? ranking;

  // Not needed in our case, but if you're building an API based on this feel free to implement this as well!
  //final MyListStatus myListStatus;

  AnimeSummary({
    required this.alternativeTitles,
    required this.averageEpisodeDuration,
    this.background,
    this.broadcast,
    required this.createdAt,
    this.endDate,
    this.favoritesInfo,
    required this.genres,
    required this.id,
    required this.mainPicture,
    this.rating,
    required this.mediaType,
    required this.numEpisodes,
    required this.numFavorites,
    required this.numInLists,
    required this.rankInLists,
    this.rank,
    this.startDate,
    this.startSeason,
    this.status,
    required this.synopsis,
    required this.title,
    required this.updatedAt,
    this.ranking,
  });

  factory AnimeSummary.fromJson(Map<String, dynamic> json) =>
      _$AnimeSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeSummaryToJson(this);
}
