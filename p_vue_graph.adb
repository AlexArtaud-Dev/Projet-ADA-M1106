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
            AjouterImage(F, "tnt1xpm","tnt2.xpm", "  ", 40, 300 ,200,200 );
            AjouterImage(F, "tnt2xpm","tnt3.xpm", "  ", 580, 300 ,200,200 );
            AjouterImage(F, "demineur","demineur.xpm", "  ", 68, 20 ,700,150 );
            --ChangerCouleurFond(F, "Score", FL_TOMATO);
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
            AjouterBouton(F,"Abandonner","ABANDONNER", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*37, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5); 
            AjouterBouton(F,"Restart","RESTART", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*44, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5); -- Redemarrer une partie
            AjouterBouton(F,"ChangerNom","CHANGER NOM", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*60, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5); -- Changer de nom
            ChangerStyleTexte(F,"Abandonner",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Restart",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"ChangerNom",FL_BOLD_STYLE);
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
            AjouterBoutonImage(F,"Retour","","retourbouton.xpm", 20, 500, 150, 50);--C'est Ilyes qui la trouvé
            AjouterImage(F, "aide","aide.xpm", "  ", 70, 20 ,700,150 );
            AjouterImage(F, "regles","regles.xpm", "  ",12, 170 ,900,200 );
            AjouterImage(F, "controle","controle.xpm", "  ",12, 335 ,900,200 );
        FinFenetre(F);
        MontrerFenetre(F);

        declare
            ClickedButton : string := AttendreBouton(F);
        begin
            if ClickedButton = "Retour" then
                CacherFenetre(F);
                Main(F);
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
            AjouterImage(F, "Joueur","joueur.xpm", "  ", 70, 20 ,700,150 );
            AjouterImage(F, "pseudo","pseudo.xpm", "  ", 50, 160 ,700,150 );
            AjouterBouton(F,"Annuler","ANNULER",285,310,114,30);           
            AjouterBouton(F,"Valider","VALIDER",400,310,114,30);
            AjouterChamp(F, "Nom","","Entrer Nom",285,270,230,30);
            ChangerStyleTexte(F,"Annuler",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Valider",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Nom",FL_ITALIC_STYLE);
        FinFenetre(F);
        MontrerFenetre(F);

        declare 
            ClickedButton : string := AttendreBouton(F);
        begin
            if ClickedButton = "Valider" then --A FIX, ne passe pas à difficulté quand un pseudo est renseigné
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
            AjouterImage(F, "Difficulte","difficulte.xpm", "  ", 70, 20 ,700,150 );
            AjouterBouton(F,"Facile", "FACILE", 270, Button_Size.Y*1+160, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Moyen", "MOYEN", 270, Button_Size.Y*2+170, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Difficile", "DIFFICILE", 270, Button_Size.Y*3+180, Button_Size.X, Button_Size.Y);
            
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
