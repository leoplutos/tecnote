use etcd_client::{Client, ConnectOptions, Error, EventType, GetOptions, PutOptions};
use std::time::Duration;
use tracing as log;
use uuid::Uuid;

static PREFIX: &'static str = "/RustKey";

struct KV {
    key: String,
    value: String,
}
impl KV {
    #[inline]
    pub fn new(key: impl Into<String>, value: impl Into<String>) -> Self {
        KV {
            key: key.into(),
            value: value.into(),
        }
    }
    #[inline]
    pub fn key(&self) -> &str {
        &self.key
    }
    #[inline]
    pub fn value(&self) -> &str {
        &self.value
    }
}

async fn etcd_client() -> Result<(), Error> {
    // 连接参数
    let conn_timeout: u64 = 1000;
    let option =
        Some(ConnectOptions::new().with_connect_timeout(Duration::from_millis(conn_timeout)));
    // 建立连接
    let mut client = Client::connect(["localhost:2379"], option).await?;
    let resp = client.status().await;
    match resp {
        Ok(resp) => {
            log::info!("Etcd连接成功 Version:{}", resp.version());
        }
        Err(error) => {
            log::error!("Etcd连接失败: {:?}", error);
            panic!();
        }
    };

    // 设定Key
    let key_1: String = format!("{}{}", PREFIX, "/Key1");
    let set_value_1: String = format!("使用Rust客户端添加_{}", Uuid::new_v4().to_string());
    let kv1 = KV::new(key_1, set_value_1);
    let key_2: String = format!("{}{}", PREFIX, "/Key2");
    let set_value_2: String = format!("使用Rust客户端添加_{}", Uuid::new_v4().to_string());
    let kv2 = KV::new(key_2, set_value_2);
    let _ = client.put(kv1.key(), kv1.value(), None).await?;
    log::info!("添加Key成功    key={}    value={}", kv1.key(), kv1.value());
    let _ = client.put(kv2.key(), kv2.value(), None).await?;
    log::info!("添加Key成功    key={}    value={}", kv2.key(), kv2.value());

    // 取得Key
    let resp = client.get(kv1.key(), None).await?;
    if let Some(kv) = resp.kvs().first() {
        log::info!(
            "取得Key成功    key={}    value={}",
            kv.key_str()?,
            kv.value_str()?
        );
    }

    // 取得Key（前缀机制）
    // 前缀查询
    let resp = client
        .get(PREFIX, Some(GetOptions::new().with_prefix()))
        .await?;
    log::info!("取得前缀成功    prefix={}", PREFIX);
    for kv in resp.kvs() {
        log::info!("key={}    value={}", kv.key_str()?, kv.value_str()?);
    }

    // 分布式锁
    let lock_key: String = format!("{}{}", PREFIX, "/lock");
    let resp = client.lock(lock_key.clone(), None).await?;
    let lock_resp_key = resp.key();
    let lock_resp_key_utf8 = std::str::from_utf8(lock_resp_key)?;
    log::info!(
        "[加锁]分布式锁成功    lockKey={}    lockResKey={}",
        lock_key,
        lock_resp_key_utf8
    );
    log::info!("5秒后解锁,此期间运行 [etcdctl lock /RustKey/lock] 会一直等待");
    tokio::time::sleep(Duration::from_secs(5)).await;
    client.unlock(lock_resp_key).await?;
    log::info!("[解锁]分布式锁成功    lockResKey={}", lock_resp_key_utf8);

    // 调用租约函数
    let _ = lease_register(&mut client).await?;

    // 调用监听函数
    let _ = watch_service(&mut client).await?;

    Ok(())
}

// 租约函数
async fn lease_register(client: &mut Client) -> Result<(), Error> {
    // 创建租约
    let ttl: i64 = 5;
    let resp = client.lease_grant(ttl, None).await?;
    let lease_id = resp.id();
    log::info!("创建租约(Lease)成功    leaseId={}", lease_id);
    // 写入key-value值时绑定一个租约，租约到期后，key会被删除
    let lease_key: String = format!("{}{}", PREFIX, "/LsKey1");
    let lease_value: String = String::from("此Key会自动被删除");
    let lease_kv = KV::new(lease_key, lease_value);
    let _ = client
        .put(
            lease_kv.key(),
            lease_kv.value(),
            Some(PutOptions::new().with_lease(lease_id)),
        )
        .await?;
    log::info!(
        "添加租约Key成功    key={}    value={}    leaseId={}",
        lease_kv.key(),
        lease_kv.value(),
        lease_id
    );

    // 持续续约
    // client.lease_keep_alive(lease_id).await?;

    Ok(())
}

// 监听函数
async fn watch_service(client: &mut Client) -> Result<(), Error> {
    let watch_key: String = format!("{}{}", PREFIX, "/LsKey1");
    let (watcher, mut stream) = client.watch(watch_key, None).await?;
    log::info!("添加监听器成功 watch_id:{}", watcher.watch_id());
    while let Some(resp) = stream.message().await? {
        for event in resp.events() {
            if EventType::Delete == event.event_type() {
                if let Some(kv) = event.kv() {
                    log::info!("租约  key={} 到期，续租", kv.key_str()?);
                }
                let _ = lease_register(client).await;
            }
        }
    }
    Ok(())
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    // install global collector configured based on RUST_LOG env var.
    tracing_subscriber::fmt::init();

    let _ = etcd_client().await?;

    Ok(())
}
