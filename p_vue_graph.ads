---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--************************************ COPYRIGHT 2020 - Artaud Alexandre ************************************--
--******************** Toute copie de ce fichier doit se faire en citant son auteur *************************--
--************************************ Date de création : 12/06/2020 ****************************************--
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




with p_esiut;use p_esiut;
with forms;use forms;
with p_demineur_modele; use p_demineur_modele;
with p_fenbase;use p_fenbase;
with text_io;use text_io;
with sequential_io;

package p_vue_graph is 

    type T_Fenetre is (Main, Aide, Score, Jeu);

    type TR_Fenetre_Size is record
        X : Positive;
        Y : Positive;
    end record;

     type TR_Barre_Pos is record
        X : Positive;
        Y : Positive;
    end record;

    type TR_Boutton_Jeu is record
        X : Positive;
        Y : Positive;
    end record;

    type TR_Nb_Flag is record
        X : Positive;
        Y : Positive;
    end record;

    type TR_Affichage_Temps is record
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

    Affichage_Temps_Pos : TR_Affichage_Temps := (640,30);
    Nb_Flag_Pos : TR_Nb_Flag := (640,160);
    Boutton_Size_Jeu : TR_Boutton_Jeu := (640,300);
    Barre_Size : TR_Barre_Pos := (600,1);
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

    type TR_Score is record
        Nom : string(1..20) := (others => ' ');
        Score : float;
        Victoire : boolean;
        Difficulte : T_Difficulte;
    end record;
        
	package p_scores_io is new sequential_io(TR_Score); use p_scores_io;

    type TV_Scores is array (integer range <>) of TR_Score;

    --------------------------------------------------------------------------------------

    procedure F_Main (F : in out TR_Fenetre);
    --{F}=>{ Ouvre une fenetre affichant un message de victoire}

    procedure F_Score (F : in out TR_Fenetre);
    --{F} => { Ouvre une fenetre avec les scores des utilisateurs}

    procedure F_Aide (F : in out TR_Fenetre);
    --{F} => { Ouvre une fenetre avec les règles pour aider l'utilisateur}

    procedure F_Nom(F : in out TR_Fenetre);
    --{F} => { Ouvre une fenetre pour initialiser le nom de l'utilisateur}

    procedure F_Difficulte(F : in out TR_Fenetre);
    --{F} => {ouvre une fenetre pour choisir la difficultée du jeu}

    procedure F_Victoire(F : in out TR_Fenetre);
    --{F}=>{ Ouvre une fenetre affichant un message de victoire}

    procedure F_Defaite(F : in out TR_Fenetre);
    --{F}=>{ Ouvre la fenetre affichant un message de defaite}

    procedure F_Jouer(F : in out TR_Fenetre; G : in out TV_Grille; Case_Size : in TR_Case_Size; NombreBombe : in Positive);
    --{F, G, Case_Size, NombreBombe } => { Ouvre la fenetre de jeu }

    procedure RafraichirGrille(F : in out TR_Fenetre; G : in out TV_Grille; Triche : in boolean);
    --{F, G, Triche} => {Rafrachie la grille. Si triche est true on revele la grille}

    --------------------------------------------------------------------------------------

    --------------------------------------------------------------------------------------

    procedure SetEtatBoutton(F: in out TR_Fenetre; G: in out TV_Grille; Etat : in T_EtatBouton);
    --{F, G, Etat} => {Definit l'etat d'un bouton ainsi que son style}

    procedure GetPosition(NumCase : in string; PosX, PosY: out integer);
    --{NumCase, PosX, PosY} => { Permet de recuperer la position X et Y d'un bouton grace a son nom}

    function GetPositionString(G : in TV_Grille; PosX, PosY : in integer) return string;
    --{G, PosX, PosY} => { Permet de definir le nom d'un bouton}
    --------------------------------------------------------------------------------------

    procedure GetScores(Scores, UserScores : in out TV_Scores; N : in string; Difficulte : in T_Difficulte; Victoire : in boolean; Score : in float);
    --{Scores, UserScores, N, Difficulte, Victoire, Score} => { Permet de recuperer les score en fonction de differents filtres}

    procedure ScoresToArray(f : in p_scores_io.file_type; Scores : out TV_Scores);
    --{} => {Transferer les scores du fichier dans un array}

    procedure SetScore(f : in p_scores_io.file_type; Score : in TR_Score);
    --{f} => {Ecrire dans un fichier binaire les scores}

    --------------------------------------------------------------------------------------
    
end p_vue_graph;