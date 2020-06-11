with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_demineur_modele; use p_demineur_modele;
with ada.calendar;use ada.calendar;

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
            ChangerCouleurFond(F, "fond", FL_WHITE);
        FinFenetre(F);
       
    end F_Main;                       

    procedure F_Jouer (F : in out TR_Fenetre; G : in out TV_Grille; Case_Size : in TR_Case_Size) is
    --{F, Nom, X, Y: Longueur, Largeur de la fenetre} => { ouvre une fenetre de jeu }
    countX, countY : integer := 0;
    nom : String(1..4);
    
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
                if ligne < G'Length(1)+1 and colonne< G'Length(2)+1 then
                        nom := "0" & Integer'Image(ligne)(2..2) & "0" & Integer'Image(colonne)(2..2);
                    elsif ligne < G'Length(1)+1 then
                        nom := "0" & Integer'Image(ligne)(2..2) & Image(colonne)(2..3);
                    elsif colonne < G'Length(2)+1 then
                        nom := Integer'Image(ligne)(2..3) & "0" & Integer'Image(colonne)(2..2);
                    else
                        nom := Integer'Image(ligne)(2..3) & Integer'Image(colonne)(2..3);
                end if;
                AjouterBouton(F, nom, "", Case_Size.X+countX, Case_Size.Y+countY, Case_Size.X, Case_Size.Y);
                countX := countX+Case_Size.X;
            end loop;
            countX := 0;
            countY := countY+Case_Size.Y;
        end loop;
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
        AjouterImage(F, "case1","Case1.xpm", "  ", 70, 20 ,50,50 );
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
       
    procedure GetPosition(NumCase : in string; Colonne, Ligne : in integer ; PosX, PosY: out integer) is
    begin  
        PosX := Integer'Value(NumCase(1..2));
        PosY := Integer'Value(NumCase(3..4));
    end GetPosition;
    

    procedure RafraichirGrille(F : in out TR_Fenetre; G : in out TV_Grille; Triche : in boolean ) is
        nom : String(1..4);
        C : TR_Case;
        Arround : integer;
        Case_Couleur : T_Couleur;
    begin
        for ligne in G'Range(1) loop
            for colonne in G'Range(2) loop
                if ligne < G'Length(1)+1 and colonne< G'Length(2)+1 then
                        nom := "0" & Integer'Image(ligne)(2..2) & "0" & Integer'Image(colonne)(2..2);
                elsif ligne < G'Length(1)+1 then
                        nom := "0" & Integer'Image(ligne)(2..2) & Image(colonne)(2..3);
                elsif colonne < G'Length(2)+1 then
                        nom := Integer'Image(ligne)(2..3) & "0" & Integer'Image(colonne)(2..2);
                else
                        nom := Integer'Image(ligne)(2..3) & Integer'Image(colonne)(2..3);
                end if;
                
                C := G(ligne, colonne);
                if Triche and C.Occupee then
                    ChangerCouleurFond(F, nom, FL_DARKORANGE);
                    ChangerTexte(F, nom, "B");
                    ChangerEtatBouton(F, nom, arret); 
                else 
                    if (C.Occupee= false and (C.Etat = decouverte or Triche)) then
                        if (NombreMineAutour(G, ligne, colonne) > 0) then 
                        
                            Arround := NombreMineAutour(G, ligne, colonne);

                            case Arround is
                                when 1 => Case_Couleur := FL_BLUE;
                                when 2 => Case_Couleur := FL_;
                                when 3 => Case_Couleur := ;
                                when 4 => Case_Couleur := ;
                                when 5 => Case_Couleur := ;
                                when 6 => Case_Couleur := ;
                                when 7 => Case_Couleur := ;
                                when 8 => Case_Couleur := ;
                                when others =>  Case_Couleur := FL_COL1
                            end case;

                            ChangerTexte(F, nom,  Integer'Image(Arround));
                            ChangerCouleurFond(F, nom, Case_Couleur);
                        else
                            ChangerCouleurFond(F, nom, FL_BOTTOM_BCOL);
                        end if;
                        ChangerEtatBouton(F, nom, arret);
                    elsif (C.Etat = marquee) then
                        ChangerCouleurFond(F, nom, FL_DARKGOLD);
                    else
                        ChangerCouleurFond(F, nom, FL_COL1); -- Case non dévoilée
                    end if;
                end if;
            end loop;
        end loop;
    end RafraichirGrille;


end p_vue_graph;