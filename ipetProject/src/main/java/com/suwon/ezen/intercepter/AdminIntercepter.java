package com.suwon.ezen.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.suwon.ezen.vo.MemberVO;

public class AdminIntercepter extends HandlerInterceptorAdapter{
	
	 
    @Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		MemberVO vo= (MemberVO) RequestContextHolder.getRequestAttributes().getAttribute("loginMember", RequestAttributes.SCOPE_SESSION);
		if(vo == null || !vo.getAuth().equals("a")) {
			request.setAttribute("msg", "관리자만 접근 가능합니다.");
			request.getRequestDispatcher("/WEB-INF/views/admin/alert.jsp").forward(request, response);
			return false;
			
		}
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);
	}

		@Override
	    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
	            throws Exception {
	        // TODO Auto-generated method stub
	        super.afterCompletion(request, response, handler, ex);
	    }

}
