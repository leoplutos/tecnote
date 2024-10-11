using dw_core;

string appNm = "dw-redis/Program.cs -> " + Guid.NewGuid().ToString();
Console.WriteLine(appNm);
Console.WriteLine($"MODULE_NAME = {Constant.MODULE_NAME}");
Console.WriteLine($"MODULE_VERSION = {Constant.MODULE_VERSION}");
Console.WriteLine($"PI = {Constant.PI}");
