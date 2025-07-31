import 'package:comnote/api.dart';
import 'package:comnote/api/login.dart';
import 'package:comnote/models/generic.dart';
import 'package:comnote/models/responses.dart';
import 'dart:developer' as developer;

import 'package:comnote/models/state.dart';
import 'package:result_dart/result_dart.dart';

class Commands {
  final MALApi apiClient = MALApi();

  Future<bool> login(
    AppState state,
    Map<String, dynamic> loginBrowserResponse,
  ) async {
    developer.log(
      "[LOGIN_BROWSER] Code: ${loginBrowserResponse["code"]}, Verifier: ${loginBrowserResponse["verifier"]}",
    );

    var authResp = await apiClient.login.oauthAction(
      verifier: loginBrowserResponse["verifier"],
      action: OAuthAction.authorize,
      code: loginBrowserResponse["code"],
    );

    if (authResp.isError()) {
      state.login.loggedIn = false;
      return false;
    }

    var authRespValue = authResp.getOrThrow();
    state.login.loggedIn = true;
    state.login.expires = authRespValue.expiresAt;
    state.login.refreshToken = authRespValue.refreshToken;
    state.login.token = authRespValue.accessToken;

    return true;
  }

  Future<void> loadHomePageData(AppState state, SearchRanking ranking, {int page = 0, bool dataRefresh = false}) async {
    ResultDart<AnimeResponse, ApiError> resp;
    switch (ranking) {
      case SearchRanking.nowWatching:
      case SearchRanking.trending:
      case SearchRanking.top10Airing:
      case SearchRanking.top10Upcoming:
        resp = await apiClient.anime.searchByRanking(ranking: ranking, limit: 100, offset: page*100);
        break;
      case SearchRanking.justAdded:
        resp = await apiClient.anime.getJustAdded(limit: 100, offset: page*100);
        break;
      default:
        // no impl for this atm
        throw Error();
    }

    if (resp.isError()) {
      return;
    }
    if (state.topLists[ranking] == null || dataRefresh) {
      state.topLists[ranking] = TopList(resp.getOrThrow().data, DateTime.now(), page);
    } else {
      state.topLists[ranking]!.list += resp.getOrThrow().data;
      state.topLists[ranking]!.fetchedAt = DateTime.now();
      state.topLists[ranking]!.lastFetchedPage = page;
    }
  }
}
