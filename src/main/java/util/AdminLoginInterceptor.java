package util;

import kr.co.soaff.admin.AdminVO;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class AdminLoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        HttpSession sess = request.getSession();
        AdminVO login = (AdminVO) sess.getAttribute("adminLogin");
        if(login == null){
            PrintWriter writer = response.getWriter();
            writer.print("<script>");
            writer.print("location.href='/admin/login'");
            writer.print("</script>");
            return false;
        }
        return true;
    }
}
