use std::sync::Arc;

use reqwest::Client;

use crate::api::login::ApiLogin;

pub const CLIENT_ID: &str = "df368c0b8286b739ee77f0b905960700";

mod models;

mod login;
mod anime;

#[derive(Debug)]
pub struct Api {
    pub login: ApiLogin,
}

impl Api {
    pub fn new(client: Client) -> Self {
        let client: Arc<Client> = Arc::new(client);
        let login: ApiLogin = ApiLogin::new(&client);

        Api {
            login
        }
    }
}