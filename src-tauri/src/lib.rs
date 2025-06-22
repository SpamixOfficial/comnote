use std::error::Error;

use anyhow::Result;
use api::Api;
use chrono::{DateTime, TimeDelta, Utc};
use reqwest::Client;
use tauri::{
    async_runtime::Mutex,
    http::HeaderMap,
    ipc::{Channel, InvokeResponseBody},
    App, Manager, State,
};
use tauri_plugin_login_browser::LoginResponse;

mod api;

#[derive(Debug)]
pub struct AppState {
    api: Api,
    auth: AuthState,
}

#[derive(Debug, Default)]
pub struct AuthState {
    access_token: String,
    refresh_token: String,
    authenticated: bool,
    expires: DateTime<Utc>,
}


#[tauri::command]
async fn login(
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
        access_token: oauth.access_token,
        refresh_token: oauth.refresh_token,
        authenticated: true,
        expires,
    };

    Ok(())
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    #[cfg(debug_assertions)] // only enable instrumentation in development builds
    let devtools = tauri_plugin_devtools::init();
    let mut builder = tauri::Builder::default();
    #[cfg(debug_assertions)]
    {
        builder = builder.plugin(devtools);
    }

    builder
        //.plugin(tauri_plugin_log::Builder::new().build())
        .plugin(tauri_plugin_login_browser::init())
        .plugin(tauri_plugin_opener::init())
        .setup(setup)
        .invoke_handler(tauri::generate_handler![login])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

fn setup(mut app: &mut App) -> Result<(), Box<(dyn Error + 'static)>> {
    // client setup
    let mut headers = HeaderMap::new();
    headers.append(
        "X-Mal-Client-Id",
        "df368c0b8286b739ee77f0b905960700".parse().unwrap(),
    );
    headers.append("User-Agent", "MAL (android, 2.3.15)".parse().unwrap());

    let client = Client::builder().default_headers(headers).build()?;

    let api = Api { client };

    // continue this later :D
    let state = AppState {
        api,
        auth: AuthState::default(),
    };
    app.manage(state);
    Ok(())
}
