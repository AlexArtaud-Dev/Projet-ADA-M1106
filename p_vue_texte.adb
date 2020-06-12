with text_io; use text_io;
with p_esiut; use p_esiut;
with p_demineur_modele; use p_demineur_modele;

package body p_vue_texte is 

    -------------------------------------------------------------------------------------------------------------------------------

    procedure Affiche(G : in out TV_Grille; Triche : in boolean) is
        --{G, Triche} => {Affiche la grille de jeu. Si Triche est true on devoile les cases}
        C : TR_Case;
        i : integer := 1;
        s : integer := 0;
    begin 
        -- Libre => pas de bombe
        -- Vide => rien autour (verticale, horizontale, diagonale)
        -- k  => bombe
        -- . => case découverte
        -- * => case couverte
        -- m => case marquée
        ecrire(" +");
        for coln in G'Range(2) loop
            ecrire(" -");
        end loop;
        ecrire(" +");
        a_la_ligne;
        for ligne in G'Range(1) loop
             ecrire(" |");
            for colonne in G'Range(2) loop
                C := G(ligne, colonne);
                if Triche and C.Occupee then
                    ecrire(" k");
                else 
                    if (C.Occupee= false and (C.Etat = decouverte or Triche)) then
                        if (NombreMineAutour(G, ligne, colonne) > 0) then 
                            ecrire(NombreMineAutour(G, ligne, colonne));
                        else
                            ecrire(" .");
                        end if;
                    elsif (C.Etat = marquee) then
                        ecrire(" m");
                    else
                        ecrire(" *");
                    end if;
                end if;
            end loop;
            ecrire(" |"); ecrire(ligne);--décors
            a_la_ligne;
        end loop;
        ecrire(" +");
        for coln in G'Range(2) loop
            ecrire(" -");
        end loop;
        ecrire(" +");
        a_la_ligne;
    end Affiche;

    ---------------------------------------------------------------------------------------------------------------------------------------------

    procedure Saisie(L, C : in out positive ; G : in TV_Grille) is
        --{L, C, G}=> {Permet la saisie par l'utilisateur d'une colonne et d'une ligne}
    begin
        loop
        a_la_ligne;
              ecrire_ligne("Donnez le numero de la colonne souhaitee :"); lire(C);
              if G'Last(2) < C or 1 > C 
              then ecrire_ligne("Le chiffre fourni est invalide");
              end if;
              exit when G'last(2) >= C   and 0 < C;
        end loop;
        loop
              ecrire_ligne("Donnez le numero de la ligne souhaitee :"); lire(L);
              if G'Last(1) < L  or 1 > L 
              then ecrire_ligne("Le chiffre fourni est invalid");
              end if;
            exit when G'last(1) >= L and 0 < L;
        end loop;
    end Saisie;

end p_vue_texte;


