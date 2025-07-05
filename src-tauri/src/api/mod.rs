use std::sync::Arc;

use anyhow::{anyhow, Result};
use reqwest::{Client, Response, StatusCode};
use serde::de::DeserializeOwned;
use tauri::http::HeaderMap;

use crate::api::{anime::ApiAnime, login::ApiLogin, models::generic::ApiError};

pub const CLIENT_ID: &str = "df368c0b8286b739ee77f0b905960700";
pub const API_BASE: &str = "https://api.myanimelist.net/v3";

pub mod models;

mod anime;
mod login;

#[derive(Debug)]
pub struct Api {
    pub login: ApiLogin,
    pub anime: ApiAnime,
}

pub async fn handle_error<T: DeserializeOwned>(response: Response) -> Result<T> {
    let status = response.status();
    let response_text = response.text().await?;

    if status != StatusCode::OK {
        let err_val: ApiError = match serde_json::from_str(&response_text) {
            Ok(x) => x,
            Err(e) => ApiError {
                error: "Decode Error".to_string(),
                message: e.to_string(),
            },
        };

        eprintln!(
            "API Call Failed: [\n\tE: \"{}\"\n\tM: \"{}\"\n]",
            err_val.error, err_val.message
        );

        return Err(anyhow!(err_val.message));
    }

    match serde_json::from_str::<T>(&response_text) {
        Err(e) => Err(anyhow!(format!(
            "Error: {}\n\nContents:\n---\n{}",
            e.to_string(),
            response_text
        ))),
        Ok(x) => Ok(x),
    }
}

pub fn default_headers() -> Result<HeaderMap> {
    let mut headers = HeaderMap::new();
    headers.append("Host", "api.myanimelist.net".parse()?);
    headers.append("X-Mal-Client-Id", CLIENT_ID.parse()?);
    headers.append("User-Agent", "MAL (android, 2.3.15)".parse()?);
    return Ok(headers);
}
impl Api {
    pub fn new(client: Client) -> Self {
        let client: Arc<Client> = Arc::new(client);

        let login: ApiLogin = ApiLogin::new(&client);
        let anime: ApiAnime = ApiAnime::new(&client);

        Api { login, anime }
    }
}
