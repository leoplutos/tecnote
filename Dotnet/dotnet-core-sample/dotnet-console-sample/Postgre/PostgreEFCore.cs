using Microsoft.Extensions.Configuration;
using Serilog;
using UUIDNext;

namespace dotnet_console_sample.Postgre
{
	// Postgre的ORM示例
	class PostgreEFCore
	{
		// appsettings.json 和 环境变量
		private readonly IConfiguration _config;

		public PostgreEFCore(IConfiguration config)
		{
			_config = config;
		}
		// 程序入口
		public async Task PostgreEFCoreStart()
		{
			// 前提1: Entity Framework Core是什么？
			// https://learn.microsoft.com/zh-cn/ef/core/
			// 前提2: EF Core 入门
			// https://learn.microsoft.com/zh-cn/ef/core/get-started/overview/first-app

			// 需要1: dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL
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
			// 更多看这里: https://www.npgsql.org/efcore/index.html

			// 创建EFCore实例, 连接数据库
			using var dbContext = new PostgreDbContext(_config);
			Log.Information("Postgre连接URL: {ConnString}", dbContext.ConnString);
			Log.Information("Postgre连接成功");

			// 插入3条t_login数据
			for (int i = 0; i < 3; i++)
			{
				// 创建UUID v7版本的主键
				string uuidv7 = Uuid.NewDatabaseFriendly(Database.PostgreSql).ToString();
				Guid tl_pk = Guid.Parse(uuidv7);
				// 取得1到99的随机数
				int randomNumber = new Random().Next(1, 100);
				string login_id = "admin" + randomNumber;
				string login_pwd = "pwd" + randomNumber;
				Login login = new()
				{
					TlPk = tl_pk,
					LoginId = login_id,
					LoginPwd = login_pwd
				};
				dbContext.Add(login);
				await dbContext.SaveChangesAsync();
				Log.Information("t_login表插入成功, {tl_pk}, {login_id}, {login_pwd}", uuidv7, login_id, login_pwd);
			}
			// 查询t_login中的最新
			var minLogin = dbContext.Logins
				.OrderBy(l => l.LoginId)
				.First();
			Log.Information("t_login表查询最小结果, {tl_pk}, {login_id}, {login_pwd}", minLogin.TlPk, minLogin.LoginId, minLogin.LoginPwd);

			// 更新t_login中的数据
			minLogin.LoginPwd = "changed" + new Random().Next(1, 100);
			await dbContext.SaveChangesAsync();
			Log.Information("t_login表更新成功, {tl_pk}, {login_id}, {login_pwd}", minLogin.TlPk, minLogin.LoginId, minLogin.LoginPwd);

			// 找到最大的并删除
			// 查询t_login中的最新
			var maxLogin = dbContext.Logins
				.OrderByDescending(l => l.LoginId)
				.First();
			Log.Information("t_login表查询最大结果, {tl_pk}, {login_id}, {login_pwd}", maxLogin.TlPk, maxLogin.LoginId, maxLogin.LoginPwd);
			dbContext.Remove(maxLogin);
			await dbContext.SaveChangesAsync();
			Log.Information("t_login表删除成功");

			// 最后只留下5条数据
			// 获取前5条数据
			var topFiveEntities = dbContext.Logins.OrderBy(l => l.LoginId).Take(5);
			// 获取除了前5条数据之外的所有数据
			var deleteEntities = dbContext.Logins.Except(topFiveEntities);
			// 执行删除操作
			dbContext.Logins.RemoveRange(deleteEntities);
			await dbContext.SaveChangesAsync();
			Log.Information("数据清理成功");
		}
	}
}
