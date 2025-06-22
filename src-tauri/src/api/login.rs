use anyhow::Result;
use serde::{Deserialize, Serialize};

use crate::api::Api;

const CLIENT_ID: &str = "df368c0b8286b739ee77f0b905960700";

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct OAuthResponse {
    #[serde(rename = "expires_in")]
    pub expires_in: isize,
    #[serde(rename = "access_token")]
    pub access_token: String,
    #[serde(rename = "refresh_token")]
    pub refresh_token: String,
}

impl Api {
    pub async fn consume_code(&self, code: String, verifier: String) -> Result<OAuthResponse> {
        let query = [
            ("client_id", CLIENT_ID),
            ("code", &code),
            (
                "code_verifier",
                &verifier,
            ),
            ("grant_type", "authorization_code"),
        ];

        let response: OAuthResponse = self
            .client
            .post("https://myanimelist.net/v1/oauth2/token")
            .query(&query)
            .send()
            .await?
            .json()
            .await?;

        Ok(response)
    }
}
