<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><title>Erreur</title>
    <style>
        body { font-family:'Segoe UI',sans-serif; background:#f5f7fa;
               display:flex; align-items:center; justify-content:center; min-height:100vh; }
        .box { background:white; border-radius:12px; padding:48px; text-align:center;
               box-shadow:0 4px 24px rgba(0,0,0,0.1); max-width:480px; }
        .code { font-size:80px; font-weight:900; color:#1a237e; }
        h2 { font-size:22px; color:#424242; margin:12px 0; }
        p  { color:#757575; margin-bottom:24px; }
        .btn { display:inline-block; padding:12px 24px; margin:4px;
               background:linear-gradient(135deg,#1a237e,#0d47a1);
               color:white; border-radius:8px; text-decoration:none; font-weight:700; }
        .btn-gray { background:#757575; }
    </style>
</head>
<body>
<div class="box">
    <%
        Integer code = (Integer) request.getAttribute("javax.servlet.error.status_code");
    %>
    <div class="code"><%= code != null ? code : "⚠" %></div>
    <c:choose>
        <c:when test="${not empty messageErreur}">
            <h2>Accès refusé</h2>
            <p style="color:#c62828">${messageErreur}</p>
        </c:when>
        <c:otherwise>
            <h2>Une erreur est survenue</h2>
            <p>La page demandée n'est pas disponible.</p>
        </c:otherwise>
    </c:choose>
    <a href="${pageContext.request.contextPath}/produits" class="btn">🏠 Accueil</a>
    <a href="javascript:history.back()" class="btn btn-gray">← Retour</a>
</div>
</body>
</html>