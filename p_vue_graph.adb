with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_demineur_modele; use p_demineur_modele;
with ada.calendar;use ada.calendar;

package body p_vue_graph is 


    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
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
            ChangerCouleurFond(F, "fond", FL_WHITE);
        FinFenetre(F);
       
    end F_Main;                       
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Jouer (F : in out TR_Fenetre; G : in out TV_Grille; Case_Size : in TR_Case_Size) is
    --{F, Nom, X, Y: Longueur, Largeur de la fenetre} => { ouvre une fenetre de jeu }
    countX, countY : integer := 0;
    PositionString : String(1..4);
    begin
        F := DebutFenetre("Jouer", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Abandonner","ABANDONNER", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*37, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5); 
            AjouterBouton(F,"Restart","RESTART", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*44, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5);
            ChangerStyleTexte(F,"Abandonner",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Restart",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"ChangerNom",FL_BOLD_STYLE);
            AjouterChrono(F, "Chronometre", "Votre temps", Fenetre_Size.X-((Fenetre_Size.X/100)*17), ((Fenetre_Size.Y/100)*15), ((Fenetre_Size.X/100)*16), ((Fenetre_Size.Y/100)*5));								
                                                                                                    
        for ligne in G'Range(1) loop
            for colonne in G'Range(2) loop
                PositionString := GetPositionString(G, ligne, colonne); 
                AjouterBouton(F, PositionString, "", Case_Size.X+countX, Case_Size.Y+countY, Case_Size.X, Case_Size.Y);
                countX := countX+Case_Size.X;
            end loop;
            countX := 0;
            countY := countY+Case_Size.Y;
        end loop;
        FinFenetre(F);
    end F_Jouer;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
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
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Score (F : in out TR_Fenetre) is 
    --{} => {ouvre une fenetre avec les scores des utilisateurs }
    begin
        F := DebutFenetre("Score", Fenetre_Size.X, Fenetre_Size.Y);
        AjouterImage(F, "Scoreimg","score.xpm", "  ", 70, 20 ,700,150 );
        AjouterImage(F, "case1","Case1.xpm", "  ", 70, 20 ,50,50 );
        AjouterBoutonImage(F,"Retour","","retourbouton.xpm", 20, 500, 150, 50);
            --ConsulterTimer(F, "Minuteur");
        FinFenetre(F);
    end F_Score;  
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
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
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
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
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure RafraichirGrille(F : in out TR_Fenetre; G : in out TV_Grille; Triche : in boolean ) is
        C : TR_Case;
        Arround : integer;
        Texte_Couleur : T_Couleur;
        PositionString : string(1..4);
    begin
        for ligne in G'Range(1) loop
            for colonne in G'Range(2) loop
                PositionString := GetPositionString(G, ligne, colonne);                
                
                C := G(ligne, colonne);
                if Triche and C.Occupee then
                    ChangerCouleurFond(F, PositionString, FL_RED);
                    ChangerTexte(F, PositionString, "B");
                    ChangerEtatBouton(F, PositionString, arret); 
                else 
                    if (C.Occupee= false and (C.Etat = decouverte or Triche)) then
                        if (NombreMineAutour(G, ligne, colonne) > 0) then 
                            Arround := NombreMineAutour(G, ligne, colonne);
                            case Arround is
                                when 1 => Texte_Couleur := FL_DODGERBLUE;
                                when 2 => Texte_Couleur := FL_CHARTREUSE;
                                when 3 => Texte_Couleur := FL_TOMATO;
                                when 4 => Texte_Couleur := FL_SLATEBLUE;
                                when 5 => Texte_Couleur := FL_DARKTOMATO;
                                when 6 => Texte_Couleur := FL_PALEGREEN;
                                when 7 => Texte_Couleur := FL_RIGHT_BCOL;
                                when 8 => Texte_Couleur := FL_MCOL;
                                when others => Texte_Couleur := FL_COL1;
                            end case;
                            ChangerCouleurTexte(F, PositionString,  Texte_Couleur);
                            ChangerTexte(F, PositionString, Integer'Image(Arround)); --Affiche les chiffres
                        else
                            ChangerCouleurFond(F, PositionString, FL_BOTTOM_BCOL);
                        end if;
                        ChangerEtatBouton(F, PositionString, arret);
                    elsif (C.Etat = marquee) then
                        ChangerCouleurFond(F, PositionString, FL_DARKGOLD); --Case marquée
                    else
                        ChangerCouleurFond(F, PositionString, FL_COL1); -- Case non dévoilée
                    end if;
                end if;
            end loop;
        end loop;
    end RafraichirGrille;


    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------




    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure GetPosition(NumCase : in string; Colonne, Ligne : in integer ; PosX, PosY: out integer) is
    begin  
        PosX := Integer'Value(NumCase(1..2));
        PosY := Integer'Value(NumCase(3..4));
    end GetPosition;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    function GetPositionString(G : in out TV_Grille; PosX, PosY : in integer) return string is
        PositionString : string(1..4);
    begin
        if PosX < G'Length(1)+1 and PosY< G'Length(2)+1 then
            PositionString := "0" & Integer'Image(PosX)(2..2) & "0" & Integer'Image(PosY)(2..2);
        elsif PosX < G'Length(1)+1 then
            PositionString := "0" & Integer'Image(PosX)(2..2) & Image(PosY)(2..3);
        elsif PosY < G'Length(2)+1 then
            PositionString := Integer'Image(PosX)(2..3) & "0" & Integer'Image(PosY)(2..2);
        else
            PositionString := Integer'Image(PosX)(2..3) & Integer'Image(PosY)(2..3);
        end if;
        return PositionString;
    end GetPositionString;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------

end p_vue_graph;