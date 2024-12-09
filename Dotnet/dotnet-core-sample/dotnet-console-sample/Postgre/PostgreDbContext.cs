using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace dotnet_console_sample.Postgre
{
	// 设定PostgreDb的ORM
	// 数据库访问上下文(使用Microsoft.EntityFrameworkCore)
	public class PostgreDbContext : DbContext
	{
		// 构造函数
		public PostgreDbContext(DbContextOptions<PostgreDbContext> options) : base(options)
		{
		}

		// // 构造函数
		// public PostgreDbContext(IConfiguration config)
		// {
		// 	_config = config;

		// 	string? host = _config["PostgreSettings:Host"];
		// 	string? port = _config["PostgreSettings:Port"];
		// 	string? database = _config["PostgreSettings:Database"];
		// 	string? username = _config["PostgreSettings:Username"];
		// 	string? password = _config["PostgreSettings:Password"];
		// 	ConnString = $"Host={host};Port={port};Username={username};Password={password};Database={database}";
		// }

		// appsettings.json 和 环境变量
		// private readonly IConfiguration _config;

		// t_employee表
		public DbSet<Employee> Employees { get; set; } = null!;

		// DB连接URL
		// public string ConnString { get; }

		// 将 EFCore 配置为 使用 Postgre
		// 使用 OnConfiguring() 来配置上下文是最简单的入门方法，但对于大多数 生产 应用程序来说，不建议这样做：
		// protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
		// 	=> optionsBuilder.UseNpgsql(ConnString);
	}

	// t_employee表的映射（Entities）
	[Table("t_employee")]
	//[Index(nameof(EmployeeId))]
	public class Employee
	{
		[Key]
		[Column("te_pk")]
		public Guid TePk { get; set; }

		[Column("employee_id")]
		public string? EmployeeId { get; set; }

		[Column("employe_name")]
		public string? EmployeName { get; set; }

		[Column("employe_email")]
		public string? EmployeEmail { get; set; }

		[Column("employe_status")]
		public int? EmployeStatus { get; set; }

		// 重写 ToString() 方法, 以方便日志输出
		public override string ToString()
		{
			return $"TePk: {TePk}, EmployeeId: {EmployeeId}, EmployeName: {EmployeName}, EmployeEmail: {EmployeEmail}, EmployeStatus: {EmployeStatus}";
		}
	}
}
