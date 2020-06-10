with p_esiut;use p_esiut;
with forms;use forms;
with p_fenbase;use p_fenbase;

package p_vue_graph is 

    --------------------------------------------------------------------------------------

    type TR_Fenetre is record 
        X : Positive;
        Y : Positive;
    end TR_Fenetre;

    type TR_Case is record 
        X : Positive;
        Y : Positive;
    end TR_Case;

    type TR_Button is record 
        X : Positive;
        Y : Positive;
    end TR_Button;

    --------------------------------------------------------------------------------------

    type TR_Difficulte is record
        Colonne : Positive;
        Ligne : Positive;
        NombreBombe : Positive;
    end TR_Difficulte;

    type T_Difficulte is (Facile, Moyen, Difficile);

    type TV_Difficulte is array (T_Difficulte range <>) of TR_Difficulte;

    --------------------------------------------------------------------------------------
    
	function InitNom return string;
    procedure CreeFenetreJeu (F : in out TR_Fenetre; Nom : string; X, Y : in Natural);
    procedure InitGrille(G : in out TV_Grille; NombreBombe, Colone, Ligne : in out Positive);

    --------------------------------------------------------------------------------------
        
end p_vue_graph;