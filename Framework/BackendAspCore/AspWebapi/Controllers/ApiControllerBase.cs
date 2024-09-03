using AspWebapi.Common;
using Microsoft.AspNetCore.Mvc;

namespace AspWebapi.Controllers;

//######################################
// Controller层
//######################################
// 基类
[ApiController]
[Route("[controller]")]
public class ApiControllerBase : ControllerBase
{
	protected Result<T> SuccessResult<T>(T data)
	{
		return Result<T>.Success("success", data);
	}

	protected Result<T> SuccessResult<T>(string? message, T data)
	{
		return Result<T>.Success(message, data);
	}

	protected Result<T> FailResult<T>(string? message = null)
	{
		return Result<T>.Fail(message);
	}

	protected Result<T> FailResult<T>(int code, string? message = null)
	{
		return Result<T>.Fail(code, message);
	}
}
