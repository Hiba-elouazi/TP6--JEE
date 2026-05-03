package filters;

import entities.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Filtre de contrôle des rôles — réserve les actions CRUD aux ADMIN.
 * Appliqué sur /produits/add, /produits/edit, /produits/update, /produits/delete
 */
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
            // Accès refusé → rediriger vers la liste avec message
            resp.sendRedirect(req.getContextPath()
                + "/produits?messageErreur=Accès+refusé+:+rôle+ADMIN+requis");
        }
    }

    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}