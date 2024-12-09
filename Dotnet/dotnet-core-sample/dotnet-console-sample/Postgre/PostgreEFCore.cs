using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
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
			CREATE TABLE t_employee (
				te_pk UUID NOT NULL UNIQUE,
				employee_id TEXT NOT NULL,
				employe_name TEXT,
				employe_email TEXT,
				employe_status SMALLINT,
				PRIMARY KEY(te_pk)
			);
			*/
			// 更多看这里: https://www.npgsql.org/efcore/index.html

			// 创建EFCore实例, 连接数据库
			string? host = _config["PostgreSettings:Host"];
			string? port = _config["PostgreSettings:Port"];
			string? database = _config["PostgreSettings:Database"];
			string? username = _config["PostgreSettings:Username"];
			string? password = _config["PostgreSettings:Password"];
			string connString = $"Host={host};Port={port};Username={username};Password={password};Database={database}";
			Log.Information("Postgre连接URL: {connString}", connString);
			// using var dbContext = new PostgreDbContext(_config);
			var dbContextFactory = new PooledDbContextFactory<PostgreDbContext>(new DbContextOptionsBuilder<PostgreDbContext>().UseNpgsql(connString).Options);
			var dbContext = dbContextFactory.CreateDbContext();
			Log.Information("Postgre连接成功");

			// 插入3条t_employee数据
			for (int i = 0; i < 3; i++)
			{
				// 创建UUID v7版本的主键
				string uuidv7 = Uuid.NewDatabaseFriendly(Database.PostgreSql).ToString();
				Guid te_pk = Guid.Parse(uuidv7);
				// 取得1到99的随机数
				int randomNumber = new Random().Next(1, 100);
				string employee_id = "dotnet_orm_id_" + randomNumber;
				string employe_name = "dotnet_张三_" + randomNumber;
				int employe_status = 1;
				Employee employee = new()
				{
					TePk = te_pk,
					EmployeeId = employee_id,
					EmployeName = employe_name,
					EmployeStatus = employe_status
				};
				dbContext.Add(employee);
				await dbContext.SaveChangesAsync();
				Log.Information("t_employee表插入成功, {employee}", employee);
			}
			// 查询t_employee中的最新
			var minEmployee = dbContext.Employees
				.OrderBy(l => l.EmployeeId)
				.First();
			Log.Information("t_employee表查询最小结果, {minEmployee}", minEmployee);

			// 更新t_employee中的数据
			int anotherRandomNumber = new Random().Next(1, 100);
			minEmployee.EmployeEmail = $"changed_{anotherRandomNumber}@exsample.com";
			await dbContext.SaveChangesAsync();
			Log.Information("t_employee表更新成功, {minEmployee}", minEmployee);

			// 找到最大的并删除
			// 查询t_employee中的最新
			var maxEmployee = dbContext.Employees
				.OrderByDescending(l => l.EmployeeId)
				.First();
			Log.Information("t_employee表查询最大结果, {maxEmployee}", maxEmployee);
			dbContext.Remove(maxEmployee);
			await dbContext.SaveChangesAsync();
			Log.Information("t_employee表删除成功");

			// 最后只留下5条数据
			// 获取前5条数据
			var topFiveEntities = dbContext.Employees.OrderBy(l => l.EmployeeId).Take(5);
			// 获取除了前5条数据之外的所有数据
			var deleteEntities = dbContext.Employees.Except(topFiveEntities);
			// 执行删除操作
			dbContext.Employees.RemoveRange(deleteEntities);
			await dbContext.SaveChangesAsync();
			Log.Information("数据清理成功(只留下5条数据)");

			// 查询全部数据
			// 如果数据是只读的使用 .AsNoTracking 非跟踪查询 来提高性能
			// 更多: https://learn.microsoft.com/zh-cn/ef/core/querying/tracking
			// 使用投影以避免加载不必要的数据
			var allDatas = await dbContext.Employees
				// 非跟踪查询
				.AsNoTracking()
				// 投影，只保留employee_id字段
				.Select(c => new { EmployeeId = c.EmployeeId })
				.ToListAsync();
			// 分页示例
			// https://learn.microsoft.com/zh-cn/ef/core/querying/pagination
			Log.Information("t_employee表全部数据查询成功");
			Log.Information("{allDatas}", allDatas);

			// 自定义SQL查询
			// 使用原生SQL的方式查询
			// 更多:
			//  https://learn.microsoft.com/zh-cn/ef/core/querying/sql-queries?tabs=postgres
			string custCondi = "%@exsample.com";
			var custResult = await dbContext.Employees
				.FromSql($"SELECT * FROM t_employee WHERE employe_email LIKE {custCondi}")
				// 非跟踪查询
				.AsNoTracking()
				.ToListAsync();
			Log.Information("t_employee表自定义SQL查询成功");
			Log.Information("{custResult}", custResult);
		}
	}
}
