use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use ts_rs::TS;

use crate::api::models::generic::{
    AiringStatus, AlternativeTitles, ApiPaging, AnimeType, Broadcast, FavoriteInfo, Genre, MainImageAsset, Ranking, Season
};

/// Response from the oauth process
#[derive(Debug, Clone, Deserialize, Serialize, TS)]
#[ts(export)]
pub struct OAuthResponse {
    pub expires_in: isize,
    pub access_token: String,
    pub refresh_token: String,
}

// ------- anime.rs -------

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct AnimeResponse {
    pub data: Vec<AnimeSummaryWrapper>,
    pub paging: ApiPaging
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct AnimeSummaryWrapper {
    pub node: AnimeSummary
}

/// An anime object meant for info-display (summary)
#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct AnimeSummary {
    pub alternative_titles: AlternativeTitles,
    pub average_episode_duration: usize,
    pub background: Option<String>,
    pub broadcast: Option<Broadcast>,
    /// unix timestamp
    pub created_at: DateTime<Utc>,
    pub end_date: Option<String>, // TODO: get YYYY-[MM]-[DD] parsing working
    pub favorites_info: Option<FavoriteInfo>,
    #[serde(default)]
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
    pub rank: Option<usize>, // never seen this but their Java models says it exists????? Putting option for now...
    pub start_date: Option<String>, // TODO: get YYYY-[MM]-[DD] parsing working
    pub start_season: Option<Season>,
    pub status: Option<AiringStatus>,
    pub synopsis: String,
    pub title: String,
    pub updated_at: DateTime<Utc>,

    // Only present in ranking posts
    pub ranking: Option<Ranking>


    // Not needed in our case, but if you're building an API based on this feel free to implement this as well!
    //pub my_list_status: MyListStatus
}
