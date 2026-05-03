package services;

import dao.ProduitDAO;
import dao.ProduitDAOImpl;
import entities.Produit;

import java.util.List;


public class ProduitServiceImpl implements ProduitService {

    private ProduitDAO dao;

    public void setDao(ProduitDAO dao) {
        this.dao = dao;
    }

    @Override
    public void addProduit(Produit p) {
        if (p.getNom() == null || p.getNom().trim().isEmpty())
            throw new IllegalArgumentException("Le nom ne peut pas être vide.");
        if (p.getPrix() == null || p.getPrix() < 0)
            throw new IllegalArgumentException("Le prix doit être positif.");
        dao.addProduit(p);
    }

    @Override
    public void deleteProduit(Long id)       { dao.deleteProduit(id); }

    @Override
    public Produit getProduitById(Long id)   { return dao.getProduitById(id); }

    @Override
    public List<Produit> getAllProduits()     { return dao.getAllProduits(); }

    @Override
    public void updateProduit(Produit p) {
        if (p.getNom() == null || p.getNom().trim().isEmpty())
            throw new IllegalArgumentException("Le nom ne peut pas être vide.");
        if (p.getPrix() == null || p.getPrix() < 0)
            throw new IllegalArgumentException("Le prix doit être positif.");
        dao.updateProduit(p);
    }

    @Override
    public List<Produit> rechercherParMotCle(String motCle) {
        if (motCle == null || motCle.trim().isEmpty()) return dao.getAllProduits();
        return dao.rechercherParMotCle(motCle.trim());
    }
}
