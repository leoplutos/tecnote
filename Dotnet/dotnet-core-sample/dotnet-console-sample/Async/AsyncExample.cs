using Serilog;

namespace dotnet_console_sample.Async
{
	class AsyncExample
	{
		// 异步函数
		async Task<string> DoSomethingAsync(int value)
		{
			// 模拟长时间运行的任务，例如网络请求或数据库查询
			await Task.Delay(2000); // 延迟2秒（2000毫秒）
			return "result" + value.ToString();
		}

		// 异步操作完成时调用的回调方法
		async void CompletionCallback(Task<string> task)
		{
			// 等待异步操作完成
			string result = await task;
			// 处理结果
			Console.WriteLine("callback: {0}", result);
		}

		// 程序入口
		public async Task AsyncExampleStart()
		{
			Log.Information("AsyncExampleStart开始!!!");
			// 堵塞，等待调用结果
			//string result = await DoSomethingAsync(1);
			// 不堵塞，不等待结果直接继续运行
			//Task<string> result = DoSomethingAsync(1);
			// 不堵塞，不等待结果直接继续运行（多次循环调用）
			var taskList = new List<Task>();
			for (int i = 1; i <= 5; i++)
			{
				var task = DoSomethingAsync(i);
				// 设定回调方法（方式1），因为是不堵塞调用所以会发生CS4014警告，使用丢弃变量可以屏蔽警告
				//_ = task.ContinueWith(CompletionCallback);
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
