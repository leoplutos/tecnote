use rw_core::{MODULE_NAME, MODULE_VERSION, PI};
use uuid::Uuid;

fn main() {
    let app_nm = format!("rw_app/main.rs -> {}", Uuid::new_v4().to_string());
    println!("{}", app_nm);
    println!("MODULE_NAME = {}", MODULE_NAME);
    println!("MODULE_VERSION = {}", MODULE_VERSION);
    println!("PI = {}", PI);
}
