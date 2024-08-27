using Serilog;
using StackExchange.Redis;

namespace dotnet_console_sample.Redis
{
	class RedisClientExample
	{
		public void RedisClient()
		{
			// 连接参数
			ConfigurationOptions config = new ConfigurationOptions
			{
				ConnectRetry = 0,
				// 毫秒
				ConnectTimeout = 1000
			};
			// .Net Framework 用法
			//config.get_EndPoints().Add("localhost", 6379);
			// .Net Core 用法
			config.EndPoints.Add("localhost", 6379);

			// 建立连接
			// ConnectionMultiplexer redis = ConnectionMultiplexer.Connect("localhost");
			// ConnectionMultiplexer redis = ConnectionMultiplexer.Connect("server1:6379,server2:6379");
			ConnectionMultiplexer redisConn = null;
			try
			{
				redisConn = ConnectionMultiplexer.Connect(config);
			}
			catch (Exception e)
			{
				Log.Error(e, "Redis连接失败");
				return;
			}

			// 使用IDatabase访问Redis API
			IDatabase redisCache = redisConn.GetDatabase();

			// 设定Key
			string key = "CSharpKey";
			string uuid = Guid.NewGuid().ToString();
			string setValue = "使用C#客户端添加_" + uuid;
			//await redisCache.StringSetAsync(key, "");
			redisCache.StringSet(key, setValue);
			//Console.WriteLine($"添加Key成功    key={key}    value={setValue}");
			Log.Information("添加Key成功    key={key}    value={value}", key, setValue);

			// 取得Key
			//string value = await redisCache.StringGetAsync(key);
			string getValue = redisCache.StringGet(key);
			Log.Information("取得Key成功    key={key}    value={value}", key, getValue);

			// 判断Key是否存在
			bool isExists = redisCache.KeyExists(key);
			Log.Information("Key[{key}]是否存在    {isExists}", key, isExists);
			string notExistkey = "abcde";
			isExists = redisCache.KeyExists(notExistkey);
			Log.Information("Key[{key}]是否存在    {isExists}", notExistkey, isExists);

			// 为Key设置过期时间(秒)
			int expireSeconds = 10;
			redisCache.KeyExpire(key, TimeSpan.FromSeconds(expireSeconds));
			Log.Information("设定Key[{key}]的过期时间为：{expireSeconds}秒", key, expireSeconds);

			// 关闭连接
			redisConn.Close();

			//Console.WriteLine("按任意键继续");
			//Console.ReadKey();
		}
	}
}
