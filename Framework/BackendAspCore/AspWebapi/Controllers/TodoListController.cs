using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using AspWebapi.Common;
using AspWebapi.Models;
using AspWebapi.Services;
using Serilog;

namespace AspWebapi.Controllers;

//######################################
// Controller层
//######################################
// 在父类做了标注
// [ApiController]
// [Route("[controller]")]
public class TodoListController : ApiControllerBase
{
	// Service层，在[Program.cs]中注册
	private readonly ITodoListService _service;

	// 依赖注入
	public TodoListController(ITodoListService service)
	{
		_service = service;
	}

	// 取得TodoList
	// [Authorize] 标注为需要JWT认证
	[Authorize]
	[HttpPost("/todo/getAll")]
	// public async Result<List<TodoEntity>> Post()
	public async Task<Result<List<TodoDTO>>> Post()
	{
		Log.Information("取得TodoList开始");
		// 从内存数据库中取得列表
		List<TodoDTO> list = await _service.GetAllAsync();
		// 防止过度发布，将Entiy转换成DTO

		Log.Information("取得TodoList结束");
		return SuccessResult(list);
	}

}
