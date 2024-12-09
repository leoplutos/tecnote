using AspWebapi.Models;

namespace AspWebapi.Services;

//######################################
// Service层
//######################################
public interface IEmployeeService
{
	// 异步取得所有
	public Task<List<Employee>> GetAllAsync();
}
