import 'dart:convert';
import 'dart:io';

import 'package:comnote/commands.dart';
import 'package:comnote/models/generic.dart';
import 'package:comnote/models/state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:result_dart/result_dart.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:developer' as developer;

class AppHandler extends ChangeNotifier {
  AppState state = AppState();
  Commands commands = Commands();
  ElementsDraw elementsState = ElementsDraw();
  File? stateFile;
  FlutterSecureStorage? storage;

  bool get loggedIn => state.login.loggedIn;
  bool homePageInitialized = false;

  /* ---------- Statefile function ---------- */

  Future<Result<File>> getStateFile() async {
    if (stateFile == null) {
      var docPath = (await getApplicationDocumentsDirectory()).path;
      File f = File("$docPath/state.json");
      stateFile = f;
    }

    return Success(stateFile!); // should be safe
  }

  Result<FlutterSecureStorage> getStorage() {
    storage ??= FlutterSecureStorage();

    return Success(storage!);
  }

  Future<Result<()>> loadData() async {
    File sFile = (await getStateFile()).getOrThrow();

    try {
      var contents = await sFile.readAsString();

      if (contents.isNotEmpty) {
        var jsonContents = jsonDecode(contents);
        state = AppState.fromJson(jsonContents);

        if (state.login.loggedIn) {
          Map<String, String> storageVals = await (getStorage().getOrThrow())
              .readAll();
          state.login.token = storageVals["token"];
          state.login.refreshToken = storageVals["refreshToken"];

          commands.apiClient.setLoginState(state.login);
        }

        notifyListeners();
      }
    } on Exception catch (e) {
      return Failure(e);
    }

    return Success(());
  }

  Future<Result<()>> saveData() async {
    File sFile = (await getStateFile()).getOrThrow();

    try {
      var contents = state.toJson();
      var st = getStorage().getOrThrow();

      stateFile = await sFile.writeAsString(jsonEncode(contents));
      if (state.login.loggedIn) {
        st.write(key: "token", value: state.login.token);
        st.write(key: "refreshToken", value: state.login.refreshToken);
      }
    } on Exception catch (e) {
      return Failure(e);
    }

    return Success(());
  }

  /* ---------- Commands ---------- */

  Future<bool> login(Map<String, dynamic> loginBrowserResponse) async {
    var res = await commands.login(state, loginBrowserResponse);

    if (res) {
      (await saveData()).getOrThrow();

      notifyListeners();
    }

    return res;
  }

  Future<void> loadHomePageData({
    required SearchRanking ranking,
    bool dataRefresh = false,
    bool loadNextPage = false,
    bool updateChosenList = false,
    double? scrollPixel,
  }) async {
    if (loadNextPage ||
        !(state.topLists[ranking] != null &&
            DateTime.now()
                    .difference(state.topLists[ranking]!.fetchedAt)
                    .inSeconds <=
                600 &&
            !dataRefresh)) {
      int nextPage = state.topLists[ranking]?.lastFetchedPage ?? 0;

      nextPage = dataRefresh ? 0 : nextPage + 1;

      elementsState.toggleLoading();

      var resp = await commands.loadHomePageData(
        state,
        ranking,
        page: nextPage,
        dataRefresh: dataRefresh,
      );

      if (resp.isError()) {
        developer.log(
          "An error was encountered while updating home data",
          level: 1000,
          error: resp.exceptionOrNull()!,
        );
        return;
      }

      state.topLists[ranking] = resp.getOrThrow();
      elementsState.toggleLoading();

      (await saveData()).getOrThrow();
    }

    if (scrollPixel != null) {
      elementsState.savedScrollPositions[state.currentTopList] = scrollPixel;
    }

    if (updateChosenList) {
      if (elementsState.recommendationsScrollControl.positions.isNotEmpty &&
          scrollPixel == null) {
        elementsState.savedScrollPositions[state.currentTopList] =
            elementsState.recommendationsScrollControl.offset;
      }
      state.currentTopList = ranking;
    }

    notifyListeners();
  }
}

class ElementsDraw extends ChangeNotifier {
  // Home Page
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool showLoading = false;
  Map<SearchRanking, double> savedScrollPositions = {};
  ScrollController recommendationsScrollControl = ScrollController();

  void toggleLoading() {
    showLoading = !showLoading;
    notifyListeners();
  }
}
