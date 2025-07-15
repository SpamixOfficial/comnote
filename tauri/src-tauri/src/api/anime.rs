use anyhow::Result;
use reqwest::Client;
use std::sync::Arc;

use crate::api::{default_headers, handle_error, models::responses::AnimeResponse, API_BASE};

#[derive(Debug)]
pub struct ApiAnime {
    client: Arc<Client>,
}

impl ApiAnime {
    pub fn new(client: &Arc<Client>) -> Self {
        return Self {
            client: Arc::clone(client),
        };
    }

    /// Limit number of returned items to `limit`
    /// Start returning items from index `offset`
    pub async fn get_just_added(&self, limit: usize, offset: usize) -> Result<AnimeResponse> {
        let form = [
            ("total_members", "50"),
            ("limit", &format!("{}", limit)),
            ("offset", &format!("{}", offset)), // must be present, otherwise the flow will fail!
            ("sort", "created_at"),
            ("fields", "alternative_titles,media_type,num_episodes,status,start_date,end_date,average_episode_duration,synopsis,mean,genres,rank,popularity,num_list_users,num_favorites,favorites_info,num_scoring_users,start_season,broadcast,my_list_status{start_date,finish_date},nsfw,created_at,updated_at"),
        ];

        let raw_response = self
            .client
            .get(API_BASE.to_owned() + "/anime")
            .headers(default_headers()?)
            .query(&form)
            .send()
            .await?;
        handle_error::<AnimeResponse>(raw_response).await
    }
}
