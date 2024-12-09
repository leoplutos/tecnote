package postgre

import (
	"container/list"
	"context"
	"fmt"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgxpool"
	"math/rand"
	"my.sample/GoSampleProject/src/config"
	"my.sample/GoSampleProject/src/log"
)

// Postgre的基础示例
func PostgreBase() {
	// 需要1:
	// go get github.com/jackc/pgx/v5  (单连接模式，不是并发安全)
	// go get github.com/jackc/pgx/v5/pgxpool  (连接池模式，并发安全)
	// 需要2: docker run -p 5432:5432 --name postgre -v $HOME/workspace/postgre_data/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
	// 需要3: 建表
	/*
		CREATE TABLE t_employee (
			te_pk UUID NOT NULL UNIQUE,
			employee_id TEXT NOT NULL,
			employe_name TEXT,
			employe_email TEXT,
			employe_status SMALLINT,
			PRIMARY KEY(te_pk)
		);
	*/
	// 更多看这里:
	// https://github.com/jackc/pgx
	// https://github.com/jackc/pgx/blob/master/examples/todo/main.go

	ctx := context.Background()

	// 从config.yaml文件读取数据库连接信息
	// dbUrl := os.Getenv("DATABASE_URL")
	dbUrl := config.Viper.GetString("datasource.url")
	log.Logger.Info().Msgf("Postgre连接URL: %v", dbUrl)
	// 创建数据库连接池
	dbpool, err := pgxpool.New(ctx, dbUrl)
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("Postgre连接失败: %v", err)
		panic(err)
		// os.Exit(1)
	}
	defer func() {
		dbpool.Close()
		log.Logger.Info().Msg("Postgre连接池已关闭")
	}()

	// 测试连接
	err = dbpool.Ping(ctx)
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("Postgre连接失败: %v", err)
		panic(err)
	} else {
		log.Logger.Info().Msg("Postgre连接成功")
	}

	// 插入3条t_employee数据
	for i := 0; i < 3; i++ {
		// 对数据库友好的 UUID v7
		uuidv7, _ := uuid.NewV7()
		tepk := uuidv7.String()
		// 生成1到99的随机数
		randomNumber := rand.Intn(99) + 1
		employee_id := fmt.Sprintf("%s%d", "golang_base_id_", randomNumber)
		employe_name := fmt.Sprintf("%s%d", "dotnet_张二_", randomNumber)
		employe_status := 3
		_, err = dbpool.Exec(ctx, "INSERT INTO t_employee (te_pk, employee_id, employe_name, employe_status) VALUES ($1, $2, $3, $4)", tepk, employee_id, employe_name, employe_status)
		if err != nil {
			log.Logger.Error().Stack().Err(err).Msgf("插入t_employee失败: %v", err)
			panic(err)
		}
		log.Logger.Info().Msgf("t_employee表插入成功, %v, %v, %v, %v", tepk, employee_id, employe_name, employe_status)
	}

	// 查询t_employee所有数据
	// 创建一个List，其中每个元素都是map<string, string>类型
	results := list.New()
	rows, err := dbpool.Query(ctx, "SELECT * FROM t_employee")
	for rows.Next() {
		var te_pk string
		var employee_id string
		var employe_name string
		var employe_email *string
		var employe_status int
		err := rows.Scan(&te_pk, &employee_id, &employe_name, &employe_email, &employe_status)
		if err != nil {
			log.Logger.Error().Stack().Err(err).Msgf("查询t_employee失败: %v", err)
			panic(err)
		}
		if employe_email == nil {
			temp := "N/A"
			employe_email = &temp
		}
		// 创建map并添加到List中
		record := make(map[string]string)
		record["te_pk"] = te_pk
		record["employee_id"] = employee_id
		record["employe_name"] = employe_name
		record["employe_email"] = *employe_email
		record["employe_status"] = fmt.Sprintf("%d", employe_status)
		results.PushBack(record)
	}
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("查询t_employee失败: %v", err)
		panic(err)
	}
	log.Logger.Info().Msgf("t_employee表查询成功")
	// 遍历list并打印其中的map元素
	for element := results.Front(); element != nil; element = element.Next() {
		record := element.Value.(map[string]string)
		log.Logger.Info().Msgf("%v", record)
	}
}
