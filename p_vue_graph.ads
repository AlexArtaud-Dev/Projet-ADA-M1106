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
    Button_Size : TR_Button_Size := (280, 70);--Largeur,Hauteur des boutons

    --------------------------------------------------------------------------------------

    type TR_Difficulte is record
        Colonne : Positive;
        Ligne : Positive;
        NombreBombe : Positive;
        CaseSize : TR_Case_Size;
    end record;

    type T_Difficulte is (Facile, Moyen, Difficile);

    type TV_Difficulte is array (T_Difficulte range <>) of TR_Difficulte;

    D : TV_Difficulte := ( Facile => (9, 9, 10, (50, 50)), Moyen => (16, 16, 40, (32, 32)), Difficile => (16, 30, 99, (20, 20)));

    --------------------------------------------------------------------------------------
    
    procedure F_Main (F : in out TR_Fenetre);

    procedure F_Score (F : in out TR_Fenetre);

    procedure F_Aide (F : in out TR_Fenetre);

    procedure F_Nom(F: in out TR_Fenetre);

    procedure F_Difficulte(F: in out TR_Fenetre);

    procedure F_Jouer(F : in out TR_Fenetre; G : in out TV_Grille; Case_Size : in TR_Case_Size);

    procedure RafraichirGrille(F : in out TR_Fenetre; G : in out TV_Grille; Triche : in boolean);

    procedure GetPosition(NumCase : in string; Colonne, Ligne : in integer ;PosX, PosY: out integer);

    function GetPositionString(G : in out TV_Grille; PosX, PosY : in integer) return string;

    --------------------------------------------------------------------------------------
      
end p_vue_graph;