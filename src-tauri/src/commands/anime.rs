use anyhow::Result;
use tauri::{async_runtime::Mutex, State};

use crate::{api::models::responses::AnimeResponse, AppState};


#[tauri::command]
pub async fn get_just_added(state: State<'_, Mutex<AppState>>, limit: usize, offset: usize) -> Result<AnimeResponse, String> {
    let state = state.lock().await;

    let resp = match state.api.anime.get_just_added(limit, offset).await {
        Err(e) => return Err(e.to_string()),
        Ok(x) => x,
    };

    Ok(resp)
}