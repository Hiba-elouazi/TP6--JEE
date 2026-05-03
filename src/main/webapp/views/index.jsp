<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Produits — Spring MVC</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; color: #212121; }

        /* NAVBAR */
        .navbar {
            background: linear-gradient(135deg, #1a237e, #0d47a1);
            color: white; padding: 0 32px; height: 60px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            position: sticky; top: 0; z-index: 100;
        }
        .navbar-brand { font-size: 18px; font-weight: 800; }
        .navbar-user  { display: flex; align-items: center; gap: 12px; font-size: 14px; }
        .badge { padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 800; }
        .badge-admin { background: #ffcdd2; color: #b71c1c; }
        .badge-user  { background: #c8e6c9; color: #1b5e20; }
        .btn-logout {
            background: rgba(255,255,255,0.15); color: white;
            border: 1px solid rgba(255,255,255,0.3);
            padding: 6px 16px; border-radius: 6px;
            cursor: pointer; font-size: 13px; text-decoration: none;
        }
        .btn-logout:hover { background: rgba(255,255,255,0.25); }

        /* LAYOUT */
        .container { max-width: 1200px; margin: 28px auto; padding: 0 24px; }
        .layout { display: grid; grid-template-columns: 320px 1fr; gap: 24px; align-items: start; }

        /* ALERTS */
        .alert { padding: 13px 18px; border-radius: 8px; margin-bottom: 22px; font-size: 14px; }
        .alert-success { background: #e8f5e9; border-left: 4px solid #43a047; color: #2e7d32; }
        .alert-error   { background: #ffebee; border-left: 4px solid #e53935; color: #c62828; }
        .alert-info    { background: #e3f2fd; border-left: 4px solid #1e88e5; color: #0d47a1; }

        /* CARD */
        .card {
            background: white; border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07); padding: 28px;
        }
        .card-title {
            font-size: 16px; font-weight: 700; color: #1a237e;
            margin-bottom: 20px; padding-bottom: 12px;
            border-bottom: 2px solid #e8eaf6;
        }

        /* FORM */
        .form-group { margin-bottom: 16px; }
        .form-group label {
            display: block; font-size: 11px; font-weight: 700;
            color: #616161; text-transform: uppercase;
            letter-spacing: 0.8px; margin-bottom: 7px;
        }
        .form-group input {
            width: 100%; padding: 10px 13px;
            border: 2px solid #e0e0e0; border-radius: 7px;
            font-size: 14px; outline: none; background: #fafafa;
        }
        .form-group input:focus { border-color: #1a237e; background: white; }
        .btn {
            width: 100%; padding: 11px; border: none; border-radius: 7px;
            font-size: 14px; font-weight: 700; cursor: pointer; transition: all 0.2s;
        }
        .btn:hover { transform: translateY(-1px); }
        .btn-primary { background: linear-gradient(135deg, #1a237e, #0d47a1); color: white; }
        .btn-update  { background: linear-gradient(135deg, #e65100, #f57c00); color: white; }
        .btn-cancel  {
            display: block; text-align: center; margin-top: 8px;
            padding: 10px; background: #f5f5f5; color: #616161;
            border: 2px solid #e0e0e0; border-radius: 7px;
            text-decoration: none; font-weight: 600; font-size: 14px;
        }
        .info-panel {
            background: #e8eaf6; border-radius: 8px; padding: 18px;
            font-size: 14px; color: #3949ab; line-height: 1.7;
        }

        /* SEARCH */
        .search-bar { display: flex; gap: 8px; margin-bottom: 18px; flex-wrap: wrap; }
        .search-bar input {
            flex: 1; min-width: 140px; padding: 9px 14px;
            border: 2px solid #e0e0e0; border-radius: 7px; font-size: 14px; outline: none;
        }
        .search-bar input:focus { border-color: #0d47a1; }
        .btn-search {
            padding: 9px 18px; background: #0d47a1; color: white;
            border: none; border-radius: 7px; cursor: pointer; font-size: 14px; font-weight: 600;
        }
        .btn-reset {
            padding: 9px 14px; background: #eeeeee; color: #424242;
            border: none; border-radius: 7px; cursor: pointer;
            font-size: 14px; text-decoration: none;
            display: inline-flex; align-items: center;
        }
        .result-count {
            font-size: 13px; color: #757575; margin-bottom: 14px;
            padding: 5px 12px; background: #f5f5f5;
            border-radius: 6px; display: inline-block;
        }

        /* TABLE */
        table { width: 100%; border-collapse: collapse; }
        thead tr { background: linear-gradient(135deg, #1a237e, #283593); color: white; }
        thead th {
            padding: 13px 16px; text-align: left;
            font-size: 12px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 0.6px;
        }
        tbody tr { border-bottom: 1px solid #f0f0f0; transition: background 0.15s; }
        tbody tr:hover { background: #f3f4ff; }
        tbody td { padding: 13px 16px; font-size: 14px; color: #424242; }
        .td-id   { color: #9e9e9e; font-size: 12px; font-weight: 600; }
        .td-nom  { font-weight: 700; color: #212121; }
        .td-prix { font-weight: 800; color: #1a237e; }
        .actions { display: flex; gap: 6px; }
        .btn-edit {
            padding: 5px 12px; background: #ff9800; color: white;
            border: none; border-radius: 5px; cursor: pointer;
            font-size: 12px; font-weight: 600;
        }
        .btn-delete {
            padding: 5px 12px; background: #f44336; color: white;
            border: none; border-radius: 5px; cursor: pointer;
            font-size: 12px; font-weight: 600;
        }
        .empty-state { text-align: center; padding: 52px; color: #bdbdbd; }

        @media (max-width: 768px) { .layout { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<%-- NAVBAR --%>
<nav class="navbar">
    <div class="navbar-brand">📦 Gestion des Produits — Spring MVC</div>
    <div class="navbar-user">
        👤 <strong>${sessionScope.userConnecte.username}</strong>
        <c:choose>
            <c:when test="${sessionScope.role == 'ADMIN'}">
                <span class="badge badge-admin">ADMIN</span>
            </c:when>
            <c:otherwise>
                <span class="badge badge-user">USER</span>
            </c:otherwise>
        </c:choose>
        <%-- Spring MVC : déconnexion via GET /logout --%>
        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Déconnexion</a>
    </div>
</nav>

<div class="container">

    <%-- Alertes --%>
    <c:if test="${not empty messageSucces}">
        <div class="alert alert-success">✅ ${messageSucces}</div>
    </c:if>
    <c:if test="${not empty messageErreur}">
        <div class="alert alert-error">⚠️ ${messageErreur}</div>
    </c:if>
    <c:if test="${not empty messageInfo}">
        <div class="alert alert-info">ℹ️ ${messageInfo}</div>
    </c:if>

    <div class="layout">

        <%-- COLONNE GAUCHE : Formulaire --%>
        <div>
            <c:choose>
                <c:when test="${sessionScope.role == 'ADMIN'}">
                    <div class="card">
                        <div class="card-title">
                            <c:choose>
                                <c:when test="${produitEdit != null}">✏️ Modifier le produit</c:when>
                                <c:otherwise>➕ Ajouter un produit</c:otherwise>
                            </c:choose>
                        </div>

                        <%--
                            Spring MVC : l'action change selon le mode
                            Ajout   → POST /produits/add
                            Modif   → POST /produits/update
                        --%>
                        <form action="${pageContext.request.contextPath}/${produitEdit != null ? 'produits/update' : 'produits/add'}"
                              method="post">

                            <input type="hidden" name="idProduit" value="${produitEdit.idProduit}"/>

                            <div class="form-group">
                                <label>Nom du produit *</label>
                                <input type="text" name="nom" value="${produitEdit.nom}"
                                       placeholder="Ex: Laptop Dell" required/>
                            </div>
                            <div class="form-group">
                                <label>Description *</label>
                                <input type="text" name="description" value="${produitEdit.description}"
                                       placeholder="Ex: Core i7, 16Go RAM" required/>
                            </div>
                            <div class="form-group">
                                <label>Prix (MAD) *</label>
                                <input type="number" name="prix" step="0.01" min="0"
                                       value="${produitEdit.prix}" placeholder="Ex: 8500.00" required/>
                            </div>

                            <button type="submit"
                                    class="btn ${produitEdit != null ? 'btn-update' : 'btn-primary'}">
                                <c:choose>
                                    <c:when test="${produitEdit != null}">✔ Mettre à jour</c:when>
                                    <c:otherwise>➕ Ajouter le produit</c:otherwise>
                                </c:choose>
                            </button>

                            <c:if test="${produitEdit != null}">
                                <%-- Annuler → retour à la liste --%>
                                <a href="${pageContext.request.contextPath}/produits" class="btn-cancel">
                                    ✖ Annuler
                                </a>
                            </c:if>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card">
                        <div class="card-title">ℹ️ Mode consultation</div>
                        <div class="info-panel">
                            Connecté en tant que <strong>USER</strong>.<br/><br/>
                            Vous pouvez <strong>consulter</strong> et
                            <strong>rechercher</strong> des produits.<br/><br/>
                            Les actions CRUD sont réservées aux <strong>ADMIN</strong>.
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- COLONNE DROITE : Tableau --%>
        <div class="card">
            <div class="card-title">📋 Liste des produits</div>

            <%--
                Spring MVC : recherche via GET /produits/search
            --%>
            <form action="${pageContext.request.contextPath}/produits/search" method="get">
                <div class="search-bar">
                    <input type="number" name="idProduit" placeholder="🔍 ID exact..." min="1"/>
                    <input type="text"   name="motCle"    value="${motCle}"
                           placeholder="🔍 Nom ou description..."/>
                    <button type="submit" class="btn-search">Chercher</button>
                    <a href="${pageContext.request.contextPath}/produits" class="btn-reset">✖ Reset</a>
                </div>
            </form>

            <c:if test="${not empty listeProduits}">
                <span class="result-count">${listeProduits.size()} produit(s)</span>
            </c:if>

            <c:choose>
                <c:when test="${not empty listeProduits}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th><th>Nom</th><th>Description</th><th>Prix</th>
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <th>Actions</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${listeProduits}">
                                <tr>
                                    <td class="td-id">#${p.idProduit}</td>
                                    <td class="td-nom">${p.nom}</td>
                                    <td>${p.description}</td>
                                    <td class="td-prix">${p.prix} MAD</td>
                                    <c:if test="${sessionScope.role == 'ADMIN'}">
                                        <td>
                                            <div class="actions">
                                                <%-- Spring MVC : GET /produits/edit?id=X --%>
                                                <a href="${pageContext.request.contextPath}/produits/edit?id=${p.idProduit}">
                                                    <button class="btn-edit">✏️ Modifier</button>
                                                </a>
                                                <%-- Spring MVC : GET /produits/delete?id=X --%>
                                                <a href="${pageContext.request.contextPath}/produits/delete?id=${p.idProduit}"
                                                   onclick="return confirm('Supprimer « ${p.nom} » ?')">
                                                    <button class="btn-delete">🗑 Supprimer</button>
                                                </a>
                                            </div>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div style="font-size:52px">📭</div>
                        <p>Aucun produit à afficher.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>