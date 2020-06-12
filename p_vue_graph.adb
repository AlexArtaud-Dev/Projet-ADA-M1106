with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_demineur_modele; use p_demineur_modele;
with ada.calendar;use ada.calendar;

package body p_vue_graph is 


    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Victoire(F: in out TR_Fenetre) is
    --{Victoire}=>{ouvre une fenetre affichant un message de victoire}
    begin
        F:= DebutFenetre("Vict", Fenetre_Size.X, Fenetre_Size.Y);
        AjouterImage(F, "victoireimg","img/victoire.xpm", "  ", 0, 0 ,820,480 );
        AjouterBouton(F,"menu", "RETOUR", 310, 500, 200, 20);
        FinFenetre(F); 
    end F_Victoire;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Defaite(F: in out TR_Fenetre) is
     --{Victoire}=>{ouvre une fenetre affichant un message de victoire}
    begin
        F:= DebutFenetre("Defa", Fenetre_Size.X, Fenetre_Size.Y);
        AjouterImage(F, "defaiteimg","img/defaite.xpm", "  ", 0, 0 ,820,480 );
        AjouterBouton(F,"menu", "RETOUR", 300, 500, 200, 20);
        FinFenetre(F); 
    end F_Defaite;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Main (F: in out TR_Fenetre) is 
    --{}=>{ouvre une fenetre principale avec les différents boutons}
    begin
        F:= DebutFenetre("Main", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Jouer", "JOUER", 273, Button_Size.Y*1+170, Button_Size.X, Button_Size.Y);
            ChangerStyleTexte(F,"Jouer",FL_BOLD_STYLE);
            AjouterBouton(F,"Score", "SCORE", 273, Button_Size.Y*2+180, Button_Size.X, Button_Size.Y);
            ChangerStyleTexte(F,"Score",FL_BOLD_STYLE);
            AjouterBouton(F,"Aide", "AIDE", 273, Button_Size.Y*3+190, Button_Size.X, Button_Size.Y);
            ChangerStyleTexte(F,"Aide",FL_BOLD_STYLE);
            AjouterBouton(F,"Quitter", "QUITTER", 273, Button_Size.Y*4+200, Button_Size.X, Button_Size.Y);
            ChangerStyleTexte(F,"Quitter",FL_BOLD_STYLE);
            AjouterImage(F, "tnt1img","img/tnt1.xpm", "  ", 40, 300 ,200,200 );
            AjouterImage(F, "tnt2img","img/tnt2.xpm", "  ", 580, 300 ,200,200 );
            AjouterImage(F, "demineurimg","img/demineur.xpm", "  ", 68, 20 ,700,150 );
            ChangerCouleurFond(F, "fond", FL_TOP_BCOL);
        FinFenetre(F);  
    end F_Main;                       
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Jouer (F : in out TR_Fenetre; G : in out TV_Grille; Case_Size : in TR_Case_Size) is
    --{F, Nom, X, Y: Longueur, Largeur de la fenetre} => { ouvre une fenetre de jeu }
    countX, countY, test : integer := 0;
    PositionString : String(1..4);
    Heuredebut,Heurefin : Time;
    begin
        Heuredebut := Clock;
        F := DebutFenetre("Jouer", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBouton(F,"Abandonner","ABANDONNER", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*37, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5); 
            AjouterBouton(F,"Restart","RESTART", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*44, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5);
            AjouterBouton(F,"Victoire","VICTOIRE", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*51, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5);
            AjouterBouton(F,"Defaite","DEFAITE", Fenetre_Size.X-((Fenetre_Size.X/100)*17), (Fenetre_Size.Y/100)*58, (Fenetre_Size.X/100)*16, (Fenetre_Size.Y/100)*5);
            ChangerStyleTexte(F,"Abandonner",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Restart",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Victoire",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Defaite",FL_BOLD_STYLE);
            ChangerCouleurFond(F, "fond", FL_TOP_BCOL);

           -- AjouterMinuteur(F,"Clock","",150,350,100,70);   
           -- ChangerStyleTexte(F,"Clock", FL_BOLD_Style);   
           -- ChangerTailleTexte(F,"Clock", FL_medium_size);   
           -- ChangerCouleurFond(F,"Clock",FL_WHITE);   


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
        Heurefin:= Clock;
        ecrire_ligne(ConsulterTimer(F,"Clock"));
    end F_Jouer;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Aide(F: in out TR_Fenetre) is 
    --{} => {ouvre une fenetre avec les règles pour aider l'utilisateur}
    begin
        F := DebutFenetre("Aide", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterBoutonImage(F,"Retour","","img/retourbouton.xpm", 20, 500, 150, 50);
            AjouterImage(F, "aideimg","img/aide.xpm", "  ", 70, 20 ,700,150 );
            AjouterImage(F, "reglesimg","img/regles.xpm", "  ",12, 170 ,900,200 );
            AjouterImage(F, "controleimg","img/controle.xpm", "  ",12, 335 ,675,125);
            ChangerCouleurFond(F, "fond", FL_TOP_BCOL);
        FinFenetre(F);
    end F_Aide;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Score (F : in out TR_Fenetre) is 
    --{} => {ouvre une fenetre avec les scores des utilisateurs }
    begin
        F := DebutFenetre("Score", Fenetre_Size.X, Fenetre_Size.Y);
        AjouterImage(F, "Scoreimg","img/score.xpm", "  ", 70, 20 ,700,150 );
        AjouterBoutonImage(F,"Retour","","img/retourbouton.xpm", 20, 500, 150, 50);
        ChangerCouleurFond(F, "fond", FL_TOP_BCOL);
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
            AjouterImage(F, "Joueurimg","img/joueur.xpm", "  ", 70, 20 ,700,150 );
            AjouterImage(F, "pseudoimg","img/pseudo.xpm", "  ", 50, 160 ,700,150 );        
            AjouterBouton(F,"Valider","VALIDER",285,310,228,30);
            AjouterChamp(F,"Nom","","",285,270,230,30);
            ChangerStyleTexte(F,"Annuler",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Valider",FL_BOLD_STYLE);
            ChangerStyleTexte(F,"Nom",FL_ITALIC_STYLE);
            ChangerCouleurFond(F, "fond", FL_TOP_BCOL);

        FinFenetre(F);
    end F_Nom;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure F_Difficulte(F: in out TR_Fenetre)  is
    --{} => {ouvre une fenetre pour choisir la difficultée du jeu}
    begin
        F := DebutFenetre("Difficulte", Fenetre_Size.X, Fenetre_Size.Y);
            AjouterImage(F, "1","img/difficulte.xpm", "  ", 70, 20 ,700,150 );
            AjouterBouton(F,"Facile", "FACILE", 270, Button_Size.Y*1+160, Button_Size.X, Button_Size.Y);
            ChangerStyleTexte(F,"Facile",FL_BOLD_STYLE);
            AjouterBouton(F,"Moyen", "MOYEN", 270, Button_Size.Y*2+170, Button_Size.X, Button_Size.Y);
            ChangerStyleTexte(F,"Moyen",FL_BOLD_STYLE);
            AjouterBouton(F,"Difficile", "DIFFICILE", 270, Button_Size.Y*3+180, Button_Size.X, Button_Size.Y);
            ChangerStyleTexte(F,"Difficile",FL_BOLD_STYLE);
            ChangerCouleurFond(F, "fond", FL_TOP_BCOL);

        FinFenetre(F);
    end F_Difficulte; 
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure RafraichirGrille(F : in out TR_Fenetre; G : in out TV_Grille; Triche : in boolean ) is
    --{} => {}
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
                            ChangerStyleTexte(F, PositionString, FL_BOLD_STYLE);
                            ChangerTailleContenu(F, PositionString, FL_HUGE_SIZE);
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
    procedure SetEtatBoutton(F: in out TR_Fenetre; G: in out TV_Grille; Etat : in T_EtatBouton ) is
     --{} => {}
        PositionString : string(1..4);
    begin 
        for ligne in G'Range(1) loop
            for colonne in G'Range(2) loop
                PositionString := GetPositionString(G, ligne, colonne);

                ChangerTexte(F, PositionString, "");
                ChangerCouleurTexte(F, PositionString, FL_COL1);
                ChangerCouleurFond(F, PositionString, FL_COL1);

                ChangerEtatBouton(F, PositionString, Etat);
            end loop;
        end loop;
    end SetEtatBoutton;
    
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------ NOUVEAU PACKAGE
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure GetScores(Scores, UserScores : in out TV_Scores; N : in string; Difficulte : in T_Difficulte; Victoire : in boolean; Score : in float) is
    --{} => {}
    begin
        for i in Scores'Range loop
            if Scores(i).Nom = N and Scores(i).Difficulte = Difficulte and Scores(i).Victoire = Victoire then
                UserScores(i).Score := Score;
            end if;
        end loop;
    end GetScores;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure SetScore(f : in p_scores_io.file_type; Score : in TR_Score) is
    --{} => {}
    begin
        
        while 1 = 1 loop
            ecrire_ligne(1);
        end loop;
    end SetScore;

    --Critère : Pour le même joueur : Niveau de dif, temps de la partie, nombre de coups, nombre de pioche.
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure ScoresToArray(f : in p_scores_io.file_type; Scores : out TV_Scores) is
    --{} => {}
        s : TR_Score;
        i : integer := 0;
    begin
        read(f, s);
        while not end_of_file(f) loop
            read(f, s);
            Scores(i) := s;
            i := i+1;
        end loop;
    end ScoresToArray;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    --procedure P_Score(Victoire : in Boolean; Temps : in out Time; Nom : in out String) is
    --{Victoire = true} =>{affiche le temps de l'utilisateur si il a gagné }
       -- NewTemps : Time := Temps;
     --begin
            -- Initialiser les scores au tout début.
           -- if Victoire then 
                --AjouterTexte(F, "txt", "VOS MEILLEURS TEMPS", X, Y, Largeur, Hauteur);--ou image 
                --AjouterTexte(F, "Facile", "", X, Y, Largeur, Hauteur);
                --AjouterTexte(F, "Moyen", "", X, Y, Largeur, Hauteur);
                --AjouterTexte(F, "Difficile", "", X, Y, Largeur, Hauteur);
                --Temps:=ConsulterTimer(F, "Minuteur");
                --ConsulterContenue(F, "Nom");    
               -- declare
				--	Click : string := AttendreBouton(F);
                --begin
                  --  if Click="Reset" then 
                   --     EffacerContenu(F, "Minuteur");
                   -- end if;
               -- end;
               -- if Difficulte = "Facile" and Nom = Nom and NewTemps < Temps then -- Assigner une nouvelle valeur de temps < à la précedente à la difficulté facile et au pseudo correspondant
               --     NewTemps := Temps;
               -- end if;
            
               -- AjouterTexte(F, "Moyen", "", X, Y, Largeur, Hauteur);
               -- if Difficulte = "Moyen" and Nom = Nom and NewTemps < Temps then -- Assigner une nouvelle valeur de temps < à la précedente à la difficulté facile et au pseudo correspondant
               --     NewTemps := Temps;
              --  end if;

               -- AjouterTexte(F, "Difficile", "", X, Y, Largeur, Hauteur);
               -- if Difficulte = "Difficile" and Nom = Nom and NewTemps < Temps then -- Assigner une nouvelle valeur de temps < à la précedente à la difficulté facile et au pseudo correspondant
                --    NewTemps := Temps;
               -- end if;
       -- end if;
    --end P_Score;

    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    procedure GetPosition(NumCase : in string; Colonne, Ligne : in integer ; PosX, PosY: out integer) is
    --{} => {}
    begin  
        PosX := Integer'Value(NumCase(1..2));
        PosY := Integer'Value(NumCase(3..4));
    end GetPosition;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    
    function GetPositionString(G : in TV_Grille; PosX, PosY : in integer) return string is
    --{} => {}
        PositionString : string(1..4);
    begin
        if PosX < 10 and PosY < 10 then
            PositionString := "0" & Integer'Image(PosX)(2..2) & "0" & Integer'Image(PosY)(2..2);
        elsif PosX < 10 then
            PositionString := "0" & Integer'Image(PosX)(2..2) & Integer'Image(PosY)(2..3);
        elsif PosY < 10 then
            PositionString := Integer'Image(PosX)(2..3) & "0" & Integer'Image(PosY)(2..2);
        else
            PositionString := Integer'Image(PosX)(2..3) & Integer'Image(PosY)(2..3);
        end if;
        --ecrire_ligne(PositionString);
        return PositionString;
    end GetPositionString;
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------

end p_vue_graph;