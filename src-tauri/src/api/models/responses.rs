use chrono::{DateTime, Duration, Utc};
use serde::{Deserialize, Serialize};

use crate::api::models::generic::{
    AiringStatus, AlternativeTitles, AnimeType, Broadcast, FavoriteInfo, Genre, MainImageAsset, Ranking, Season
};

/// Response from the oauth process
#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct OAuthResponse {
    pub expires_in: isize,
    pub access_token: String,
    pub refresh_token: String,
}

// ------- anime.rs -------

/// An anime object meant for info-display (summary)
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AnimeSummary {
    pub alternative_titles: AlternativeTitles,
    pub average_episode_duration: Duration,
    pub background: Option<String>,
    pub broadcast: Option<Broadcast>,
    pub created_at: DateTime<Utc>,
    pub end_date: Option<DateTime<Utc>>,
    pub favorites_info: Option<FavoriteInfo>,
    pub genres: Vec<Genre>,
    pub id: usize,
    pub main_picture: MainImageAsset,

    #[serde(rename = "mean")]
    pub rating: Option<usize>,
    pub media_type: AnimeType,
    pub num_episodes: usize,
    pub num_favorites: usize,

    #[serde(rename = "num_list_users")]
    pub num_in_lists: usize,

    #[serde(rename = "popularity")]
    pub rank_in_lists: usize,
    pub rank: usize,
    pub start_date: Option<DateTime<Utc>>,
    pub start_season: Option<Season>,
    pub status: AiringStatus,
    pub synopsis: String,
    pub title: String,
    pub updated_at: DateTime<Utc>,

    // Only present in ranking posts
    pub ranking: Option<Ranking>


    // Not needed in our case, but if you're building an API based on this feel free to implement this as well!
    //pub my_list_status: MyListStatus
}
