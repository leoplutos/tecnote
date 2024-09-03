using Newtonsoft.Json.Linq;
using AspWebapi.Common;
using AspWebapi.Models;
using AspWebapi.Services;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace AspWebapi.Controllers;

//######################################
// Controller层
//######################################
// 在父类做了标注
// [ApiController]
// [Route("[controller]")]
public class LoginController : ApiControllerBase
{
	// Service层，在[Program.cs]中注册
	private readonly ILoginService _service;
	private readonly JwtHelper _jwtHelper;

	// 依赖注入
	public LoginController(ILoginService service, JwtHelper jwtHelper)
	{
		_service = service;
		_jwtHelper = jwtHelper;
	}

	// 登录
	[HttpPost("/login")]
	// public async Result<List<TodoEntity>> Post()
	public async Task<Result<string>> Post([FromBody] JObject login)
	{
		Log.Information("Login开始");

		// 取得端口
		int port = this.HttpContext.Connection.LocalPort;
		Log.Information("当前监听端口为: {Port}", port);

		// 取得Post参数
		string userId = login["userId"]?.ToString() ?? "";
		string password = login["password"]?.ToString() ?? "";
		// 参数校验
		if (string.IsNullOrEmpty(userId))
		{
			Log.Information("Login结束");
			return FailResult<string>(401, "账号不能为空");
		}
		if (string.IsNullOrEmpty(password))
		{
			Log.Information("Login结束");
			return FailResult<string>(401, "密码不能为空");
		}
		// Log.Information("参数  UserId={UserId}  Password={Password}", userId, password);
		// 从内存数据库中验证用户信息
		LoginEntity userInfo = await _service.FindByUserIdAndPassword(userId, password);
		if (userInfo == null)
		{
			Log.Information("Login结束");
			return FailResult<string>(401, "用户名或密码错误!"); ;
		}
		else
		{
			// Log.Information("内存数据库查询结果  UserId={UserId}  Password={Password}", userInfo.UserId, userInfo.Password);
			// 登录成功，生成token
			string token = _jwtHelper.CreateToken();
			// Log.Information("token={token}", token);
			Log.Information("Login结束");
			return SuccessResult<string>(token);
		}
	}

}
