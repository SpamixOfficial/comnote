use serde::{Deserialize, Serialize};
use tauri::ipc::Channel;

#[derive(Debug, Clone, Default, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LoginResponse {
  pub code: String,
  pub verifier: String
}

#[derive(Clone, Serialize)]
pub struct LoginPayload {
  pub channel: Channel
}