use std::{fs::OpenOptions, io::Write};

use anyhow::Result;
use chrono::{TimeDelta, Utc};
use tauri::{async_runtime::Mutex, State};

use crate::{AppState, AuthState};

#[tauri::command]
pub async fn login(
    state: State<'_, Mutex<AppState>>,
    code: String,
    verifier: String,
) -> Result<(), String> {
    let mut state = state.lock().await;

    let oauth = match state.api.login.consume_code(code, verifier.clone()).await {
        Err(e) => return Err(e.to_string()),
        Ok(x) => x,
    };

    let expires = Utc::now()
        .checked_add_signed(TimeDelta::new(oauth.expires_in as i64, 0).unwrap())
        .unwrap();

    state.auth = AuthState {
        access_token: oauth.access_token.clone(),
        refresh_token: oauth.refresh_token.clone(),
        authenticated: Some(true),
        expires,
        verifier: verifier.clone()
    };

    state.settings.access_token = oauth.access_token;
    state.settings.refresh_token = oauth.refresh_token;
    state.settings.expires = expires;
    state.settings.authenticated = true;
    state.settings.verifier = verifier;

    let mut settings_file = OpenOptions::new()
        .write(true)
        .create(true)
        .open(&state.store_path)
        .unwrap();
    let serialized_settings = serde_json::to_string_pretty(&state.settings).unwrap();
    settings_file
        .write_all(serialized_settings.as_bytes())
        .unwrap();

    Ok(())
}

#[tauri::command]
pub async fn refresh_login(
    state: State<'_, Mutex<AppState>>,
) -> Result<(), String> {
    let mut state = state.lock().await;

    if state.auth.authenticated.is_none() || !state.auth.authenticated.unwrap() {
        return Err(String::from("You aren't logged in, please log in before trying to refresh your token!"))
    }

    let oauth = match state.api.login.refresh_token(state.auth.refresh_token.clone(), state.auth.verifier.clone()).await {
        Err(e) => return Err(e.to_string()),
        Ok(x) => x,
    };

    let expires = Utc::now()
        .checked_add_signed(TimeDelta::new(oauth.expires_in as i64, 0).unwrap())
        .unwrap();

    state.auth = AuthState {
        access_token: oauth.access_token.clone(),
        refresh_token: oauth.refresh_token.clone(),
        authenticated: Some(true),
        expires,
        verifier: state.auth.verifier.clone()
    };

    state.settings.access_token = oauth.access_token;
    state.settings.refresh_token = oauth.refresh_token;
    state.settings.expires = expires;
    state.settings.authenticated = true;
    state.settings.verifier = state.auth.verifier.clone();

    let mut settings_file = OpenOptions::new()
        .write(true)
        .create(true)
        .open(&state.store_path)
        .unwrap();

    let serialized_settings = serde_json::to_string_pretty(&state.settings).unwrap();
    settings_file
        .write_all(serialized_settings.as_bytes())
        .unwrap();

    Ok(())
}

#[tauri::command]
pub async fn logged_in(state: State<'_, Mutex<AppState>>) -> Result<bool, String> {
    let state = state.lock().await;

    if let Some(x) = state.auth.authenticated {
        return Ok(x);
    }

    Ok(false)
}

#[tauri::command]
pub async fn session_expired(state: State<'_, Mutex<AppState>>) -> Result<bool, String> {
    let state = state.lock().await;

    Ok(Utc::now() >= state.auth.expires)
}