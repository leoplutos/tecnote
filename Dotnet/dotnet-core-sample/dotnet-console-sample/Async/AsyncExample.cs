using Serilog;
using Microsoft.Extensions.Configuration;

namespace dotnet_console_sample.Async
{
	// https://learn.microsoft.com/zh-cn/dotnet/csharp/asynchronous-programming/task-asynchronous-programming-model
	class AsyncExample
	{
		// appsettings.json 和 环境变量
		private readonly IConfiguration _config;

		public AsyncExample(IConfiguration config)
		{
			_config = config;
		}

		// 异步函数-无返回值
		public async Task ShowVoidAsync(int value)
		{
			await Task.Delay(0);
			Log.Debug("ShowVoidAsync -> {value}", value);
		}

		// 异步函数-有返回值
		public async Task<string> ShowStringAsync(int value)
		{
			await Task.Delay(0);
			string result = value.ToString();
			Log.Debug("ShowStringAsync -> {result}", result);
			return result;
		}

		// 异步函数-发生异常
		public async Task<int> ShowExceptionAsync(int value)
		{
			await Task.Delay(0);
			int zero = 0;
			int result = value / zero;
			Log.Debug("ShowExceptionAsync -> {result}", result);
			return result;
		}

		// 异步函数-测试用
		public async Task<string> DoSomethingAsync(int value)
		{
			// 模拟长时间运行的任务，例如网络请求或数据库查询
			await Task.Delay(2000); // 延迟2秒（2000毫秒）
			return "result" + value.ToString();
		}

		// 异步操作完成时调用的回调方法
		public async void CompletionCallbackAsync(Task<string> task)
		{
			// 等待异步操作完成
			string result = await task;
			// 处理结果
			Console.WriteLine("callback: {0}", result);
		}

		// 程序入口
		public async Task AsyncExampleStart()
		{
			// 堵塞调用异步函数
			await ShowVoidAsync(10);
			Log.Information("调用ShowVoidAsync完成");
			string resultStr = await ShowStringAsync(10);
			Log.Information("调用ShowStringAsync完成, 返回值:{resultStr}", resultStr);
			try
			{
				int resultInt = await ShowExceptionAsync(10);
				Log.Information("调用ShowExceptionAsync完成, 返回值:{resultInt}", resultInt);
			}
			catch (Exception ex)
			{
				Log.Error("捕获到异常: {ex}", ex);
			}


			Log.Information("AsyncExampleStart开始!!!");
			// 从 appsettings.json 中读取内容
			int threadCount = 5;
			string? threadCountStr = _config["AsyncSettings:Thread.Count"];
			try
			{
				threadCount = int.Parse(threadCountStr!);
			}
			catch (Exception)
			{
				threadCount = 5;
			}
			Log.Information("线程数量为: {ThreadCount}", threadCount);

			// 堵塞，等待调用结果
			//string result = await DoSomethingAsync(1);
			// 不堵塞，不等待结果直接继续运行
			//Task<string> result = DoSomethingAsync(1);
			// 不堵塞，不等待结果直接继续运行（多次循环调用）
			var taskList = new List<Task>();
			for (int i = 1; i <= threadCount; i++)
			{
				var task = DoSomethingAsync(i);
				// 设定回调方法（方式1），因为是不堵塞调用所以会发生CS4014警告，使用丢弃变量可以屏蔽警告
				//_ = task.ContinueWith(CompletionCallbackAsync);
				// 设定回调方法（方式2），因为是不堵塞调用所以会发生CS4014警告，使用丢弃变量可以屏蔽警告
				_ = task.ContinueWith(async (t) =>
				{
					// 等待异步操作完成
					string result = await t;
					// 处理结果
					Log.Information("callback: {result}", result);
				});
				taskList.Add(task);
			}
			// Console.WriteLine(result);
			Log.Information("AsyncExampleStart结束!!!");
			// 只有一个task时使用GetAwaiter来等待子线程结束
			//task.GetAwaiter().GetResult();
			// 有多个task时使用WhenAll来等待所有子线程结束
			await Task.WhenAll(taskList.ToArray());
			foreach (var task in taskList)
			{
				Log.Information("task.Id={Id}    task.Status={Status}", task.Id, task.Status);
			}
			//Console.WriteLine($"All Done! Status={operationTask.Status}, Thread ID is " + Thread.CurrentThread.ManagedThreadId);
		}
	}
}
