with p_fenbase; use p_fenbase;
with Forms; use Forms;

package body p_vue_graph is 

    function InitNom return string is
    --{}=>{Ouvre une fenetre pour initialiser le nom de l'utilisateur }
        F : TR_Fenetre;
        Nom : string(1..10) := (others => ' ');
    begin
        F := DebutFenetre("NomJoueur", 400, 150);
            AjouterBouton(F,"Valider","Valider",140,90,55,30);
            AjouterBouton(F,"Annuler","Annuler",200,90,55,30);
            AjouterChamp(F, "Nom","Nom","Entrer Nom",160,40,100,30);
        FinFenetre(F);
        MontrerFenetre(F);

        if AttendreBouton(F) = "Valider" then
            CacherFenetre(F);
            return ConsulterContenu(F, "Nom");
        else 
            CacherFenetre(F);
            return Nom;
        end if;
    end InitNom;

    function InitDifficulte return ST_Difficulte is
    --{}=>{résultat=}
        F : TR_Fenetre;
        Difficulte : T_Difficulte;
    begin
        F := DebutFenetre()
            AjouterBouton(F,"Facile", "Facile",  );
            AjouterBouton(F, "Normale", "Normale",   );
            AjouterBouton(F, "Difficile", "Difficile", )
    end InitDifficulte;
     
    procedure InitGrille(G : in out TV_Grille;  NombreBombe , Colone, Ligne : in out Positive )  is 
    --{}=>{ Initialise l'array pour la grille}
    begin
        for ligne in Col
    end InitGrille;
                                                                                                                                                
    procedure CreeFenetreJeu (F : in out TR_Fenetre; Nom : string; X, Y : in Natural) is
    --{F, Nom, X, Y: Longueur, Largeur de la fenetre}=>{ ouvre une fenetre de jeu }
    begin
        F := DebutFenetre(Nom, X, Y);
            AjouterBouton(F,"Abandonner","Abandonner", X-10, Y-50, 50, 50); -- Abandonner une partie
            AjouterBouton(F,"Restart","Restart", X-20, Y-100, 50, 50); -- Redemarrer une partie
            AjouterBouton(F,"ChangerNom","ChangerNom", X-30, Y-150, 50, 50); -- Changer de nom
        FinFenetre(F);
        MontrerFenetre(F);
            
        if AttendreBouton(F) = "Abandonner" then
            CacherFenetre(F);
        elsif AttendreBouton(F) = "Restart" then
            CacherFenetre(F);
        else 
            CacherFenetre(F);
        end if;
    end CreeFenetreJeu;
    
end p_vue_graph;
