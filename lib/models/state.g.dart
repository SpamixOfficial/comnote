// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
  login: json['login'] == null
      ? null
      : LoginState.fromJson(json['login'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
  'login': instance.login,
};

LoginState _$LoginStateFromJson(Map<String, dynamic> json) => LoginState(
  json['loggedIn'] as bool,
  DateTime.parse(json['expires'] as String),
  token: json['token'] as String?,
  refreshToken: json['refreshToken'] as String?,
);

Map<String, dynamic> _$LoginStateToJson(LoginState instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'loggedIn': instance.loggedIn,
      'expires': instance.expires.toIso8601String(),
    };
