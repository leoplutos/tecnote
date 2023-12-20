package com.example.spring.common;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

//读取jwt.properties配置的密钥
//jwt.signingKey - 密钥
//jwt.expiration - 令牌有效时间（毫秒）
@Configuration
@PropertySource(value = { "jwt.properties" }, encoding = "UTF-8")
@ConfigurationProperties(ignoreUnknownFields = true, prefix = "jwt")
public class JwtProperties {

	// 密钥
	private String signingKey;

	// 令牌有效时间（毫秒）
	private Long expiration;

	public String getSigningKey() {
		return signingKey;
	}

	public void setSigningKey(String signingKey) {
		this.signingKey = signingKey;
	}

	public Long getExpiration() {
		return expiration;
	}

	public void setExpiration(Long expiration) {
		this.expiration = expiration;
	}

}
