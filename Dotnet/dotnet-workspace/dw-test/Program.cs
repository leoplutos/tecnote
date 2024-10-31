using dw_app;
using BenchmarkDotNet.Running;

// 使用BenchmarkDotNet进行基准测试
// 带有[Benchmark]标注的函数为测试对象
// https://github.com/dotnet/BenchmarkDotNet
// https://benchmarkdotnet.org/
// Run benchmarks:
// dotnet run -c Release
var summary = BenchmarkRunner.Run<App>();
