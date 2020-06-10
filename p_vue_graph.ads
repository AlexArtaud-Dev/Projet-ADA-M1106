with p_esiut;use p_esiut;
with forms;use forms;
with p_demineur_modele; use p_demineur_modele;
with p_fenbase;use p_fenbase;

package p_vue_graph is 

    --------------------------------------------------------------------------------------

    type T_Fenetre is (Main, Aide, Score, Jeu);

    type TR_Fenetre_Size is record
        X : Positive;
        Y : Positive;
    end record;

    type TR_Case_Size is record 
        X : Positive;
        Y : Positive;
    end record;

    type TR_Button_Size is record 
        X : Positive;
        Y : Positive;
    end record;

    Fenetre_Size : TR_Fenetre_Size := (820, 580);--résolution fenetre
    Case_Size : TR_Case_Size := (20, 20);
    Button_Size : TR_Button_Size := (280, 70);--Largeur,Hauteur des boutons

    --------------------------------------------------------------------------------------

    type TR_Difficulte is record
        Colonne : Positive;
        Ligne : Positive;
        NombreBombe : Positive;
    end record;

    type T_Difficulte is (Facile, Moyen, Difficile);

    type TV_Difficulte is array (T_Difficulte range <>) of TR_Difficulte;

    D : TV_Difficulte := ( Facile => (9, 9, 10), Moyen => (16, 16, 40), Difficile => (16, 30, 99) );

    --------------------------------------------------------------------------------------
    
    procedure Main (F : in out TR_Fenetre);

    procedure Score (F : in out TR_Fenetre);

    procedure Aide (F : in out TR_Fenetre);

    procedure Nom(F: in out TR_Fenetre; NomJoueur: out string);

    procedure Difficulte(F: in out TR_Fenetre; DifficulteJoueur: out TR_Difficulte);

    procedure Jouer(F : in out TR_Fenetre);

    --procedure GenererGrille(G : in out TV_Grille; NombreBombe : in out Positive);

    --------------------------------------------------------------------------------------
        
end p_vue_graph;