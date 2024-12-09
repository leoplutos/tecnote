using AspWebapi.Common;
using AspWebapi.Models;
using AspWebapi.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace AspWebapi.Controllers;

//######################################
// Controller层
//######################################
// 在父类做了标注
// [ApiController]
// [Route("[controller]")]
public class EmployeeController : ApiControllerBase
{
	// Service层，在[Program.cs]中注册
	private readonly IEmployeeService _service;

	// 依赖注入
	public EmployeeController(IEmployeeService service)
	{
		_service = service;
	}

	// 从Postgre中取得Employee
	// [Authorize] 标注为需要JWT认证
	[Authorize]
	[HttpPost("/employee")]
	public async Task<Result<List<Employee>>> Post()
	{
		Log.Information("取得Employee开始");
		// 从Postgre数据库中取得
		List<Employee> list = await _service.GetAllAsync();
		Log.Information("取得Employee结束");
		return SuccessResult(list);
	}
}
