package util;

import kr.co.soaff.user.UserVO;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class UserLoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        HttpSession sess = request.getSession();
        UserVO login = (UserVO) sess.getAttribute("vo");
        response.setContentType("text/html charset=utf-8 ");
        if(login == null){
            PrintWriter writer = response.getWriter();
            writer.println("<script>");
            writer.println("if(confirm('로그인이 필요한 기능입니다.\\n로그인 하시겠습니까?')){");			
            writer.println("location.href = '/user/user/login';}");
            writer.println("else{window.history.go(-1);}");
            writer.println("</script>");
            return false;
        }
        return true;
    }
}
