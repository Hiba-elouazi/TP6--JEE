package filters;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Filtre d'authentification Spring MVC (javax.servlet pour Tomcat 9)
 * Intercepte toutes les requêtes et vérifie la session.
 */
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri         = req.getRequestURI();
        String contextPath = req.getContextPath();

        // URLs publiques — accessibles sans connexion
        boolean estPublic = uri.equals(contextPath + "/login")
                         || uri.startsWith(contextPath + "/login?")
                         || uri.endsWith(".css")
                         || uri.endsWith(".js")
                         || uri.endsWith(".png")
                         || uri.endsWith(".ico");

        if (estPublic) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session  = req.getSession(false);
        boolean     connecte = session != null
                            && session.getAttribute("userConnecte") != null;

        if (connecte) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(contextPath + "/login");
        }
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}