use serde::de::DeserializeOwned;
use tauri::{plugin::PluginApi, AppHandle, Runtime};

use crate::models::*;

pub fn init<R: Runtime, C: DeserializeOwned>(
  app: &AppHandle<R>,
  _api: PluginApi<R, C>,
) -> crate::Result<LoginBrowser<R>> {
  Ok(LoginBrowser(app.clone()))
}

/// Access to the login-browser APIs.
pub struct LoginBrowser<R: Runtime>(AppHandle<R>);

impl<R: Runtime> LoginBrowser<R> {
  pub fn open_login(&self) -> crate::Result<LoginResponse> {
    Ok(LoginResponse {
      code: String::from("abc")
    })
  }

}
