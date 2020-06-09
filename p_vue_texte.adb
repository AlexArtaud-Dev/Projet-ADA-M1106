with text_io; use text_io;
with p_esiut; use p_esiut;
with p_demineur_modele; use p_demineur_modele;

package body p_vue_texte is 

-------------------------------------------------------------------------------------------------------------------------------

    procedure Affiche(G : in out TV_Grille; Triche : in boolean) is
        --{} => {Affiche la grille de jeu}
        C : TR_Case;
    begin 
        -- Libre => pas de bombe
        -- Vide => rien autour (verticale, horizontale, diagonale) 
        for ligne in G'Range(1) loop
            for colonne in G'Range(2) loop
                C := G(ligne, colonne);
                if (C.Etat /= decouverte) then
                    ecrire(" * ");
                elsif (C.Occupee= false and C.Etat = decouverte) then
                    if (NombreMinesAutour(G, ligne, colonne) > 0) then ecrire(NombreMinesAutour(G, ligne, colonne));
                    else
                        ecrire(" . ");
                    end if;
               elsif (C.Etat = marquee) then
                    ecrire(" M ");
               elsif (C.Occupee and Triche) then
                    ecrire(" K "); -- If triche is true then we want to see the bombs 1.2 3
               else 
                    ecrire(" * "); -- If triche est false nous ne permet pas aux utilisateurs de voir les bombes
               end if; 
            end loop;
        end loop;
    end Affiche;

---------------------------------------------------------------------------------------------------------------------------------------------

    procedure Saisie(L, C : in out positive ; G : in TV_Grille) is
        --{}=> {Permet la saisie par l'utilisateur d'une colonne et d'une ligne}
    begin
        loop
              ecrire("Donner le numéro de la colonne souhaitée :"); lire(C);
              if C > G'Last(2) or C < 1 
              then ecrire("Le n° de la ligne ne peut être <  à 1 et >  à " & image(G'last(1))); --Vérification que le numéro de la colonne soit dans l'intervalle
              end if;
              exit when C <= G'last(2) and C > 0;
        end loop;
        loop
              ecrire("Donner le numéro de la ligne souhaitée :"); lire(L);
              if L > G'Last(1) or L < 1 
              then ecrire("Le n° de la ligne ne peut être <  à 1 et >  à " & image(G'last(1))); --Vérification que le numéro de la ligne soit dans l'intervalle
              end if;
            exit when L <= G'last(1) and L > 0;
        end loop;
    end Saisie;

end p_vue_texte;


