use reqwest::Client;

mod login;

#[derive(Debug)]
pub struct Api {
    pub client: Client
}