using AspWebapi.Models;
using Microsoft.EntityFrameworkCore;

namespace AspWebapi.Services;

//######################################
// Service层
//######################################
public class EmployeeService : IEmployeeService
{
	// Postgre数据库访问对象
	private readonly PostgreDbContext _dbContext;

	public EmployeeService(PostgreDbContext dbContext)
	{
		_dbContext = dbContext;
	}

	// 异步取得所有TodoList
	public async Task<List<Employee>> GetAllAsync()
	{
		List<Employee> result = await _dbContext.Employees
								// 非跟踪查询
								.AsNoTracking()
								// 异步取得列表
								.ToListAsync();
		return result;
	}
}
