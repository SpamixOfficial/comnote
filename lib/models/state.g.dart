// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopList _$TopListFromJson(Map<String, dynamic> json) => TopList(
  (json['list'] as List<dynamic>)
      .map((e) => AnimeSummaryWrapper.fromJson(e as Map<String, dynamic>))
      .toList(),
  DateTime.parse(json['fetchedAt'] as String),
  (json['lastFetchedPage'] as num).toInt(),
);

Map<String, dynamic> _$TopListToJson(TopList instance) => <String, dynamic>{
  'list': instance.list,
  'fetchedAt': instance.fetchedAt.toIso8601String(),
  'lastFetchedPage': instance.lastFetchedPage,
};

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
  login: json['login'] == null
      ? null
      : LoginState.fromJson(json['login'] as Map<String, dynamic>),
  topLists: (json['topLists'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(
      $enumDecode(_$SearchRankingEnumMap, k),
      TopList.fromJson(e as Map<String, dynamic>),
    ),
  ),
  currentTopList:
      $enumDecodeNullable(_$SearchRankingEnumMap, json['currentTopList']) ??
      SearchRanking.top10Airing,
);

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
  'login': instance.login,
  'topLists': instance.topLists.map(
    (k, e) => MapEntry(_$SearchRankingEnumMap[k]!, e),
  ),
  'currentTopList': _$SearchRankingEnumMap[instance.currentTopList]!,
};

const _$SearchRankingEnumMap = {
  SearchRanking.justAdded: 'just_added',
  SearchRanking.mostPopular: 'most_popular',
  SearchRanking.nowWatching: 'now_watching',
  SearchRanking.top10Airing: 'airing',
  SearchRanking.top10Upcoming: 'upcoming',
  SearchRanking.topAnime: 'top_anime',
  SearchRanking.trending: 'trending',
};

LoginState _$LoginStateFromJson(Map<String, dynamic> json) => LoginState(
  json['loggedIn'] as bool,
  DateTime.parse(json['expires'] as String),
);

Map<String, dynamic> _$LoginStateToJson(LoginState instance) =>
    <String, dynamic>{
      'loggedIn': instance.loggedIn,
      'expires': instance.expires.toIso8601String(),
    };
