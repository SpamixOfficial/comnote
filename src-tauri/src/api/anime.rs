use std::sync::Arc;
use reqwest::Client;

#[derive(Debug, Gener)]
pub struct ApiAnime {
    client: Arc<Client>
}

impl ApiAnime {
    pub fn new(client: &Arc<Client>) -> Self {
        return Self {
            client: Arc::clone(client)
        }
    }
}