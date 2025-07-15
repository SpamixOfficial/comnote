use tauri::ipc::Channel;
use tauri::{command, AppHandle, Runtime, Window};

use crate::models::*;
use crate::Result;
use crate::LoginBrowserExt;

#[command]
pub async fn open_login<R: Runtime>(app: AppHandle<R>, _: Window<R>, channel: Channel) -> Result<LoginResponse> {
    app.login_browser().open_login(channel)
}
