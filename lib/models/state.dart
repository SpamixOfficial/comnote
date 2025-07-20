import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';

@JsonSerializable()
class AppState {
  LoginState login;

  AppState({LoginState? login})
    : login =
          login ??
          LoginState(false, DateTime.fromMillisecondsSinceEpoch(0));

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

@JsonSerializable()
class LoginState {
  String? token, refreshToken;
  bool loggedIn;

  DateTime expires;

  LoginState(this.loggedIn, this.expires, {this.token, this.refreshToken});

  factory LoginState.fromJson(Map<String, dynamic> json) =>
      _$LoginStateFromJson(json);

  Map<String, dynamic> toJson() => _$LoginStateToJson(this);
}
