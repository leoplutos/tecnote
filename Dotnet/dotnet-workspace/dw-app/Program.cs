using dw_core;
using Bogus;

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

class User
{
	public required string Name { get; set; }
	public int Age { get; set; }
}
