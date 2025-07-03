use std::sync::Arc;

use anyhow::{anyhow, Result};
use reqwest::{Client, Response, StatusCode};
use serde::de::DeserializeOwned;

use crate::api::{anime::ApiAnime, login::ApiLogin, models::generic::ApiError};

pub const CLIENT_ID: &str = "df368c0b8286b739ee77f0b905960700";
pub const API_BASE: &str = "https://api.myanimelist.net/v3";

mod models;

mod login;
mod anime;

#[derive(Debug)]
pub struct Api {
    pub login: ApiLogin,
    pub anime: ApiAnime
}

pub async fn handle_error<T: DeserializeOwned>(response: Response) -> Result<T> {
    if response.status() != StatusCode::OK {
            let err_val: ApiError = response.json().await?;

            #[cfg(debug_assertions)]
            eprintln!(
                "API Call Failed: [\n\tE: \"{}\"\n\tM:\"{}\"\n]",
                err_val.error, err_val.message
            );

            return Err(anyhow!(err_val.message));
        }

        let serialized_response: T = response.json().await?;
        Ok(serialized_response)
}

impl Api {
    pub fn new(client: Client) -> Self {
        let client: Arc<Client> = Arc::new(client);

        let login: ApiLogin = ApiLogin::new(&client);
        let anime: ApiAnime = ApiAnime::new(&client);

        Api {
            login,
            anime
        }
    }
}