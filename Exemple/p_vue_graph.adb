with p_fenbase ; use p_fenbase ;
with Forms ; use Forms;
with p_esiut, p_vuetxt, p_virus; use p_esiut, p_vuetxt, p_virus;

package body p_vue_graph is

    boutonConfig : String(1..2);

    -- choix du nom 
    procedure fenChoixNom (fen : in out TR_fenetre) is

    begin
    fen := DebutFenetre("NomJoueur", 400, 130);
        AjouterBouton(fen,"BoutonValider","valider",140,90,55,30);
        AjouterBouton(fen,"BoutonAnnuler","annuler",200,90,55,30);
        AjouterChamp(fen, "Le_pseudo","Pseudo","",160,40,100,30); 
    FinFenetre(fen);


    end fenChoixNom;
   
    -- choix de la configuration 
    procedure fenChoixConfig (fen : in out TR_fenetre) is 

    begin 
        fen := DebutFenetre("choix_config", 500, 200);
            AjouterBouton(fen,"BoutonValider","valider",195,20,55,30);
            AjouterBouton(fen,"BoutonAnnuler","annuler",255,20,55,30);

            for I in 1..2 loop
                for J in 1..10 loop
                        boutonConfig := Integer'Image(I)(2..2) & Integer'Image(J)(2..2);
                        AjouterBoutonRadio(fen,boutonConfig,integer'image((i-1)*3+J),(J-1)*50+50, (I-1)*50+90,20,True);
                end loop;
            end loop;

        FinFenetre(fen);

    end fenChoixConfig;

    -- choix de la configuration
    procedure fenJeu (fen : in out TR_fenetre) is
        grille : TV_Grille;
        piece : TV_Pieces;
        f :p_piece_io.File_Type;
        str : String(1..2);
        nb : Integer;

    begin 
        str := consulterContenu(fen, boutonConfig);
        nb := integer'value(str);

        fen := DebutFenetre("jeu", 1000,900);
        
            InitPartie(grille, piece);
            Open(f, In_File, "Parties");
            Configurer(f, nb, Grille, piece);
            Close(f);

            -- initialisation de la grille 
            for i in grille'Range(1) loop
                for j in grille'Range(2) loop

                    if i mod 2 /= 0 and T_Col'pos(j) /= 0 then 
                        AjouterBouton(fen,"","",400,200,40,40,FL_TOUCH_BUTTON);
                    elsif i mod 2 = 0 and T_Col'pos(j) = 0 then
                        AjouterBouton(fen,"","",400,200,40,40,FL_TOUCH_BUTTON);
                    end if;

                end loop;
            end loop;

        FinFenetre(fen);

   end fenJeu;

end p_vue_graph;