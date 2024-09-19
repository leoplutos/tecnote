package bootstrap

import (
	"BackendGin/src/entity"
	"BackendGin/src/global"
	"BackendGin/src/log"
	"github.com/hashicorp/go-memdb"
)

func InitializeDB() *memdb.MemDB {
	log.Logger.Info().Msg("内存数据库初始化开始")
	// 创建内存数据库 - 实例化 db scheme 对象
	schema := &memdb.DBSchema{
		Tables: map[string]*memdb.TableSchema{
			"login": &memdb.TableSchema{ // login表
				Name: "login",
				Indexes: map[string]*memdb.IndexSchema{
					"id": &memdb.IndexSchema{
						Name:    "id",
						Unique:  true,                                     // 主键的值必须唯一
						Indexer: &memdb.StringFieldIndex{Field: "Userid"}, // Userid 作为 id 主键，id 字段不能为联合索引字段.
					},
					"password": &memdb.IndexSchema{
						Name:    "password",
						Unique:  false,                                      // 不需要唯一
						Indexer: &memdb.StringFieldIndex{Field: "Password"}, // Password 作为索引值.
					},
				},
			},
			"todo": &memdb.TableSchema{ // todo表
				Name: "todo",
				Indexes: map[string]*memdb.IndexSchema{
					"id": &memdb.IndexSchema{
						Name:    "id",
						Unique:  true,                                  // 主键的值必须唯一
						Indexer: &memdb.IntFieldIndex{Field: "Todoid"}, // Todoid 作为 id 主键，id 字段不能为联合索引字段.
					},
					"todoname": &memdb.IndexSchema{
						Name:    "todoname",
						Unique:  false,                                      // 不需要唯一
						Indexer: &memdb.StringFieldIndex{Field: "Todoname"}, // Todoname 作为索引值.
					},
					"image": &memdb.IndexSchema{
						Name:    "image",
						Unique:  false,                                   // 不需要唯一
						Indexer: &memdb.StringFieldIndex{Field: "Image"}, // Image 作为索引值.
					},
					"studied": &memdb.IndexSchema{
						Name:    "studied",
						Unique:  false,                                   // 不需要唯一
						Indexer: &memdb.BoolFieldIndex{Field: "Studied"}, // Password 作为索引值.
					},
				},
			},
		},
	}
	// 根据 dbschema 配置来创建 memdb 数据库对象
	db, err := memdb.NewMemDB(schema)
	if err != nil {
		panic(err)
	}
	return db
}

func InitializeDBDate() {
	//从全局变量中取得数据连接
	db := global.App.DB

	// 创建可读可写的事务
	txn := db.Txn(true)

	// login表初期数据插入
	login := []*entity.Login{
		&entity.Login{"admin", "123"},
	}
	for _, p := range login {
		if err := txn.Insert("login", p); err != nil {
			panic(err)
		}
	}

	// todo表初期数据插入
	todo := []*entity.Todo{
		&entity.Todo{1, "Vue", "./img/vue.png", false},
		&entity.Todo{2, "数据库", "./img/database.png", false},
		&entity.Todo{3, "Python", "./img/python.png", false},
		&entity.Todo{4, "Golang", "./img/go.png", false},
	}
	for _, p := range todo {
		if err := txn.Insert("todo", p); err != nil {
			panic(err)
		}
	}

	// 事务提交，完成写操作.
	txn.Commit()

	log.Logger.Info().Msg("内存数据库初始化结束")

	// 数据确认用
	/*
		// 创建只读事务.
		txn = db.Txn(false)
		defer txn.Abort()

		// 返回可以遍历数据的迭代器.
		it, err := txn.Get("login", "id")
		if err != nil {
			panic(err)
		}

		log.Logger.Info().Msg("All the login:")
		for obj := it.Next(); obj != nil; obj = it.Next() {
			p := obj.(*entity.Login)
			log.Logger.Info().Msgf("  %s  %s  \n", p.Userid, p.Password)
		}

		// 返回可以遍历数据的迭代器.
		it, err = txn.Get("todo", "id")
		if err != nil {
			panic(err)
		}

		log.Logger.Info().Msg("All the todo:")
		for obj := it.Next(); obj != nil; obj = it.Next() {
			p := obj.(*entity.Todo)
			log.Logger.Info().Msgf("  %d  %s  %s  %t  \n", p.Todoid, p.Todoname, p.Image, p.Studied)
		}
	*/
}
