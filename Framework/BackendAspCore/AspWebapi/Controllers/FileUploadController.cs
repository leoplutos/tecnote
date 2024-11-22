using Microsoft.AspNetCore.Mvc;
using AspWebapi.Common;
using Serilog;

namespace AspWebapi.Controllers;

//######################################
// Controller层
//######################################
// 在父类做了标注
// [ApiController]
// [Route("[controller]")]
public class FileUploadController : ApiControllerBase
{

	private readonly IWebHostEnvironment _hostingEnvironment;

	// 依赖注入
	public FileUploadController(IWebHostEnvironment hostingEnvironment)
	{
		_hostingEnvironment = hostingEnvironment;
	}
	// 添加OPTIONS用来启用跨域支持
	[HttpOptions("/upload")]
	public async Task<Result<string>> Option()
	{
		await Task.Delay(0);
		Log.Information("跨域验证OK");
		// 允许跨域
		HttpContext.Response.Headers.Append("Access-Control-Allow-Origin", "*");
		return SuccessResult<string>("");
	}

	// upload: 文件上传
	// [Authorize] 标注为需要JWT认证，这里设置不需要
	// [Authorize]
	[HttpPost("/upload")]
	// 这里的uploadFiles名字，必须与前端的name匹配
	public async Task<Result<string>> Post(List<IFormFile> uploadFiles)
	{
		Log.Information("文件上传upload开始");
		// 允许跨域
		HttpContext.Response.Headers.Append("Access-Control-Allow-Origin", "*");
		// 总文件大小
		long size = uploadFiles.Sum(file => file.Length);
		Log.Information("上传文件总大小: {size} 字节", size);
		if (size == 0)
		{
			Log.Information("文件上传upload结束");
			return FailResult<string>(700, "上传文件大小为 0 字节");
		}
		else
		{
			// 创建临时上传目录
			// 当前工程根目录
			string contentRootPath = _hostingEnvironment.ContentRootPath;
			Log.Information("contentRootPath: {contentRootPath}", contentRootPath);
			string uuid = Guid.NewGuid().ToString();
			string tmpFolderPath = Path.Combine(contentRootPath, "tmp", uuid);
			Log.Information("上传目录: {tmpFolderPath}", tmpFolderPath);
			try
			{
				Directory.CreateDirectory(tmpFolderPath);
			}
			catch (Exception)
			{
			}
			foreach (var element in uploadFiles)
			{
				if (element.Length > 0)
				{
					string fileName = element.FileName;
					Log.Information("上传文件: {fileName}", fileName);
					//string filePath = Path.GetTempFileName();
					string filePath = Path.Combine(tmpFolderPath, fileName);
					using (var stream = System.IO.File.Create(filePath))
					{
						await element.CopyToAsync(stream);
					}
				}
			}
			Log.Information("文件上传upload结束");
			return SuccessResult<string>("");
		}
	}
}
