use tauri::{AppHandle, command, Runtime};

use crate::models::*;
use crate::Result;
use crate::LoginBrowserExt;

#[command]
pub(crate) async fn open_login<R: Runtime>(
    app: AppHandle<R>,
) -> Result<LoginResponse> {
    app.login_browser().open_login()
}
