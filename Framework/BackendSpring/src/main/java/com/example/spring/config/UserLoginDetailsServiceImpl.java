package com.example.spring.config;

import com.example.spring.entity.Login;
import com.example.spring.repository.LoginRepositories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * @Description: UserDetailsService 被 DaoAuthenticationProvider
 *               用来检索用户名、密码和其他属性，以便用用户名和密码进行认证
 * @Param:
 * @Return:
 */
@Service
public class UserLoginDetailsServiceImpl implements UserDetailsService {

	@Autowired
	LoginRepositories repository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// System.out.println("---------UserLoginDetailsServiceImpl");

		if (!StringUtils.hasLength(username)) {
			throw new UsernameNotFoundException("用户不能为空");
		}

		// 数据库查询
		Login userEntity = repository.findByUserId(username);
		if (userEntity == null) {
			throw new UsernameNotFoundException("用户不存在");
		}
		// 根据用户ID，查询用户的权限
		// List<Role> roles = authenticationMapper.findRoleByUserId(myUser.getId());
		// 权限
		List<GrantedAuthority> authorities = new CopyOnWriteArrayList<>();
		// SimpleGrantedAuthority为GrantedAuthority的基本具体实现，存储授予Authentication对象的权限的String表示形式
		// authorities.add(new SimpleGrantedAuthority("admin"));
		// authorities.add(new SimpleGrantedAuthority("user"));
		// authorities.add(new SimpleGrantedAuthority("ROLE_admin"));
		authorities.add(new SimpleGrantedAuthority("ROLE_user"));
		// for (Role role : roles) {
		// authorities.add(new SimpleGrantedAuthority("ROLE_"+role.getName()));
		// }

		// 设置密码的时候需要使用BCryptPasswordEncoder()加密
		return new User(userEntity.getUserId(), new BCryptPasswordEncoder().encode(userEntity.getPassword()),
				authorities);
	}
}
