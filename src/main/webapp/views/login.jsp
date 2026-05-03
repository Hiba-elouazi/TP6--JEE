<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion — Gestion des Produits</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a237e 0%, #0d47a1 50%, #01579b 100%);
            min-height: 100vh; display: flex;
            align-items: center; justify-content: center;
        }
        .card {
            background: #fff; border-radius: 14px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 48px 40px; width: 100%; max-width: 420px;
        }
        .header { text-align: center; margin-bottom: 36px; }
        .header h1 { font-size: 24px; color: #1a237e; font-weight: 800; }
        .header p  { color: #9e9e9e; font-size: 13px; margin-top: 6px; }
        .form-group { margin-bottom: 18px; }
        label {
            display: block; font-size: 11px; font-weight: 700;
            color: #616161; text-transform: uppercase;
            letter-spacing: 0.8px; margin-bottom: 7px;
        }
        input[type="text"], input[type="password"] {
            width: 100%; padding: 11px 14px;
            border: 2px solid #e0e0e0; border-radius: 8px;
            font-size: 15px; outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        input:focus {
            border-color: #1a237e;
            box-shadow: 0 0 0 3px rgba(26,35,126,0.1);
        }
        .btn-login {
            width: 100%; padding: 13px;
            background: linear-gradient(135deg, #1a237e, #0d47a1);
            color: white; border: none; border-radius: 8px;
            font-size: 15px; font-weight: 700; cursor: pointer;
            transition: all 0.2s; margin-top: 6px;
        }
        .btn-login:hover { opacity: 0.9; transform: translateY(-1px); }
        .alert-error {
            background: #ffebee; border-left: 4px solid #f44336;
            border-radius: 6px; padding: 12px 16px;
            color: #c62828; font-size: 14px; margin-bottom: 22px;
        }
        .comptes {
            margin-top: 28px; background: #e8eaf6;
            border-radius: 10px; padding: 16px;
        }
        .comptes h4 {
            font-size: 11px; color: #1a237e; font-weight: 800;
            text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 10px;
        }
        .compte {
            display: flex; justify-content: space-between; align-items: center;
            padding: 6px 0; border-bottom: 1px solid #c5cae9; font-size: 13px;
        }
        .compte:last-child { border-bottom: none; }
        .badge { font-size: 10px; padding: 2px 8px; border-radius: 10px; font-weight: 800; }
        .badge-admin { background: #ffcdd2; color: #b71c1c; }
        .badge-user  { background: #c8e6c9; color: #1b5e20; }
    </style>
</head>
<body>
<div class="card">
    <div class="header"> 
        <h1>Gestion des Produits</h1> 
    </div>

    <c:if test="${not empty erreur}">
        <div class="alert-error">⚠ ${erreur}</div>
    </c:if>

    <%-- Action Spring MVC : POST /login --%>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Nom d'utilisateur</label>
            <input type="text" id="username" name="username"
                   value="${username}" placeholder="Entrez votre identifiant"
                   required autofocus/>
        </div>
        <div class="form-group">
            <label for="password">Mot de passe</label>
            <input type="password" id="password" name="password"
                   placeholder="Entrez votre mot de passe" required/>
        </div>
        <button type="submit" class="btn-login">Se connecter →</button>
    </form>
 
</div>
</body>
</html>