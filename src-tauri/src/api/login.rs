use anyhow::{anyhow, Result};
use reqwest::StatusCode;
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

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct OAuthError {
    pub error: String,
    pub message: String,
}

impl Api {
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

        if raw_response.status() != StatusCode::OK {
            let err_val: OAuthError = raw_response.json().await?;

            #[cfg(debug_assertions)]
            eprintln!(
                "Login Failed: [\n\tE: \"{}\"\n\tM:\"{}\"\n]",
                err_val.error, err_val.message
            );

            return Err(anyhow!(err_val.message));
        }

        let response: OAuthResponse = raw_response.json().await?;
        Ok(response)
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

        if raw_response.status() != StatusCode::OK {
            let err_val: OAuthError = raw_response.json().await?;

            #[cfg(debug_assertions)]
            eprintln!(
                "Token-Refresh Failed: [\n\tE: \"{}\"\n\tM:\"{}\"\n]",
                err_val.error, err_val.message
            );

            return Err(anyhow!(err_val.message));
        }

        let response: OAuthResponse = raw_response.json().await?;
        Ok(response)
    }
}
