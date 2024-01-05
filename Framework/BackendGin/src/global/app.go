package global

import (
	"github.com/hashicorp/go-memdb"
)

// 定义全局变量
type Application struct {
	DB                         *memdb.MemDB
	Jwt_secret                 string
	Jwt_ttl                    int
	Jwt_blacklist_grace_period int
	Jwt_refresh_grace_period   int
}

var App = new(Application)
