use chrono::Utc;
use jsonwebtoken::{
    errors::Error as JwtError, Algorithm, DecodingKey, EncodingKey, Header, TokenData, Validation,
};
use serde::{Deserialize, Serialize};

// JWT实现

const JWT_SECRET: &[u8] = b"Jwt_Secret";

// 创建token
pub fn create_jwt(user_id: &String) -> String {
    let expiration: i64 = Utc::now()
        .checked_add_signed(chrono::Duration::seconds(3600))
        .expect("valid timestamp")
        .timestamp();

    let header: Header = Header::new(Algorithm::HS512);
    let claims: Claims = Claims::new(user_id, expiration as usize);

    //jsonwebtoken::encode(&header, &claims, &EncodingKey::from_secret(JWT_SECRET)).map(|s| format!("Bearer {}", s)).unwrap()
    jsonwebtoken::encode(&header, &claims, &EncodingKey::from_secret(JWT_SECRET))
        .map(|s| format!("{}", s))
        .unwrap()
}

// 验证token
pub fn validate_token(token: &str) -> Result<TokenData<Claims>, JwtError> {
    let validation: Validation = Validation::new(Algorithm::HS512);
    let key: DecodingKey = DecodingKey::from_secret(JWT_SECRET);
    let data = jsonwebtoken::decode::<Claims>(token, &key, &validation)?;
    Ok(data)
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Claims {
    iss: String,
    pub exp: usize,
    // 保存的用户id
    pub id: String,
}

impl Claims {
    pub fn new(id: &String, exp: usize) -> Self {
        Self {
            iss: "test".to_owned(),
            id: id.clone(),
            exp,
        }
    }
}
