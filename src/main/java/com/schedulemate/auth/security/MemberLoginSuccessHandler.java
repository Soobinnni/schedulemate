package com.schedulemate.auth.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

/*
 *  로그인 성공 처리자 
 * AuthenticationSuccessHandler 인터페이스를 직접 구현하여 인증 전에 접근을 시도한 URL 로
 * 리다이렉트하는 기능을 구현한다
 */
public class MemberLoginSuccessHandler implements AuthenticationSuccessHandler {
	// RequestCache : 인증 메커니즘으로 리디렉션한 후 단일 요청을 검색하고 다시 시작할 수 있도록 "저장된 요청" 논리를 구현합니다.
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		// 사용자 정의 메소드 : session attribute(request : 인증성공의 원인이 된 요청)를 제거. 로그인에 성공하면, 과거
		// session이 제거된다.
		clearAuthenticationAttribute(request);

		// redirect될 url지정
		resultRedirectStrategy(request, response, auth);
	}

	private void resultRedirectStrategy(HttpServletRequest request, javax.servlet.http.HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		if (savedRequest != null) {
			// 권한을 묻는 페이지로 인해 로그인이 될 경우, 로그인 성공 후 해당 페이지(이전 페이지)로 이동
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStrategy.sendRedirect(request, response, targetUrl);
			return;
		}
		if (savedRequest == null) {
			// 지정
			String targetUrl = null;

			List<String> roleNames = new ArrayList<>();
			auth.getAuthorities().forEach(authority -> {
				roleNames.add(authority.getAuthority());
			});
			System.out.println(roleNames.isEmpty());
			System.out.println(roleNames.toString());

			if (roleNames.contains("ROLE_MEMBER")) {
				targetUrl = "/schedule/home";
			}
			redirectStrategy.sendRedirect(request, response, targetUrl);
			return;
		}
	}

	private void clearAuthenticationAttribute(HttpServletRequest request) {
		// getSession()메서드에 인수를 boolean값을 받아냄으로써 id가 일치 않을 경우 아예 session을 생성하지 않는 방법
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION); // 인증 실패 예외캐시를 지움.
	}
}