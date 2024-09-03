using AspWebapi.Models;
using Microsoft.EntityFrameworkCore;

namespace AspWebapi.Services;

//######################################
// Service层
//######################################
public class TodoListService : ITodoListService
{
	// 数据库访问对象
	private readonly TodoDbContext _dbContext;

	public TodoListService(TodoDbContext dbContext)
	{
		_dbContext = dbContext;
	}

	// 异步取得所有TodoList
	public async Task<List<TodoDTO>> GetAllAsync()
	{
		List<TodoDTO> result = await _dbContext.TodoEntity
									.Select(x => EntityToDTO(x))
									.ToListAsync();
		return result;
	}

	// 防止过度发布，将Entiy转换成DTO
	private static TodoDTO EntityToDTO(TodoEntity entity) =>
		new TodoDTO
		{
			TodoId = entity.TodoId,
			TodoName = entity.TodoName,
			Image = entity.Image,
			Studied = entity.Studied
		};
}
