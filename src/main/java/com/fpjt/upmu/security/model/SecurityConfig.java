package com.fpjt.upmu.security.model;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

@Configuration //IoC 빈을 등록
@EnableWebSecurity //필터 체인 관리 시작 어노테이션
public class SecurityConfig extends WebSecurityConfigurerAdapter {

//	@Override
//	protected void configure(HttpSecurity http) throws Exception {
//		System.out.println("들어왔음.");
//		RequestMatcher csrfRequestMatcher = new RequestMatcher() {
//
//		      // Disable CSFR protection on the following urls:
//		      private AntPathRequestMatcher[] requestMatchers = {
//		          new AntPathRequestMatcher("/employeeList/**"),
//		      };
//
//		      @Override
//		      public boolean matches(HttpServletRequest request) {
////		         If the request match one url the CSFR protection will be disabled
//		        for (AntPathRequestMatcher rm : requestMatchers) {
//		          if (rm.matches(request)) { return false; }
//		        }
//		        return true;
//		      } // method matches
//
//		    }; // new RequestMatcher
//
//		    // Set security configurations
//		    http
//		      // Disable the csrf protection on some request matches
//		      .csrf()
//		        .requireCsrfProtectionMatcher(csrfRequestMatcher)
//		        .and();
//		      // Other configurations for the http object
//	}
//
//	@Override
//	public void configure(WebSecurity web) throws Exception {
//		web.ignoring().mvcMatchers("https://www.juso.go.kr/addrlink/addrLinkUrl.do");
//	}
//

	
}
