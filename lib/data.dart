import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:comnote/commands.dart';
import 'package:comnote/models/generic.dart';
import 'package:comnote/models/state.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:result_dart/result_dart.dart';
import 'package:path_provider/path_provider.dart';

class AppHandler extends ChangeNotifier {
  AppState state = AppState();
  Commands commands = Commands();
  File? stateFile;
  FlutterSecureStorage? storage;

  bool get loggedIn => state.login.loggedIn;

  /* ---------- Statefile function ---------- */

  Future<Result<File>> get_statefile() async {
    if (stateFile == null) {
      var docPath = (await getApplicationDocumentsDirectory()).path;
      File f = File("$docPath/state.json");
      stateFile = f;
    }

    return Success(stateFile!); // should be safe
  }

  Result<FlutterSecureStorage> get_storage() {
    storage ??= FlutterSecureStorage();

    return Success(storage!);
  }

  Future<Result<()>> load_data() async {
    File sFile = (await get_statefile()).getOrThrow();

    try {
      var contents = await sFile.readAsString();

      if (contents.isNotEmpty) {
        var jsonContents = jsonDecode(contents);
        state = AppState.fromJson(jsonContents);

        if (state.login.loggedIn) {
          Map<String, String> storageVals = await (get_storage().getOrThrow())
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

  Future<Result<()>> save_data() async {
    File sFile = (await get_statefile()).getOrThrow();

    try {
      var contents = state.toJson();
      var st = get_storage().getOrThrow();

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
      (await save_data()).getOrThrow();

      notifyListeners();
    }

    return res;
  }

  Future<void> loadHomePageData({
    required SearchRanking ranking,
    bool dataRefresh = false,
  }) async {
    bool cacheInvalid =
        (dataRefresh ||
        (state.topLists[ranking] != null &&
            DateTime.now().difference(state.topLists[ranking]!.fetchedAt).inSeconds >=
                600));
    if (cacheInvalid) {
      return;
    }

    int nextPage = state.topLists[ranking]?.lastFetchedPage ?? 0;

    nextPage = dataRefresh ? 0 : nextPage;

    await commands.loadHomePageData(state, ranking, page: nextPage, dataRefresh: dataRefresh);
    notifyListeners();
  }
}
