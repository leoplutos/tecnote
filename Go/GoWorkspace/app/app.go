package main

import (
	"fmt"
	"github.com/google/uuid"
	"goworkspace/core/constant"
)

func main() {
	app_nm := "app/app.go -> " + uuid.NewString()
	fmt.Println(app_nm)
	fmt.Printf("MODULE_NAME = %s\n", constant.MODULE_NAME)
	fmt.Printf("MODULE_VERSION = %d\n", constant.MODULE_VERSION)
	fmt.Printf("PI = %f\n", constant.PI)
}
