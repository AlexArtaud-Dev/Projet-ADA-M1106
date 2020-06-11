with p_virus, text_io, p_esiut; use p_virus, text_io, p_esiut;

package body p_vuetxt is

    procedure InitGrille(GrilleVide : in out TV_Grille) is
      package p_int_io is new Integer_IO(Integer); use p_int_io; 	
      
    begin
        Put("initialisation de la Grille vide"); New_Line; New_Line; 

        Put_Line("    A B C D E F G");
        Put_Line("  S - - - - - - -");

        for i in GrilleVide'range(1) loop
            
            Put(i,1); Put(" |");
            for j in GrilleVide'range(2) loop
                if i mod 2 /= 0 and T_Col'Pos(j) mod 2 /= 0 then  
                    GrilleVide(i,j) := vide;
                    Put(" . "); Put(' '); 
                elsif i mod 2 = 0 and T_col'Pos(j) mod 2 = 0 then
                    GrilleVide(i,j) := vide;
                    Put(' '); Put("  .");
                else
                     GrilleVide(i,j) := vide;
                end if;
            end loop;
            New_Line;

        end loop;

    end InitGrille;

    procedure ConfigGrille(f : in out p_piece_io.File_Type; nbConfig : in Integer;
                            GrilleInit : in out TV_Grille) is
        element : TR_ElemP;

    begin 
        -- vérification de la fin du fichier 
        if not End_Of_File(f) then 


            -- tant que la configuration n'a pas été atteinte on lit les éléments
            for k in 1..nbConfig-1 loop 
               
               Read(f, element);

                --tant que couleur différent de rouge on lit les éléments
                while element.couleur /= rouge loop
                    Read(f, element);
                end loop;

            Read(f, element);
            -- on a atteint la configuration demandée
            end loop;

            Read(f, element);

            -- maintenant que l'on a atteint la configuration on lit les couleurs 
            while element.couleur /= rouge loop
                GrilleInit(element.ligne, element.colonne) := element.couleur;
                Read(f, element);                
            end loop;

            -- la Grille prends les couleurs des cases 
			GrilleInit(element.ligne, element.colonne) := element.couleur;

            	-- on lit les élément rouge
				Read(f, element);
				GrilleInit(element.ligne, element.colonne) := element.couleur;

        else 
            Put("la fin du fichier est atteintes");

        end if; 

    end ConfigGrille;

    procedure AfficheGrille(Grille : in TV_Grille) is
        package p_int_io is new Integer_IO(Integer); use p_int_io; 

    begin
        -- on écrit les paramètre de base 
        Put_Line("    A B C D E F G");
        Put_Line("  S - - - - - - -");

        for i in Grille'range(1) loop
            
            Put(i,1); Put(" |");
            for j in Grille'range(2) loop

                if i mod 2 /= 0 and T_Col'Pos(j) mod 2 /= 0 then  
                    
                    -- test des couleurs
                    if Grille(i,j) /= rouge and Grille(i,j) /= vide and Grille(i,j) /= blanc then
                          Put(" "); Put(T_Coul'Pos(Grille(i,j)),1); Put("  ");

                    -- couleur rouge
                    elsif Grille(i,j) = rouge then
                    Put(" 0 "); Put(' ');                  

                    -- couleur vide  
                    elsif Grille(i,j) = blanc then
                            Put(" F "); Put(' '); 
                    
                    -- sans couleur
                    elsif Grille(i,j) = vide then
                        Put(" . "); Put(' ');

                    end if; 

                elsif i mod 2 = 0 and T_col'Pos(j) mod 2 = 0 then  

                    -- test des couleurs 
                    if Grille(i,j) /= rouge and Grille(i,j) /= vide and Grille(i,j) /= blanc then
                          put("   "); Put(T_Coul'Pos(Grille(i,j)),1);
                    
                    -- couleur rouge
                    elsif GRille(i,j) = rouge then
                        Put("   "); Put("0");

                  -- couleur blanche  
                    elsif  Grille(i,j) = blanc then 
                        Put("   "); Put("F"); 
                    
                    -- sans couleur 
                    elsif  Grille(i,j) = vide then
                        Put("   "); Put("."); 
                        
                    end if; 
                end if;
                
                   
 
            end loop;
            New_Line;

        end loop;
    end AfficheGrille;


end p_vuetxt;