with p_fenbase; use p_fenbase;
with Forms; use Forms;

package body p_vue_graph is 


    procedure F_Main (F: in out TR_Fenetre) is 
    --{}=>{ouvre une fenetre principale avec les différents boutons}
    begin
        F:= DebutFenetre("Main", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Jouer", "JOUER", 273, Button_Size.Y*1+170, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Score", "SCORE", 273, Button_Size.Y*2+180, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Aide", "AIDE", 273, Button_Size.Y*3+190, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Quitter", "QUITTER", 273, Button_Size.Y*4+200, Button_Size.X, Button_Size.Y);
            AjouterImage(F, "tnt1img","tnt2.xpm", "  ", 40, 300 ,200,200 );
            AjouterImage(F, "tnt2img","tnt3.xpm", "  ", 580, 300 ,200,200 );
            AjouterImage(F, "demineurimg","demineur.xpm", "  ", 68, 20 ,700,150 );
            ChangerCouleurFond(F, "fond", FL_RIGHT_BCOL);
        FinFenetre(F);
       
    end F_Main;                       

    procedure F_Jouer (F : in out TR_Fenetre) is
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
    end F_Jouer;

    procedure F_Aide(F: in out TR_Fenetre) is 
    --{} => {ouvre une fenetre avec les règles pour aider l'utilisateur}
    begin
        F := DebutFenetre("Aide", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBoutonImage(F,"Retour","","retourbouton.xpm", 20, 500, 150, 50);
            AjouterImage(F, "aideimg","aide.xpm", "  ", 70, 20 ,700,150 );
            AjouterImage(F, "reglesimg","regles.xpm", "  ",12, 170 ,900,200 );
            AjouterImage(F, "controleimg","controle.xpm", "  ",12, 335 ,900,200 );
        FinFenetre(F);
      
    end F_Aide;

    procedure F_Score (F : in out TR_Fenetre) is 
    --{} => {ouvre une fenetre avec les scores des utilisateurs }
    begin
        F := DebutFenetre("Score", Fenetre_Size.X, Fenetre_Size.Y);
        AjouterImage(F, "Scoreimg","score.xpm", "  ", 70, 20 ,700,150 );
        
             AjouterBoutonImage(F,"Retour","","retourbouton.xpm", 20, 500, 150, 50);
            --ConsulterTimer(F, "Minuteur");
        FinFenetre(F);
    end F_Score;  

    procedure F_Nom(F: in out TR_Fenetre) is
    --{} => {Ouvre une fenetre pour initialiser le nom de l'utilisateur }
    begin
        F := DebutFenetre("Nom", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterImage(F, "Joueurimg","joueur.xpm", "  ", 70, 20 ,700,150 );
            AjouterImage(F, "pseudoimg","pseudo.xpm", "  ", 50, 160 ,700,150 );        
            AjouterBouton(F,"Valider","VALIDER",285,310,228,30);
            AjouterChamp(F,"Nom","Entrer Nom","",285,270,230,30);
            ChangerStyleTexte(F,"Annuler",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Valider",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Nom",FL_ITALIC_STYLE);
        FinFenetre(F);
    end F_Nom;

    procedure F_Difficulte(F: in out TR_Fenetre)  is
    --{} => {ouvre une fenetre pour choisir la difficultée du jeu}
    begin
        F := DebutFenetre("Difficulte", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterImage(F, "1","difficulte.xpm", "  ", 70, 20 ,700,150 );
            AjouterBouton(F,"Facile", "FACILE", 270, Button_Size.Y*1+160, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Moyen", "MOYEN", 270, Button_Size.Y*2+170, Button_Size.X, Button_Size.Y);
            AjouterBouton(F,"Difficile", "DIFFICILE", 270, Button_Size.Y*3+180, Button_Size.X, Button_Size.Y);
            AjouterBoutonImage(F,"Retour","","retourbouton.xpm", 20, 500, 150, 50);
        FinFenetre(F);
    end F_Difficulte;
     


  

end p_vue_graph;