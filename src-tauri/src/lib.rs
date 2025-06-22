use std::{error::Error, fs::File, io::Read, path::PathBuf};

use anyhow::Result;
use api::Api;
use chrono::{DateTime, Utc};
use reqwest::Client;
use serde::{Deserialize, Serialize};
use tauri::{async_runtime::Mutex, http::HeaderMap, App, Manager};

mod api;
mod commands;

#[derive(Debug)]
pub struct AppState {
    api: Api,
    auth: AuthState,
    store_path: PathBuf,
    settings: AppSettings,
}

#[derive(Debug, Default)]
pub struct AuthState {
    access_token: String,
    refresh_token: String,
    authenticated: Option<bool>,
    expires: DateTime<Utc>,
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    #[cfg(debug_assertions)] // enable devtools in debug builds
    let devtools = tauri_plugin_devtools::init();
    let mut builder = tauri::Builder::default();
    #[cfg(debug_assertions)]
    {
        builder = builder.plugin(devtools);
    }

    builder
        .plugin(tauri_plugin_login_browser::init())
        .plugin(tauri_plugin_opener::init())
        .setup(move |app| {
            // client setup
            let mut headers = HeaderMap::new();
            headers.append(
                "X-Mal-Client-Id",
                "df368c0b8286b739ee77f0b905960700".parse()?,
            );
            headers.append("User-Agent", "MAL (android, 2.3.15)".parse()?);

            // load possibly saved data
            let mut auth = AuthState::default();
            let store_path = app.path().app_data_dir()?.join("settings.json");
            let settings: AppSettings;
            if store_path.exists() {
                let mut file = File::open(&store_path)?;
                let mut contents = String::from("");
                file.read_to_string(&mut contents)?;
                let parsed: AppSettings = serde_json::from_str(&contents)?;
                settings = parsed.clone();

                auth = AuthState {
                    access_token: parsed.access_token,
                    refresh_token: parsed.refresh_token,
                    authenticated: Some(parsed.authenticated),
                    expires: parsed.expires,
                };
            } else {
                settings = AppSettings::default();
            }

            let client = Client::builder().default_headers(headers).build()?;

            let api = Api { client };

            let state = AppState {
                api,
                auth,
                store_path,
                settings,
            };

            app.manage(Mutex::new(state));
            Ok(())
        })
        .invoke_handler(tauri::generate_handler![
            commands::auth::login,
            commands::auth::logged_in,
            commands::auth::session_expired
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

#[derive(Deserialize, Serialize, Debug, Clone, Default)]
struct AppSettings {
    access_token: String,
    refresh_token: String,
    authenticated: bool,
    expires: DateTime<Utc>,
}
