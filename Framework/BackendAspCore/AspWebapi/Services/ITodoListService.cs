using AspWebapi.Models;

namespace AspWebapi.Services;

//######################################
// Service层
//######################################
public interface ITodoListService
{
	// 异步取得所有TodoList
	public Task<List<TodoDTO>> GetAllAsync();
}
