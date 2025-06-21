use tauri::{
  plugin::{Builder, TauriPlugin},
  Manager, Runtime,
};

pub use models::*;

#[cfg(desktop)]
mod desktop;
#[cfg(mobile)]
mod mobile;

mod commands;
mod error;
mod models;

pub use error::{Error, Result};

#[cfg(desktop)]
use desktop::LoginBrowser;
#[cfg(mobile)]
use mobile::LoginBrowser;

/// Extensions to [`tauri::App`], [`tauri::AppHandle`] and [`tauri::Window`] to access the login-browser APIs.
pub trait LoginBrowserExt<R: Runtime> {
  fn login_browser(&self) -> &LoginBrowser<R>;
}

impl<R: Runtime, T: Manager<R>> crate::LoginBrowserExt<R> for T {
  fn login_browser(&self) -> &LoginBrowser<R> {
    self.state::<LoginBrowser<R>>().inner()
  }
}

/// Initializes the plugin.
pub fn init<R: Runtime>() -> TauriPlugin<R> {
  Builder::new("login-browser")
    .invoke_handler(tauri::generate_handler![commands::open_login])
    .setup(|app, api| {
      #[cfg(mobile)]
      let login_browser = mobile::init(app, api)?;
      #[cfg(desktop)]
      let login_browser = desktop::init(app, api)?;
      app.manage(login_browser);
      Ok(())
    })
    .build()
}
