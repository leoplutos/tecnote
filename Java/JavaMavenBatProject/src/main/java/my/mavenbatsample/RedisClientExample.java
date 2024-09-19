package my.mavenbatsample;

import java.util.UUID;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import redis.clients.jedis.ConnectionPoolConfig;
import redis.clients.jedis.JedisPooled;

public class RedisClientExample {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	public void redisClient() {
		// 连接参数
		int timeout = 1000;
		// Set<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
		// jedisClusterNodes.add(new HostAndPort("localhost", 6379));
		// jedisClusterNodes.add(new HostAndPort("127.0.0.1", 7380));
		// 建立连接
		// JedisCluster jedis = new JedisCluster(jedisClusterNodes,timeout);
		ConnectionPoolConfig config = new ConnectionPoolConfig();
		JedisPooled jedis = null;
		try {
			jedis = new JedisPooled(config, "localhost", 6379, timeout);
			jedis.ping();
		} catch (Exception e) {
			log.error("Redis连接失败", e);
			if (jedis != null) {
				jedis.close();
			}
			return;
		}

		// 设定Key
		String key = "JavaKey";
		String uuid = UUID.randomUUID().toString();
		String setValue = "使用Java客户端添加_" + uuid;
		jedis.set(key, setValue);
		log.info("添加Key成功    key={}    value={}", key, setValue);

		// 取得Key
		String getValue = jedis.get(key);
		log.info("取得Key成功    key={}    value={}", key, getValue);

		// 判断Key是否存在
		boolean isExists = jedis.exists(key);
		log.info("Key[{}]是否存在    {}", key, isExists);
		String notExistkey = "abcde";
		isExists = jedis.exists(notExistkey);
		log.info("Key[{}]是否存在    {}", notExistkey, isExists);

		// 为Key设置过期时间(秒)
		long expireSeconds = 10;
		jedis.expire(key, expireSeconds);
		log.info("设定Key[{}]的过期时间为：{}秒", key, expireSeconds);

		// 关闭连接
		jedis.close();
	}

	public static void main(String[] args) {
		try {
			RedisClientExample example = new RedisClientExample();
			example.redisClient();
		} catch (Exception e) {
			log.error(e);
		} finally {
			// 因为使用了异步日志，要在这里关闭
			LogManager.shutdown();
		}
	}
}
