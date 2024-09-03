namespace AspWebapi.Common;

// 返回结果统一包装类
// https://www.cnblogs.com/wucy/p/16124449.html
public class Result<T>
{
	// 错误码
	public int Code { get; set; }

	// 错误信息
	private string? _msg;
	public string? Message
	{
		get
		{
			return !string.IsNullOrEmpty(_msg) ? _msg : "";
		}
		set
		{
			_msg = value;
		}
	}

	// Api返回内容
	public T? Data { get; set; }
	public static Result<T> Success(T data)
	{
		return new Result<T> { Code = 200, Message = "", Data = data };
	}

	public static Result<T> Success(string? message, T data)
	{
		return new Result<T> { Code = 200, Message = message, Data = data };
	}

	public static Result<T> Fail(string? message = null)
	{
		return new Result<T> { Code = 500, Message = message };
	}

	public static Result<T> Fail(int code, string? message = null)
	{
		return new Result<T> { Code = code, Message = message };
	}
}
