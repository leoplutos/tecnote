package middleware

import (
	"BackendGin/src/common/response"
	"BackendGin/src/global"
	"BackendGin/src/service"
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v4"
)

func JWTAuth(GuardName string) gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenStr := c.Request.Header.Get("token")
		if tokenStr == "" {
			response.Fail(c, 401, "未携带token,请登录")
			c.Abort()
			return
		}

		token, err := jwt.ParseWithClaims(tokenStr, &service.CustomClaims{}, func(token *jwt.Token) (interface{}, error) {
			return []byte(global.App.Jwt_secret), nil
		})
		if err != nil {
			response.Fail(c, 402, "未携带token,请登录")
			c.Abort()
			return
		}

		claims := token.Claims.(*service.CustomClaims)
		if claims.Issuer != GuardName {
			response.Fail(c, 403, "未携带token,请登录")
			c.Abort()
			return
		}

		c.Set("token", token)
		c.Set("id", claims.ID)
	}
}
