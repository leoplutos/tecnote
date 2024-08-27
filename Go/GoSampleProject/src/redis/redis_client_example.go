package redis

import (
	"context"
	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
	"my.sample/GoSampleProject/src/log"
	"time"
)

func RedisClient() {
	ctx := context.Background()

	// 建立连接
	var conn_timeout = 1
	rdb := redis.NewClient(&redis.Options{
		Addr:        "localhost:6379",
		Password:    "",                                        // no password set
		DB:          0,                                         // use default DB
		MaxRetries:  0,                                         //不retry
		DialTimeout: time.Duration(conn_timeout) * time.Second, //连接超时设定
	})
	err := rdb.Ping(ctx).Err()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msg("Redis连接失败")
		panic(err)
	}

	// 程序关闭前，释放连接
	defer func() {
		if rdb != nil {
			log.Logger.Info().Msg("关闭Redis连接")
			rdb.Close()
		}
	}()

	// 设定Key
	key := "GoKey"
	uuid := uuid.NewString()
	setValue := "使用Go客户端添加_" + uuid
	err = rdb.Set(ctx, key, setValue, 0).Err()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("添加Key[%s]失败", key)
		panic(err)
	}
	log.Logger.Info().Msgf("添加Key成功    key=%s    value=%s", key, setValue)

	// 取得Key
	getValue, err := rdb.Get(ctx, key).Result()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("取得Key[%s]失败", key)
		panic(err)
	}
	log.Logger.Info().Msgf("取得Key成功    key=%s    value=%s", key, getValue)

	// 判断Key是否存在
	isExists, err := rdb.Exists(ctx, key).Result()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("判断Key[%s]失败", key)
		panic(err)
	}
	log.Logger.Info().Msgf("Key[%s]是否存在    %d  ", key, isExists)
	notExistkey := "abcde"
	isExists, err = rdb.Exists(ctx, notExistkey).Result()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("判断Key[%s]失败", notExistkey)
		panic(err)
	}
	log.Logger.Info().Msgf("Key[%s]是否存在    %d  ", notExistkey, isExists)

	// 为Key设置过期时间(秒)
	expireSeconds := 10
	_, err = rdb.Expire(ctx, key, time.Duration(expireSeconds)*time.Second).Result()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("设置Key[%s]过期时间失败", key)
		panic(err)
	}
	log.Logger.Info().Msgf("设定Key[%s]的过期时间为：%d秒", key, expireSeconds)
}
