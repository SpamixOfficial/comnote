use reqwest::{Client, ClientBuilder};
use tauri::{http::HeaderMap, Manager};

#[derive(Debug)]
pub struct AppState {
    client: Client,
    access_token: String,
    refresh_token: String,
    authenticated: bool,
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
        .setup(|app| {
            let mut headers = HeaderMap::new();
            headers.append(
                "X-Mal-Client-Id",
                "df368c0b8286b739ee77f0b905960700".parse().unwrap(),
            );
            headers.append("User-Agent", "MAL (android, 2.3.15)".parse().unwrap());
            let client = Client::builder().default_headers(headers).build();
            // continue this later :D
            //AppState {}
            //app.manage(state)
        })
        .plugin(tauri_plugin_opener::init())
        .plugin(tauri_plugin_login_browser::init())
        .invoke_handler(tauri::generate_handler![greet])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}