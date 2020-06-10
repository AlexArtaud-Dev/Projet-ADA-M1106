with p_esiut;use p_esiut;
with forms;use forms;
with p_fenbase;use p_fenbase;

package p_vue_graph is 

    --------------------------------------------------------------------------------------

    type T_Fenetre is (Main, Aide, Score, Jeu);

    type TR_Fenetre is record
        X : Positive;
        Y : Positive;
    end record;

    type TR_Case is record 
        X : Positive;
        Y : Positive;
    end record;

    type TR_Button is record 
        X : Positive;
        Y : Positive;
    end record;

    Fenetre_Size : TR_Fenetre := (500, 700);
    Case_Size : TR_Case := (20, 20);
    Button_Size : TR_Button := (50, 100);

    --------------------------------------------------------------------------------------

    type TR_Difficulte is record
        Colonne : Positive;
        Ligne : Positive;
        NombreBombe : Positive;
    end TR_Difficulte;

    type T_Difficulte is (Facile, Moyen, Difficile);

    type TV_Difficulte is array (T_Difficulte range <>) of TR_Difficulte;

    --------------------------------------------------------------------------------------
    
    function Main return;
    function Score;
    function Aide;
	function InitNom return string;

    procedure CreeFenetreJeu (F : in out TR_Fenetre; Nom : string; X, Y : in Natural);
    procedure GenererGrille(G : in out TV_Grille; NombreBombe, Colone, Ligne : in out Positive);

    --------------------------------------------------------------------------------------
        
end p_vue_graph;