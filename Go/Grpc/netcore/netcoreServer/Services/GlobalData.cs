using System.Collections.Concurrent;
using GrpcDemo;
using System.Diagnostics;
using System.Diagnostics.Metrics;

namespace netcoreServer.Services;

public static class GlobalData
{
	// ActivitySource(Tracer追踪)，参数为otel.scope.name
	public static readonly ActivitySource ProductServiceActivitySource = new("ProductService");
	// Metrics（指标/度量）
	public static readonly Meter ProductServiceMeter = new("ProductService.Meter");

	// 储存Product的全局词典
	// 使用ConcurrentDictionary以确保线程安全
	private static ConcurrentDictionary<string, Product> productMap = new ConcurrentDictionary<string, Product>();
	// 读写锁(适合读多写少)，确保线程安全
	private static readonly ReaderWriterLockSlim productLock = new ReaderWriterLockSlim();

	// 全局金额
	private static long amount = 10000L;
	// 读写锁(适合读多写少)，确保线程安全
	private static readonly ReaderWriterLockSlim amountLock = new ReaderWriterLockSlim();

	// 静态构造函数（可选），用于初始化字典或其他全局资源
	static GlobalData()
	{
		// 可以在这里添加一些初始键值对到GlobalDictionary中
		//GlobalDictionary.TryAdd("Key1", 1);
		//GlobalDictionary.TryAdd("Key2", 2);
	}

	// 读取全局Product的词典
	public static ConcurrentDictionary<string, Product> ReadProductMap()
	{
		// 获取读锁
		productLock.EnterReadLock();
		try
		{
			// 读取数据
			return productMap;
		}
		finally
		{
			// 确保释放读锁
			productLock.ExitReadLock();
		}
	}

	// 写入全局Product的词典
	public static void WriteProductMap(string key, Product newProduct)
	{
		// 获取写锁
		productLock.EnterWriteLock();
		try
		{
			// 写入数据
			productMap.TryAdd(key, newProduct);
		}
		finally
		{
			// 确保释放写锁
			productLock.ExitWriteLock();
		}
	}

	// 读取全局金额
	public static long ReadAmount()
	{
		// 获取读锁
		amountLock.EnterReadLock();
		try
		{
			// 读取数据
			return amount;
		}
		finally
		{
			// 确保释放读锁
			amountLock.ExitReadLock();
		}
	}

	// 写入全局金额
	public static void WriteAmountMinus(long minus)
	{
		// 获取写锁
		amountLock.EnterWriteLock();
		try
		{
			// 模拟金额转出
			amount -= minus;
		}
		finally
		{
			// 确保释放写锁
			amountLock.ExitWriteLock();
		}
	}

	// 写入全局金额
	public static void WriteAmountPlus(long plus)
	{
		// 获取写锁
		amountLock.EnterWriteLock();
		try
		{
			// 模拟金额转入
			amount += plus;
		}
		finally
		{
			// 确保释放写锁
			amountLock.ExitWriteLock();
		}
	}
}
