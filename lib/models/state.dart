import 'package:comnote/models/generic.dart';
import 'package:comnote/models/responses.dart';
import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';


@JsonSerializable()
class TopList {

  List<AnimeSummaryWrapper> list;
  DateTime fetchedAt;
  int lastFetchedPage;

  TopList(this.list, this.fetchedAt, this.lastFetchedPage);

  factory TopList.fromJson(Map<String, dynamic> json) =>
      _$TopListFromJson(json);

  Map<String, dynamic> toJson() => _$TopListToJson(this);
}

@JsonSerializable()
class AppState {
  LoginState login;

  Map<SearchRanking, TopList> topLists;

  @JsonKey(defaultValue: SearchRanking.top10Airing)
  SearchRanking currentTopList;

  AppState({LoginState? login, Map<SearchRanking, TopList>? topLists, this.currentTopList = SearchRanking.top10Airing})
    : login = login ?? LoginState(false, DateTime.fromMillisecondsSinceEpoch(0)),
    topLists = topLists ?? {};

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

@JsonSerializable()
class LoginState {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? token, refreshToken;

  bool loggedIn;

  DateTime expires;

  LoginState(this.loggedIn, this.expires, {this.token, this.refreshToken});

  factory LoginState.fromJson(Map<String, dynamic> json) =>
      _$LoginStateFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStateToJson(this);
}
