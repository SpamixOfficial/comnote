use std::ops::{RangeFrom};

use ts_rs::TS;
use chrono::{DateTime, Utc, Weekday};
use serde::{Deserialize, Serialize};
use url::Url;

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct ApiError {
    pub error: String,
    pub message: String,
}


#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct ApiPaging {
    pub next: Url
}


/// Alternative titles for the anime (and well-known registered synonyms)
#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct AlternativeTitles {
    pub en: String,
    pub ja: String,
    pub synonyms: Vec<String>
}

/// When is this usually broadcasted
#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct Broadcast {
    pub day_of_the_week: Weekday,
    pub start_time: DateTime<Utc>
}

/// Unsure about the usecase for this
#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct FavoriteInfo {
    pub added_at: DateTime<Utc>
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct Genre {
    pub id: usize,
    pub name: String
}

/// Picture/Image asset, containing medium and large sized images
#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct MainImageAsset {
    pub medium: Url,
    pub large: Url
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
#[serde(rename_all = "snake_case")]
pub enum AnimeType {
    Tv,
    Movie,
    Ova,
    Ona,
    Pv,
    Cm,
    Music,
    TvSpecial,
    Special,
    Unknown
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct Season {
    pub season: SeasonEnum,
    pub year: usize
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
#[serde(rename_all = "lowercase")]
pub enum SeasonEnum {
    Autumn,
    Summer,
    Spring,
    Fall,
    Winter
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
#[serde(rename_all = "snake_case")]
pub enum AiringStatus {
    NotYetAired,
    CurrentlyAiring,
    FinishedAiring
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
#[serde(rename_all = "snake_case")]
pub enum AgeRating {
    Pg13,
    Rx,
    RPlus,
    Pg,
    R,
    G
}

impl AgeRating {
    pub fn to_age_bracket(&self) -> RangeFrom<usize> {
        match self.to_owned() {
            Self::Pg13 => 13..,
            Self::G => 0..,
            Self::R => 17..,
            Self::Pg => 8..,
            Self::Rx => 18..,
            Self::RPlus => 17..
        }
    }
}

/// Ranking to search for (eg. Now Watching, Just Added, Airing, Trending, etc.)
#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
#[serde(rename_all = "snake_case")]
pub enum SearchRanking {
    JustAdded,
    MostPopular,
    NowWatching,
    Top10Airing,
    Top10Upcoming,
    TopAnime,
    Trending
}

/// Ranking in respective category
#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
pub struct Ranking {
    pub rank: usize,
    pub previous_rank: Option<usize>
}

#[derive(Debug, Clone, Serialize, Deserialize, TS)]
#[ts(export)]
#[serde(rename_all = "snake_case")]
pub enum SearchSort {
    /// Sort by rating (mean) (greatest to least)
    ScoreVal,
    /// Sort by amount of list-adds (most to least)
    TotalMembers,
    /// Sort by start_date, from latest to earliest
    StartDate,
    /// this means no sort at all
    Default 
}