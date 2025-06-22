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

    let oauth = match state.api.consume_code(code, verifier).await {
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
    };

    state.settings.access_token = oauth.access_token;
    state.settings.refresh_token = oauth.refresh_token;
    state.settings.expires = expires;
    state.settings.authenticated = true;

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
