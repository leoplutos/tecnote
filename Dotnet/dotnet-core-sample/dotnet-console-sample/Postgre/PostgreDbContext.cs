using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace dotnet_console_sample.Postgre
{
	// 设定PostgreDb的ORM
	public class PostgreDbContext : DbContext
	{
		// appsettings.json 和 环境变量
		private readonly IConfiguration _config;

		// t_login表
		public DbSet<Login> Logins { get; set; }

		// DB连接URL
		public string ConnString { get; }

		// 构造函数
		public PostgreDbContext(IConfiguration config)
		{
			_config = config;

			string? host = _config["PostgreSettings:Host"];
			string? port = _config["PostgreSettings:Port"];
			string? database = _config["PostgreSettings:Database"];
			string? username = _config["PostgreSettings:Username"];
			string? password = _config["PostgreSettings:Password"];
			ConnString = $"Host={host};Port={port};Username={username};Password={password};Database={database}";
		}

		// 将 EFCore 配置为 使用 Postgre
		protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
			=> optionsBuilder.UseNpgsql(ConnString);
	}

	// t_login表的映射（Entities）
	[Table("t_login")]
	[Index(nameof(LoginId))]
	public class Login
	{
		[Key]
		[Column("tl_pk")]
		public Guid TlPk { get; set; }

		[Column("login_id")]
		public string? LoginId { get; set; }

		[Column("login_pwd")]
		public string? LoginPwd { get; set; }
	}
}
