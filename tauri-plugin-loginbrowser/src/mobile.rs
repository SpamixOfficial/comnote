use serde::de::DeserializeOwned;
use tauri::{
  plugin::{PluginApi, PluginHandle},
  AppHandle, Runtime,
};

use crate::models::*;

#[cfg(target_os = "ios")]
tauri::ios_plugin_binding!(init_plugin_login_browser);

// initializes the Kotlin or Swift plugin classes
pub fn init<R: Runtime, C: DeserializeOwned>(
  _app: &AppHandle<R>,
  api: PluginApi<R, C>,
) -> crate::Result<LoginBrowser<R>> {
  #[cfg(target_os = "android")]
  let handle = api.register_android_plugin("com.plugin.login_browser", "BrowserPlugin")?;
  #[cfg(target_os = "ios")]
  let handle = api.register_ios_plugin(init_plugin_login_browser)?;
  Ok(LoginBrowser(handle))
}

/// Access to the login-browser APIs.
pub struct LoginBrowser<R: Runtime>(PluginHandle<R>);

impl<R: Runtime> LoginBrowser<R> {

  pub fn open_login(&self) -> crate::Result<LoginResponse> {
    self
      .0
      .run_mobile_plugin("openLogin", ())
      .map_err(Into::into)
  }
}
