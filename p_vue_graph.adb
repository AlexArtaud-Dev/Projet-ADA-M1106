with p_fenbase; use p_fenbase;
with Forms; use Forms;

package body p_vue_graph is 


    procedure Main (F: in out TR_Fenetre) is 
    --{}=>{}
    begin
        F:= DebutFenetre("Main", Fenetre_Size.X, Fenetre_Size.Y);

            AjouterBoutonRond(F,"Aide","AIDE", integer(Fenetre_Size.X/3), integer(Fenetre_Size.Y/3), 50);
            AjouterBoutonRond(F,"Score","SCORE", integer(Fenetre_Size.X/3), integer(Fenetre_Size.Y/3), 50);
            AjouterBoutonRond(F,"Jouer","JOUER", integer(Fenetre_Size.X/3), integer(Fenetre_Size.Y/3), 50);
            AjouterBoutonRond(F,"Quitter","QUITTER", integer(Fenetre_Size.X/3), integer(Fenetre_Size.Y/3), 50);
            AjouterBoutonRond(F,"Quitter","QUITTER", integer(Fenetre_Size.X/3), integer(Fenetre_Size.Y/3), 50); 
        FinFenetre(F);
        MontrerFenetre(F);

        if AttendreBouton(F) = "Jouer" then
            CacherFenetre(F);
            Aide;
        elsif AttendreBouton(F)="Score" then
            CacherFenetre(F);
            Score(F);
        elsif AttendreBouton(F)="Quitter" then 
            CacherFenetre(F);

        end if;
    end Main;

    procedure Aide(F: in out TR_Fenetre) is 
     --{} => {}
        Largeur, Hauteur : integer;
    begin
        F := DebutFenetre("Aide", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F, "Retour", "RETOUR", 140, 90, 55, 30);

            AjouterText(F, "Regles",
                "Vous disposez d'une grille contenant des mines cachées. En cliquant sur une case vous connaissez le nombre de mines se trouvant dans les cases (8 au maximum) qui l'entourent. Le but du jeu est de détecter toutes les mines sans cliquer dessus ",
                Button_Size.X, Button_Size.Y, 10, 10
            );

            AjouterText(F, "Controles",
                "Pour Afficher les cases vous devez cliquer gauche sur celle-ci. Pour marquer les cases que vous pensez qu'elles habritent une bombe cliquez droit.", 
                Fenetre_Size.X, Fenetre_Size.Y,Largeur,Hauteur
            );
        FinFenetre(F);
        MontrerFenetre(F);

        if AttendreBouton(F) = "RETOUR" then
            Main(F);
            CacherFenetre(F);
        end if;
        CacherFenetre(F);
    end Aide;

    procedure Score (F:in out TR_Fenetre) is 
    --{} => {}
    begin
        F := DebutFenetre(Score, 400, 150);
            ConsulterTimer(F, "Minuteur");
            )
        FinFenetre(F);
        MontrerFenetre(F);
    end Aide;
    

    function InitNom return string is
    --{} => {Ouvre une fenetre pour initialiser le nom de l'utilisateur }
        F : TR_Fenetre;
        Nom : string(1..10) := (others => ' ');
    begin
        F := DebutFenetre("NomJoueur", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Valider","VALIDER",140,90,55,30);
            AjouterBouton(F,"Annuler","ANNULER",200,90,55,30);
            AjouterChamp(F, "Nom","Nom","Entrer Nom",160,40,100,30);
        FinFenetre(F);
        MontrerFenetre(F);

        if AttendreBouton(F) = "VALIDER" then
            CacherFenetre(F);
            return ConsulterContenu(F, "Nom");
        else 
            CacherFenetre(F);
            return Nom;
        end if;
    end InitNom;

    function InitDifficulte return ST_Difficulte is
    --{} => {résultat=}
        F : TR_Fenetre;
        Difficulte : T_Difficulte;
    begin
        F := DebutFenetre()
            AjouterBouton(F, "Facile", "Facile",  );
            AjouterBouton(F, "Normale", "Normale",   );
            AjouterBouton(F, "Difficile", "Difficile", )
    end InitDifficulte;
     
    procedure GenererGrille(G : in out TV_Grille;  NombreBombe : in Positive )  is 
    --{} => { Initialise l'array pour la grille}
    begin
        return null;
    end GenererGrille;
                                                                                                                                                
    procedure CreeFenetreJeu (F : in out TR_Fenetre; Nom : string; X, Y : in Natural) is
    --{F, Nom, X, Y: Longueur, Largeur de la fenetre} => { ouvre une fenetre de jeu }
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
