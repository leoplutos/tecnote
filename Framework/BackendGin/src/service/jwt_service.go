package service

import (
	"BackendGin/src/global"
	"github.com/golang-jwt/jwt/v4"
	"time"
)

type jwtService struct {
}

var JwtService = new(jwtService)

// CustomClaims 自定义 Claims
type CustomClaims struct {
	jwt.RegisteredClaims
}

const (
	TokenType    = "bearer"
	AppGuardName = "app"
)

func (jwtService *jwtService) CreateToken(GuardName string, user string) (tokenData string, token *jwt.Token, err error) {
	token = jwt.NewWithClaims(
		jwt.SigningMethodHS256,
		CustomClaims{
			RegisteredClaims: jwt.RegisteredClaims{
				ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Duration(global.App.Jwt_ttl) * time.Second)),
				ID:        user,
				Issuer:    GuardName,
				NotBefore: jwt.NewNumericDate(time.Now().Add(-1000 * time.Second)),
			},
		},
	)

	tokenStr, err := token.SignedString([]byte(global.App.Jwt_secret))

	return tokenStr, token, err
}
