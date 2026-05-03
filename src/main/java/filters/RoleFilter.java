package filters;

import entities.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;


public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User user = session != null ? (User) session.getAttribute("userConnecte") : null;

        if (user != null && "ADMIN".equals(user.getRole())) {
            chain.doFilter(request, response);
        } else {
             
            resp.sendRedirect(req.getContextPath()
                + "/produits?messageErreur=Accès+refusé+:+rôle+ADMIN+requis");
        }
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}
