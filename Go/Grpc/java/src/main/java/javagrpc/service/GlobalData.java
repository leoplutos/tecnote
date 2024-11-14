package javagrpc.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import javagrpc.grpc.stub.ProductInfoPb.Product;

// 全局数据存储类
public class GlobalData {

	// 全局Product的词典
	private static Map<String, Product> productMap = new ConcurrentHashMap<String, Product>();
	// 读写锁(适合读多写少)，确保线程安全
	private final static ReentrantReadWriteLock productLock = new ReentrantReadWriteLock();

	// 全局金额
	private static long amount = 10000L;
	// 读写锁(适合读多写少)，确保线程安全
	private final static ReentrantReadWriteLock amountLock = new ReentrantReadWriteLock();

	// 读取全局Product的词典
	public static Map<String, Product> readProductMap() {
		// 获取读锁
		productLock.readLock().lock();
		try {
			// 读取数据
			return productMap;
		} finally {
			// 确保释放读锁
			productLock.readLock().unlock();
		}
	}

	// 写入全局Product的词典
	public static void writeProductMap(String key, Product newProduct) {
		// 获取写锁
		productLock.writeLock().lock();
		try {
			// 写入数据
			productMap.put(key, newProduct);
		} finally {
			// 确保释放写锁
			productLock.writeLock().unlock();
		}
	}

	// 读取全局金额
	public static long readAmount() {
		// 获取读锁
		amountLock.readLock().lock();
		try {
			// 读取数据
			return amount;
		} finally {
			// 确保释放读锁
			amountLock.readLock().unlock();
		}
	}

	// 写入全局金额
	public static void writeAmountMinus(long minus) {
		// 获取写锁
		amountLock.writeLock().lock();
		try {
			// 模拟金额转出
			amount -= minus;
		} finally {
			// 确保释放写锁
			amountLock.writeLock().unlock();
		}
	}

	// 写入全局金额
	public static void writeAmountPlus(long plus) {
		// 获取写锁
		amountLock.writeLock().lock();
		try {
			// 模拟金额转入
			amount += plus;
		} finally {
			// 确保释放写锁
			amountLock.writeLock().unlock();
		}
	}
}
