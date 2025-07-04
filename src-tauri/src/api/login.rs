use std::sync::Arc;

use anyhow::{anyhow, Result};
use reqwest::{Client, StatusCode};

use crate::api::{handle_error, models::{generic::ApiError, responses::OAuthResponse}, CLIENT_ID};


#[derive(Debug)]
pub struct ApiLogin {
    pub client: Arc<Client>
}

impl ApiLogin {
    pub fn new(client: &Arc<Client>) -> Self {
        return Self {
            client: Arc::clone(client)
        }
    }

    pub async fn consume_code(&self, code: String, verifier: String) -> Result<OAuthResponse> {
        let form = [
            ("client_id", CLIENT_ID),
            ("code", &code),
            ("redirect_uri", "net.myanimelist://login.input"), // must be present, otherwise the flow will fail!
            ("code_verifier", &verifier),
            ("grant_type", "authorization_code"),
        ];

        let raw_response = self
            .client
            .post("https://myanimelist.net/v1/oauth2/token")
            .header("Content-Type", "application/x-www-form-urlencoded")
            .form(&form)
            .send()
            .await?;

        handle_error::<OAuthResponse>(raw_response).await
    }

    pub async fn refresh_token(
        &self,
        refresh_token: String,
        verifier: String,
    ) -> Result<OAuthResponse> {
        let form = [
            ("client_id", CLIENT_ID),
            ("refresh_token", &refresh_token),
            ("redirect_uri", "net.myanimelist://login.input"),
            ("code_verifier", &verifier),
            ("grant_type", "refresh_token"),
        ];

        let raw_response = self
            .client
            .post("https://myanimelist.net/v1/oauth2/token")
            .header("Content-Type", "application/x-www-form-urlencoded")
            .form(&form)
            .send()
            .await?;

        handle_error::<OAuthResponse>(raw_response).await
    }
}
