using dw_app;

App app = new();
await app.ShowAsync();
string? result = null;
try
{
	result = await app.GetExceptionAsync();
}
catch (Exception ex)
{
	Console.WriteLine($"捕获到异常: {ex}");
}
Console.WriteLine($"result = {result}");

