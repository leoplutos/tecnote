using AspWebapi.Models;
using Microsoft.EntityFrameworkCore;

namespace AspWebapi.Services;

//######################################
// Service层
//######################################
public class LoginService : ILoginService
{
	// 数据库访问对象
	private readonly TodoDbContext _dbContext;

	public LoginService(TodoDbContext dbContext)
	{
		_dbContext = dbContext;
	}

	// 异步校验用户信息
	public async Task<LoginEntity> FindByUserIdAndPassword(string userId, string password)
	{
		LoginEntity? result = await _dbContext.LoginEntity
							.Where(b => b.UserId.Equals(userId) && b.Password.Equals(password))
							// 返回第一条数据 它可以有返回结果，也可以没有
							.FirstOrDefaultAsync<LoginEntity>();
		// 使用!操作符告诉编译器“我知道这里不会是 null，所以请停止警告我”
		return result!;
	}
}
