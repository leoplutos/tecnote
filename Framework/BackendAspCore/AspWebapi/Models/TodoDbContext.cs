using Microsoft.EntityFrameworkCore;

namespace AspWebapi.Models;

// 数据库访问上下文(使用Microsoft.EntityFrameworkCore)
public class TodoDbContext : DbContext
{
	public TodoDbContext(DbContextOptions<TodoDbContext> options)
		: base(options)
	{
	}

	// todo表
	public DbSet<TodoEntity> TodoEntity { get; set; } = null!;

	// login表
	public DbSet<LoginEntity> LoginEntity { get; set; } = null!;
}
