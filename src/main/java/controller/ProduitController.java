package controller;

import entities.Produit;
import entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import services.ProduitService;
import services.UserService;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class ProduitController {
 
    @Autowired
    private ProduitService produitService;

    @Autowired
    private UserService userService;

 
    @GetMapping("/login")
    public String loginForm(HttpSession session) {
        
        if (session.getAttribute("userConnecte") != null) {
            return "redirect:/produits";
        }
        return "login";   
    }
 
    @PostMapping("/login")
    public String loginSubmit(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        User user = userService.authenticate(username, password);

        if (user != null) {
            session.setAttribute("userConnecte", user);
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60);
            return "redirect:/produits";
        } else {
            model.addAttribute("erreur", "Identifiants incorrects.");
            model.addAttribute("username", username);
            return "login";
        }
    }
 
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
 
    @GetMapping("/produits")
    public String listeProduits(Model model,
                                @RequestParam(required = false) String messageSucces,
                                @RequestParam(required = false) String messageErreur) {

        model.addAttribute("listeProduits", produitService.getAllProduits());
        if (messageSucces != null) model.addAttribute("messageSucces", messageSucces);
        if (messageErreur != null) model.addAttribute("messageErreur", messageErreur);
        return "index";  
    }

  
    @GetMapping("/produits/search")
    public String searchProduit(
            Model model,
            @RequestParam(required = false) Long   idProduit,
            @RequestParam(required = false) String motCle) {

        List<Produit> liste;

        if (idProduit != null) {
            Produit p = produitService.getProduitById(idProduit);
            liste = p != null ? List.of(p) : List.of();
            if (p == null) model.addAttribute("messageInfo",
                "Aucun produit avec l'ID : " + idProduit);
        } else if (motCle != null && !motCle.trim().isEmpty()) {
            liste = produitService.rechercherParMotCle(motCle.trim());
            model.addAttribute("motCle", motCle);
            if (liste.isEmpty()) model.addAttribute("messageInfo",
                "Aucun résultat pour : \"" + motCle + "\"");
        } else {
            liste = produitService.getAllProduits();
        }

        model.addAttribute("listeProduits", liste);
        return "index";
    }

    /**
     * POST /produits/add → Ajouter un produit
     */
    @PostMapping("/produits/add")
    public String addProduit(
            @RequestParam String nom,
            @RequestParam String description,
            @RequestParam Double prix,
            RedirectAttributes redirectAttrs) {

        try {
            produitService.addProduit(new Produit(nom.trim(), description.trim(), prix));
            redirectAttrs.addAttribute("messageSucces", "Produit ajouté avec succès !");
        } catch (IllegalArgumentException e) {
            redirectAttrs.addAttribute("messageErreur", e.getMessage());
        }
        return "redirect:/produits";  // PRG Pattern
    }

    /**
     * GET /produits/edit?id=3 → Charger le formulaire de modification
     */
    @GetMapping("/produits/edit")
    public String editProduit(@RequestParam Long id, Model model) {
        Produit produit = produitService.getProduitById(id);
        if (produit == null) {
            model.addAttribute("messageErreur", "Produit introuvable (ID : " + id + ")");
            model.addAttribute("listeProduits", produitService.getAllProduits());
            return "index";
        }
        model.addAttribute("produitEdit",  produit);
        model.addAttribute("listeProduits", produitService.getAllProduits());
        return "index";
    }

    /**
     * POST /produits/update → Mettre à jour un produit
     */
    @PostMapping("/produits/update")
    public String updateProduit(
            @RequestParam Long   idProduit,
            @RequestParam String nom,
            @RequestParam String description,
            @RequestParam Double prix,
            RedirectAttributes redirectAttrs) {

        try {
            Produit p = new Produit();
            p.setIdProduit(idProduit);
            p.setNom(nom.trim());
            p.setDescription(description.trim());
            p.setPrix(prix);
            produitService.updateProduit(p);
            redirectAttrs.addAttribute("messageSucces", "Produit mis à jour !");
        } catch (IllegalArgumentException e) {
            redirectAttrs.addAttribute("messageErreur", e.getMessage());
        }
        return "redirect:/produits";  // PRG Pattern
    }

    /**
     * GET /produits/delete?id=3 → Supprimer un produit
     */
    @GetMapping("/produits/delete")
    public String deleteProduit(@RequestParam Long id,
                                RedirectAttributes redirectAttrs) {
        try {
            produitService.deleteProduit(id);
            redirectAttrs.addAttribute("messageSucces", "Produit supprimé !");
        } catch (Exception e) {
            redirectAttrs.addAttribute("messageErreur", "Erreur lors de la suppression.");
        }
        return "redirect:/produits";  // PRG Pattern
    }
}
