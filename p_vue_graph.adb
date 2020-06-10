with p_fenbase; use p_fenbase;
with Forms; use Forms;

package body p_vue_graph is 


    procedure Main (F: in out TR_Fenetre) is 
    --{}=>{ouvre une fenetre principale avec les différents boutons}

    begin
        F:= DebutFenetre("Main", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Jouer", "JOUER", 273, Button_Size.Y*1+170, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Score", "SCORE", 273, Button_Size.Y*2+180, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Aide", "AIDE", 273, Button_Size.Y*3+190, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Quitter", "QUITTER", 273, Button_Size.Y*4+200, Button_Size.X, Button_Size.Y);
            AjouterImage(F, "tntxpm","tnt2.xpm", "  ", 45, 300 ,200,200 );
            AjouterImage(F, "tntxpm","tnt3.xpm", "  ", 575, 300 ,200,200 );
 
        FinFenetre(F);
        MontrerFenetre(F);
        
        declare 
            ClickedButton : string := AttendreBouton(F);
            NomJoueur:string(1..10) := (others =>(' '));
        begin
            if ClickedButton = "Score" then
                CacherFenetre(F);
                Score(F);
                
            elsif ClickedButton = "Jouer" then
                CacherFenetre(F);
                Nom(F, NomJoueur);
            elsif ClickedButton = "Aide" then 
                CacherFenetre(F);
                Aide(F);
            else
                CacherFenetre(F);   
            end if;
        end;
    end Main;                   

    procedure Jouer (F : in out TR_Fenetre) is
    --{F, Nom, X, Y: Longueur, Largeur de la fenetre} => { ouvre une fenetre de jeu }
    begin
        F := DebutFenetre("Jouer", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Abandonner","ABANDONNER", Fenetre_Size.X/2-50, Button_Size.Y*1, Button_Size.X, Button_Size.Y); -- Abandonner une partie
            AjouterBouton(F,"Restart","RESTART", Fenetre_Size.X/2-50, 10, Button_Size.Y*2, Button_Size.Y); -- Redemarrer une partie
            AjouterBouton(F,"ChangerNom","CHANGER NOM", Fenetre_Size.X/2-50, Button_Size.Y*3, Button_Size.X, Button_Size.Y); -- Changer de nom
        FinFenetre(F);
        MontrerFenetre(F);
         declare 
            ClickedButton : string := AttendreBouton(F);
        begin
            if ClickedButton = "Abandonner" then
               CacherFenetre(F);
            elsif ClickedButton = "Restart" then
                CacherFenetre(F);
            elsif ClickedButton = "ChangerNom" then 
                CacherFenetre(F);
            else
                CacherFenetre(F);   
            end if;     
        end;
    end Jouer;

    procedure Aide(F: in out TR_Fenetre) is 
    --{} => {ouvre une fenetre avec les règles pour aider l'utilisateur}
    begin
        F := DebutFenetre("Aide", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F, "Retour", "RETOUR", 140, 90, 55, 30);

            AjouterTexte(F, "Regles",
                "Vous disposez d'une grille contenant des mines cachées. En cliquant sur une case vous connaissez le nombre de mines se trouvant dans les cases (8 au maximum) qui l'entourent. Le but du jeu est de détecter toutes les mines sans cliquer dessus ",
                Button_Size.X, Button_Size.Y, 100,100 
            );

            AjouterTexte(F, "Controles",
                "Pour Afficher les cases vous devez cliquer gauche sur celle-ci. Pour marquer les cases que vous pensez qu'elles habritent une bombe cliquez droit.", 
                Fenetre_Size.X, Fenetre_Size.Y, 100, 100
            );
        FinFenetre(F);
        MontrerFenetre(F);

        declare
            ClickedButton : string := AttendreBouton(F);
        begin
            if ClickedButton = "Retour" then
                Main(F);
                CacherFenetre(F);
            else 
                CacherFenetre(F);
            end if;
        end;
    end Aide;

    procedure Score (F : in out TR_Fenetre) is 
    --{} => {ouvre une fenetre avec les scores des utilisateurs }
    begin
        F := DebutFenetre("Score", Fenetre_Size.X, Fenetre_Size.Y);
            --ConsulterTimer(F, "Minuteur");
        FinFenetre(F);
        MontrerFenetre(F);
    end Score;
    

    procedure Nom(F: in out TR_Fenetre; NomJoueur: out string) is
    --{} => {Ouvre une fenetre pour initialiser le nom de l'utilisateur }
        DifficulteJoueur : TR_Difficulte;
    begin
        F := DebutFenetre("NomJoueur", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Valider","VALIDER",140,90,55,30);
            AjouterBouton(F,"Annuler","ANNULER",200,90,55,30);
            AjouterChamp(F, "Nom", "Nom","Entrer Nom",160,40,100,30);
        FinFenetre(F);
        MontrerFenetre(F);

        declare 
            ClickedButton : string := AttendreBouton(F);
        begin
            if ClickedButton = "Valider" then
                NomJoueur := ConsulterContenu(F, "Nom");
                CacherFenetre(F);
                Difficulte(F, DifficulteJoueur);
            else
                CacherFenetre(F);
                Main(F); 
            end if;     
        end;
    end Nom;

    procedure Difficulte(F: in out TR_Fenetre; DifficulteJoueur: out TR_Difficulte)  is
    --{} => {ouvre une fenetre pour choisir la difficultée du jeu}
    begin
        F := DebutFenetre("Difficulte", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F, "Facile", "FACILE",140,90,55,30);
            AjouterBouton(F, "Moyen", "MOYEN",140,90,55,30);
            AjouterBouton(F, "Difficile", "DIFFICILE",140,90,55,30);
        FinFenetre(F);
        MontrerFenetre(F);

        declare 
            ClickedButton : string := AttendreBouton(F);
        begin
            if ClickedButton = "Moyen" then
                DifficulteJoueur := D(Moyen);
            elsif ClickedButton = "Difficile" then
                DifficulteJoueur := D(Difficile);
            else 
                DifficulteJoueur := D(Facile);
            end if;
        end;
        CacherFenetre(F);
        Jouer(F);
    end Difficulte;
     
    --procedure GenererGrille(G : in out TV_Grille;  NombreBombe : in Positive )  is 
    --{} => { Initialise l'array pour la grille}
    --begin
        
    --end GenererGrille;
    
end p_vue_graph;
