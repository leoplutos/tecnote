using dw_core;
using Bogus;
using BenchmarkDotNet.Attributes;

namespace dw_app
{
	public class App
	{
		[Benchmark]
		// 定义一个异步的方法，虽然没有使用 async 关键字，但是返回的为Task
		public Task ShowAsync()
		{
			try
			{
				string appNm = "dw-app/Program.cs -> " + Guid.NewGuid().ToString();
				Console.WriteLine(appNm);
				Console.WriteLine($"MODULE_NAME = {Constant.MODULE_NAME}");
				Console.WriteLine($"MODULE_VERSION = {Constant.MODULE_VERSION}");
				Console.WriteLine($"PI = {Constant.PI}");

				// 使用Bogus创建虚假数据
				var userFaker = new Faker<User>()
					  .RuleFor(u => u.Name, f => f.Person.FullName)
					  .RuleFor(u => u.Age, f => f.Random.Number(18, 60));
				var user = userFaker.Generate();
				Console.WriteLine($"FakeName = {user.Name},  FakeAge = {user.Age}");

				return Task.CompletedTask;
			}
			catch (Exception ex)
			{
				return Task.FromException(ex);
			}
		}

		[Benchmark]
		// 此函数会抛出除零错误
		// 定义一个异步的方法，虽然没有使用 async 关键字，但是返回的为Task
		public Task<string> GetExceptionAsync()
		{
			try
			{
				string appNm = "dw-app/Program.cs -> " + Guid.NewGuid().ToString();
				int a = 1;
				int b = 0;
				int c = a / b;
				return Task.FromResult(appNm);
			}
			catch (Exception ex)
			{
				return Task.FromException<string>(ex);
			}
		}

		class User
		{
			public required string Name { get; set; }
			public int Age { get; set; }
		}
	}
}

