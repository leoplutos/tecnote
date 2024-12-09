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
			CREATE TABLE t_employee (
				te_pk UUID NOT NULL UNIQUE,
				employee_id TEXT NOT NULL,
				employe_name TEXT,
				employe_email TEXT,
				employe_status SMALLINT,
				PRIMARY KEY(te_pk)
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
			// 默认情况下，Npgsql 连接是池化的：关闭或处置连接不会关闭底层物理连接，而是将其返回到由 Npgsql 管理的内部池
			var dataSourceBuilder = new NpgsqlDataSourceBuilder(connString);
			var dataSource = dataSourceBuilder.Build();
			await using var connection = await dataSource.OpenConnectionAsync();
			Log.Information("Postgre连接成功");

			// 插入3条t_employee数据
			for (int i = 0; i < 3; i++)
			{
				// 插入t_employee数据
				await using (var cmd = new NpgsqlCommand("INSERT INTO t_employee (te_pk, employee_id, employe_name, employe_status) VALUES (@te_pk, @employee_id, @employe_name, @employe_status)", connection))
				{
					// 创建UUID v7版本的主键
					string uuidv7 = Uuid.NewDatabaseFriendly(Database.PostgreSql).ToString();
					Guid te_pk = Guid.Parse(uuidv7);
					// 取得1到99的随机数
					int randomNumber = new Random().Next(1, 100);
					string employee_id = "dotnet_base_id_" + randomNumber;
					string employe_name = "dotnet_张三_" + randomNumber;
					int employe_status = 1;
					cmd.Parameters.AddWithValue("te_pk", NpgsqlDbType.Uuid, te_pk);
					cmd.Parameters.AddWithValue("employee_id", employee_id);
					cmd.Parameters.AddWithValue("employe_name", employe_name);
					cmd.Parameters.AddWithValue("employe_status", employe_status);
					await cmd.ExecuteNonQueryAsync();
					Log.Information("t_employee表插入成功, {te_pk}, {employee_id}, {employe_name}, {employe_status}", uuidv7, employee_id, employe_name, employe_status);
				}
			}

			// 查询t_employee所有数据
			// 创建一个List，其中每个元素都是Dictionary<string, string>类型
			List<Dictionary<string, string>> results = [];
			await using (var cmd = new NpgsqlCommand("SELECT * FROM t_employee", connection))
			await using (var reader = await cmd.ExecuteReaderAsync())
			{
				while (await reader.ReadAsync())
				{
					string te_pk = reader.GetFieldValue<Guid>(0).ToString();
					string employee_id = reader.GetString(1);
					string employe_name = reader.GetString(2);
					string? employe_email = reader.IsDBNull(reader.GetOrdinal("employe_email")) ? null : reader.GetString(reader.GetOrdinal("employe_email"));
					if (string.IsNullOrEmpty(employe_email))
					{
						employe_email = "N/A";
					}
					int employe_status = reader.GetInt16(4);
					// 创建字典并添加到List中
					Dictionary<string, string> record = new()
					{
						{ "te_pk", te_pk },
						{ "employee_id", employee_id },
						{ "employe_name", employe_name },
						{ "employe_email", employe_email },
						{ "employe_status", employe_status.ToString() },
					};
					results.Add(record);
				}
			}
			Log.Information("t_employee表全部数据查询成功");
			Log.Information("{results}", results);

			// 关闭数据库连接
			connection.Close();
		}
	}
}
