using AspWebapi.Models;
using Microsoft.EntityFrameworkCore;
using Serilog;

namespace AspWebapi.Common;

// 内存数据库初始化数据
public class DBDataGenerator
{
	// 在 [Program.cs] 调用
	public static void Initialize(IServiceProvider serviceProvider)
	{
		Log.Information("内存数据库初始化开始");
		using var dbContext = new TodoDbContext(serviceProvider.GetRequiredService<DbContextOptions<TodoDbContext>>());

		// if (dbContext.TodoEntity.Any())
		// {
		// 	return;
		// }
		// 如果内存数据库存在，则删除数据库
		dbContext.Database.EnsureDeleted();
		// 创建内存数据库
		dbContext.Database.EnsureCreated();

		dbContext.TodoEntity.AddRange(
			new TodoEntity { TodoId = 1, TodoName = "Vue", Image = "./img/vue.png", Studied = false, SecretKey = "abc" },
			new TodoEntity { TodoId = 2, TodoName = "数据库", Image = "./img/database.png", Studied = false, SecretKey = "123" },
			new TodoEntity { TodoId = 3, TodoName = "Python", Image = "./img/python.png", Studied = false, SecretKey = "def" },
			new TodoEntity { TodoId = 4, TodoName = "Golang", Image = "./img/go.png", Studied = false, SecretKey = "456" }
		);

		dbContext.LoginEntity.AddRange(
			new LoginEntity { UserId = "admin", Password = "123" }
		);

		dbContext.SaveChanges();
		Log.Information("内存数据库初始化结束");
	}
}
