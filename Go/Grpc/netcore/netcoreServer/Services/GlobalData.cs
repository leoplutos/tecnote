using System.Collections.Concurrent;
using GrpcDemo;

namespace netcoreServer.Services;

public static class GlobalData
{
	// 储存Product的全局词典
	// 使用ConcurrentDictionary以确保线程安全
	public static ConcurrentDictionary<string, Product> GlobalDictionary { get; } = new ConcurrentDictionary<string, Product>();

	// 静态构造函数（可选），用于初始化字典或其他全局资源
	static GlobalData()
	{
		// 可以在这里添加一些初始键值对到GlobalDictionary中
		//GlobalDictionary.TryAdd("Key1", 1);
		//GlobalDictionary.TryAdd("Key2", 2);
	}
}
