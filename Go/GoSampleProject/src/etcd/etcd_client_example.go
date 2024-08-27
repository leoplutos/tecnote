package etcd

import (
	"context"
	"github.com/google/uuid"
	clientv3 "go.etcd.io/etcd/client/v3"
	"my.sample/GoSampleProject/src/log"
	"time"
)

var PREFIX = "/GoKey"

func EtcdClient() {
	ctx := context.Background()

	// 建立连接
	endpoint := "http://localhost:2379"
	var conn_timeout = 1
	etcd, err := clientv3.New(clientv3.Config{
		//Endpoints:   []string{"localhost:2379", "localhost:22379", "localhost:32379"},
		Endpoints:   []string{endpoint},
		DialTimeout: time.Duration(conn_timeout) * time.Second,
	})
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msg("Etcd连接失败")
		panic(err)
	}
	// 创建一个具有指定超时时间的 context
	timoutCtx, cancel := context.WithTimeout(context.Background(), time.Duration(conn_timeout)*time.Second)
	_, err = etcd.Status(timoutCtx, endpoint)
	cancel()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msg("Etcd连接失败")
		panic(err)
	}

	log.Logger.Info().Msg("Etcd连接成功")

	// 程序关闭前，释放连接
	defer func() {
		if etcd != nil {
			log.Logger.Info().Msg("关闭Etcd连接")
			etcd.Close()
		}
	}()

	// 设定Key
	key1 := PREFIX + "/Key1"
	key2 := PREFIX + "/Key2"
	setValue1 := "使用Go客户端添加_" + uuid.NewString()
	setValue2 := "使用Go客户端添加_" + uuid.NewString()
	_, err = etcd.Put(ctx, key1, setValue1)
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("添加Key[%s]失败", key1)
		panic(err)
	}
	log.Logger.Info().Msgf("添加Key成功    key=%s    value=%s", key1, setValue1)
	_, err = etcd.Put(ctx, key2, setValue2)
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("添加Key[%s]失败", key2)
		panic(err)
	}
	log.Logger.Info().Msgf("添加Key成功    key=%s    value=%s", key2, setValue2)

	// 取得Key
	resp, err := etcd.Get(ctx, key1)
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("取得Key[%s]失败", key1)
		panic(err)
	}
	for _, ev := range resp.Kvs {
		log.Logger.Info().Msgf("取得Key成功    key=%s    value=%s", ev.Key, ev.Value)
	}

	// 取得Key（前缀机制）
	// 前缀查询
	resp, err = etcd.Get(ctx, PREFIX, clientv3.WithPrefix())
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("取得前缀Key[%s]失败", key1)
		panic(err)
	}
	log.Logger.Info().Msgf("取得前缀成功    prefix=%s", PREFIX)
	for _, ev := range resp.Kvs {
		log.Logger.Info().Msgf("key=%s    value=%s", ev.Key, ev.Value)
	}

	// 分布式锁
	// 官方还没有给Lock的接口，所以需要自己实现

	// 调用租约函数
	leaseRegister(ctx, etcd)

	// 调用监听函数
	watchService(ctx, etcd)

	// 在此堵塞线程
	time.Sleep(5000 * time.Second)
}

// 租约函数
func leaseRegister(ctx context.Context, etcd *clientv3.Client) {
	// 创建租约
	leaseKey := PREFIX + "/LsKey1"
	leaseValue := "此Key会自动被删除"
	var ttl int64 = 5
	resp, err := etcd.Grant(ctx, ttl)
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("创建租约(Lease)失败")
		panic(err)
	}
	log.Logger.Info().Msgf("创建租约(Lease)成功    leaseId=%d", resp.ID)
	_, err = etcd.Put(ctx, leaseKey, leaseValue, clientv3.WithLease(resp.ID))
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("添加租约Key成功    key=%s    value=%s    leaseId=%d", leaseKey, leaseValue, resp.ID)
		panic(err)
	}
	log.Logger.Info().Msgf("添加租约Key成功    key=%s    value=%s    leaseId=%d", leaseKey, leaseValue, resp.ID)

	//续租，在租约过期之前续租
	// ch, kaerr := etcd.KeepAlive(ctx, resp.ID)
	// if kaerr != nil {
	// 	log.Logger.Error().Stack().Err(err).Msgf("续租失败")
	// 	panic(kaerr)
	// }
	// ka := <-ch
	// if ka != nil {
	// 	log.Logger.Info().Msgf("ttl:%d", ka.TTL)
	// } else {
	// 	log.Logger.Info().Msgf("Unexpected NULL")
	// }
}

// 监听函数
func watchService(ctx context.Context, etcd *clientv3.Client) {
	watchKey := PREFIX + "/LsKey1"
	rch := etcd.Watch(ctx, watchKey)
	for wresp := range rch {
		for _, ev := range wresp.Events {
			if ev.Type == clientv3.EventTypeDelete {
				log.Logger.Info().Msgf("租约  key=%q 到期，续租", ev.Kv.Key)
				leaseRegister(ctx, etcd)
			}
		}
	}
}
