using Microsoft.Extensions.Configuration;
using Npgsql;
using NpgsqlTypes;
using Serilog;
using UUIDNext;

namespace dotnet_console_sample.Postgre
{
	// Postgre的基础示例
	class PostgreBase
	{
		// appsettings.json 和 环境变量
		private readonly IConfiguration _config;

		public PostgreBase(IConfiguration config)
		{
			_config = config;
		}
		// 程序入口
		public async Task PostgreBaseStart()
		{
			// 需要1: dotnet add package Npgsql
			// 需要2: docker run -p 5432:5432 --name postgre -v $HOME/workspace/postgre_data/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
			// 需要3: 建表
			/*
			CREATE TABLE t_login (
				tl_pk UUID NOT NULL UNIQUE,
				login_id TEXT NOT NULL,
				login_pwd TEXT NOT NULL,
				PRIMARY KEY(tl_pk)
			);
			*/
			// 更多看这里: https://www.npgsql.org/doc/index.html

			string? host = _config["PostgreSettings:Host"];
			string? port = _config["PostgreSettings:Port"];
			string? database = _config["PostgreSettings:Database"];
			string? username = _config["PostgreSettings:Username"];
			string? password = _config["PostgreSettings:Password"];
			string connString = $"Host={host};Port={port};Username={username};Password={password};Database={database}";
			Log.Information("Postgre连接URL: {connString}", connString);

			// 连接数据库
			var dataSourceBuilder = new NpgsqlDataSourceBuilder(connString);
			var dataSource = dataSourceBuilder.Build();
			await using var connection = await dataSource.OpenConnectionAsync();
			Log.Information("Postgre连接成功");

			// 插入3条t_login数据
			for (int i = 0; i < 3; i++)
			{
				// 插入t_login数据
				await using (var cmd = new NpgsqlCommand("INSERT INTO t_login (tl_pk, login_id, login_pwd) VALUES (@tl_pk, @login_id, @login_pwd)", connection))
				{
					// 创建UUID v7版本的主键
					string uuidv7 = Uuid.NewDatabaseFriendly(Database.PostgreSql).ToString();
					Guid tl_pk = Guid.Parse(uuidv7);
					// 取得1到99的随机数
					int randomNumber = new Random().Next(1, 100);
					string login_id = "admin" + randomNumber;
					string login_pwd = "pwd" + randomNumber;
					cmd.Parameters.AddWithValue("tl_pk", NpgsqlDbType.Uuid, tl_pk);
					cmd.Parameters.AddWithValue("login_id", login_id);
					cmd.Parameters.AddWithValue("login_pwd", login_pwd);
					await cmd.ExecuteNonQueryAsync();
					Log.Information("t_login表插入成功, {tl_pk}, {login_id}, {login_pwd}", uuidv7, login_id, login_pwd);
				}
			}

			// 查询t_login所有数据
			// 创建一个List，其中每个元素都是Dictionary<string, string>类型
			List<Dictionary<string, string>> results = [];
			await using (var cmd = new NpgsqlCommand("SELECT * FROM t_login", connection))
			await using (var reader = await cmd.ExecuteReaderAsync())
			{
				while (await reader.ReadAsync())
				{
					string tl_pk = reader.GetFieldValue<Guid>(0).ToString();
					string login_id = reader.GetString(1);
					string login_pwd = reader.GetString(2);
					// 创建字典并添加到List中
					Dictionary<string, string> record = new()
					{
						{ "tl_pk", tl_pk },
						{ "login_id", login_id },
						{ "login_pwd", login_pwd }
					};
					results.Add(record);
				}
			}
			Log.Information("t_login表查询成功");
			Log.Information("{results}", results);
		}
	}
}
