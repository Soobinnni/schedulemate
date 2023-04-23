package com.schedulemate.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import com.schedulemate.auth.security.MemberLoginSuccessHandler;
import com.schedulemate.auth.security.MemberAccessDeniedHandler;
import com.schedulemate.auth.security.MemberDetailsService;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private DataSource dataSource;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println("com.project.config.SecurityConfig : security 셋팅");
		http
				/* .formLogin()으로 인증 */
				.formLogin()
				/* .loginPage 커스텀 로그인 페이지로 이동 */
				.loginPage("/auth/login").loginProcessingUrl("/login")
				/* 로그인 성공 후 처리를 담당하는 처리자로 지정한다. */
				.successHandler(createUmemberAuthenticationSuccessHandler()).and()
				/* .and는, .formLogin()의 설정이 끝났음을 의미. */
				.logout()
				/* 로그아웃 처리를 위한 URI를 지정하고, 로그아웃한 후에 세션을 무효화 한다 */
				.logoutUrl("/logout").invalidateHttpSession(true).deleteCookies("remember-me", "JSESSION_ID").and()
				/* 등록한 CustomAccessDeniedHandler를 접근 거부 처리자로 지정한다. */
				.exceptionHandling().accessDeniedHandler(createMemberAccessDeniedHandler());

		// 데이터 소스를 지정하고 테이블을 이용해서 기존 로그인 정보를 기록
		// 쿠키의 유효 시간을 지정한다(24시간).
		http.rememberMe().key("zeus").tokenRepository(createJDBCRepository()).tokenValiditySeconds(60 * 60 * 24);

	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// CustomUserDetailsService 빈을 인증 제공자에 지정한다.
		System.out.println("com.project.config.SecurityConfig : UserDetailsService 호출");
		auth.userDetailsService(createUmemberDetailsService()).passwordEncoder(createPasswordEncoder());
	}

	@Bean
	public PasswordEncoder createPasswordEncoder() {
		// 암호 처리 Security기능
		System.out.println("com.project.config.SecurityConfig : 암호처리");
		return new BCryptPasswordEncoder();
	}

	private PersistentTokenRepository createJDBCRepository() {
		JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
		repo.setDataSource(dataSource);

		return repo;
	}

	// 스프링 시큐리티의 UserDetailsService를 구현한 클래스를 빈으로 등록한다.
	@Bean
	public AuthenticationSuccessHandler createUmemberAuthenticationSuccessHandler() {
		return new MemberLoginSuccessHandler();
	}

	// CustomAccessDeniedHandler를 스프링 빈으로 정의한다.
	@Bean
	public AccessDeniedHandler createMemberAccessDeniedHandler() {
		return new MemberAccessDeniedHandler();
	}

	// CustomUserDetailsService를 스프링 빈으로 정의한다.
	@Bean
	public UserDetailsService createUmemberDetailsService() {
		return new MemberDetailsService();
	}
}