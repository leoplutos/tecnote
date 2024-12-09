package postgre

import (
	"fmt"
	"github.com/google/uuid"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"math/rand"
	"my.sample/GoSampleProject/src/config"
	"my.sample/GoSampleProject/src/log"
	"time"
)

func PostgreOrm() {
	// 需要1:
	// go get -u gorm.io/gorm
	// go get -u gorm.io/driver/postgres
	// 需要2: docker run -p 5432:5432 --nEame postgre -v $HOME/workspace/postgre_data/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=123456 -d postgres:17.1-alpine3.20
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
	// https://gorm.io/zh_CN/docs/index.html
	// https://github.com/go-gorm/gorm

	// 从config.yaml文件读取数据库连接信息
	// dbUrl := os.Getenv("DATABASE_URL")
	dbDsn := config.Viper.GetString("datasource.dsn")
	log.Logger.Info().Msgf("Postgre连接DSN: %v", dbDsn)
	// 连接数据库
	// 在Gorm中，连接池是自动管理
	// https://github.com/go-gorm/postgres
	db, err := gorm.Open(postgres.New(postgres.Config{
		DSN:                  dbDsn,
		PreferSimpleProtocol: true, // 禁用预编译语句缓存
	}), &gorm.Config{
		DisableForeignKeyConstraintWhenMigrating: true,
		Logger:                                   logger.Default.LogMode(logger.Info),
	})
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("Postgre连接失败: %v", err)
		panic(err)
		// os.Exit(1)
	}
	sqlDB, err := db.DB()
	if err != nil {
		log.Logger.Error().Stack().Err(err).Msgf("Postgre连接失败: %v", err)
		panic(err)
	}
	// 设置连接池中的最大空闲连接数为10
	sqlDB.SetMaxIdleConns(10)
	// // 设置数据库的最大连接数为100
	sqlDB.SetMaxOpenConns(100)
	//// 设置连接的最大生存时间为1个小时
	sqlDB.SetConnMaxLifetime(time.Hour)

	// 开启事务
	// tx := db.Begin()

	var searchId string
	var deleteId string
	// 插入3条t_employee数据
	for i := 0; i < 3; i++ {
		// 对数据库友好的 UUID v7
		uuidv7, _ := uuid.NewV7()
		tepk := uuidv7.String()
		// 生成1到99的随机数
		randomNumber := rand.Intn(99) + 1
		employee_id := fmt.Sprintf("%s%d", "golang_orm_id_", randomNumber)
		employe_name := fmt.Sprintf("%s%d", "dotnet_张二_", randomNumber)
		employe_status := 3
		newEmployee := TEmployee{TePk: tepk, EmployeeId: employee_id, EmployeName: &employe_name, EmployeStatus: &employe_status}
		result := db.Create(&newEmployee)
		if result.Error != nil {
			log.Logger.Error().Stack().Err(err).Msgf("插入t_employee失败: %v", result.Error)
			panic(result.Error)
		}
		log.Logger.Info().Msgf("t_employee表插入成功")
		switch i {
		case 0:
			searchId = employee_id
		case 1:
			deleteId = employee_id
		}
	}

	// 查询数据
	var searchEmployee TEmployee
	//获取第一条匹配的记录
	result := db.Where("employee_id = ?", searchId).First(&searchEmployee)
	if result.Error != nil {
		log.Logger.Error().Stack().Err(err).Msgf("查询t_employee失败: %v", result.Error)
		panic(result.Error)
	} else {
		log.Logger.Info().Msgf("使用 employeeId 查询成功, %v", searchEmployee)
	}

	// 更新数据
	// 生成1到99的随机数
	randomNumber := rand.Intn(99) + 1
	employe_email := fmt.Sprintf("changed_%d@exsample.com", randomNumber)
	// 根据条件和 model 的值进行更新
	result = db.Model(&searchEmployee).Where("employee_id = ?", searchId).Update("employe_email", employe_email)
	if result.Error != nil {
		log.Logger.Error().Stack().Err(err).Msgf("更新t_employee失败: %v", result.Error)
		panic(result.Error)
	} else {
		log.Logger.Info().Msgf("使用 employeeId 更新成功, searchId:%v", searchId)
	}

	// 删除数据
	// 根据条件删除
	result = db.Where("employee_id = ?", deleteId).Delete(&TEmployee{})
	if result.Error != nil {
		log.Logger.Error().Stack().Err(err).Msgf("删除t_employee失败: %v", result.Error)
		panic(result.Error)
	} else {
		log.Logger.Info().Msgf("使用 employeeId 删除成功, deleteId:%v", deleteId)
	}

	// 查询全部数据
	var allEmployee []TEmployee
	result = db.Find(&allEmployee)
	if result.Error != nil {
		log.Logger.Error().Stack().Err(err).Msgf("查询t_employee失败: %v", result.Error)
		panic(result.Error)
	} else {
		log.Logger.Info().Msg("查询全部数据成功")
		for _, employee := range allEmployee {
			// 使用指针解引用来获取实际值
			name := ""
			if employee.EmployeName != nil {
				name = *employee.EmployeName
			}
			email := ""
			if employee.EmployeEmail != nil {
				email = *employee.EmployeEmail
			}
			status := "N/A"
			if employee.EmployeStatus != nil {
				status = fmt.Sprintf("%d", *employee.EmployeStatus)
			}
			log.Logger.Info().Msgf("%s, %s, %s, %s, %s", employee.TePk, employee.EmployeeId, name, email, status)
		}
	}

	// 自定义SQL查询
	// 使用原生SQL的方式查询
	// 更多:
	//  https://gorm.io/zh_CN/docs/sql_builder.html
	var custResult []TEmployee
	custCondi := `%@exsample.com`
	db.Raw("SELECT * FROM t_employee WHERE employe_email LIKE ?", custCondi).Scan(&custResult)
	for _, employee := range custResult {
		// 使用指针解引用来获取实际值
		name := ""
		if employee.EmployeName != nil {
			name = *employee.EmployeName
		}
		email := ""
		if employee.EmployeEmail != nil {
			email = *employee.EmployeEmail
		}
		status := "N/A"
		if employee.EmployeStatus != nil {
			status = fmt.Sprintf("%d", *employee.EmployeStatus)
		}
		log.Logger.Info().Msgf("%s, %s, %s, %s, %s", employee.TePk, employee.EmployeeId, name, email, status)
	}
}

// ORM的对象映射
// 指向 *string 类型的指针表示可空字段
type TEmployee struct {
	TePk          string  `gorm:"column:te_pk;primaryKey"`
	EmployeeId    string  `gorm:"column:employee_id"`
	EmployeName   *string `gorm:"column:employe_name"`
	EmployeEmail  *string `gorm:"column:employe_email"`
	EmployeStatus *int    `gorm:"column:employe_status"`
}

// 指定表名
func (m *TEmployee) TableName() string {
	return "t_employee"
}
