---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--************************************ COPYRIGHT 2020 - Artaud Alexandre ************************************--
--******************** Toute copie de ce fichier doit se faire en citant son auteur *************************--
--************************************ Date de création : 12/06/2020 ****************************************--
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




with p_demineur_modele; use p_demineur_modele;
with p_vue_texte; use p_vue_texte;
with p_esiut; use p_esiut;

procedure demineur_texte is
    nb_ligne, nb_colone, nb_mine: integer;
    Perdu, Abandon : boolean;
    Rejouer : string(1..3);
    max_ligne_colonne : integer;
begin
    loop
        -------------------------
        -------------------------   
        Perdu := false;
        Abandon := false;
        nb_ligne := 0;
        nb_colone := 0; 
        nb_mine := 0;
        max_ligne_colonne := 50;
        -------------------------
        -------------------------
        while (nb_ligne < 1 or nb_colone < 1) or (nb_ligne > max_ligne_colonne or nb_colone > max_ligne_colonne) loop
            clr_ecran;
            ecrire("Nombre de lignes : "); lire(nb_ligne);
            ecrire("Nombre de colonnes : "); lire(nb_colone);
            if nb_ligne <= 0 or nb_colone <= 0 then
                ecrire_ligne("Le nombre de lignes et de colonnes doit etre superieur 0 ");
                pause;
            end if;
            if nb_ligne > max_ligne_colonne or nb_colone > max_ligne_colonne then
                ecrire("Le nombre de lignes et de colonnes doit etre inferieur a "); ecrire_ligne(max_ligne_colonne);
                pause;
            end if; 
        end loop;
                                                                        
        while nb_mine <= 0 or (nb_mine >= nb_ligne * nb_colone) loop
            clr_ecran;
            ecrire("Nombre de mines : "); lire(nb_mine);
            if nb_mine >= (nb_ligne * nb_colone) then
                ecrire("Le nombre de mine ne peut etre superieur ou egale a "); ecrire_ligne(nb_ligne * nb_colone);
                pause;
            elsif nb_mine <= 0 then
                ecrire("Le nombre de mine doit etre superieur a 0 ");
                pause;
            end if;
        end loop;

        declare
            Grille : TV_Grille(1..nb_ligne, 1..nb_colone);
        begin
            InitialiseGrille(Grille, nb_mine);
            
            while not Perdu and not VictoireJoueur(Grille) and not Abandon loop     
                clr_ecran;
                Affiche(Grille, false);
                ecrire_ligne("Voulez vous abandonner (true/false)"); lire(Abandon);
                if not Abandon then
                    Saisie( nb_ligne,  nb_colone, Grille);
                    DevoileCase(Grille, nb_ligne, nb_colone);
                    Perdu := DefaiteJoueur(Grille,nb_ligne,nb_colone);
                end if;
            end loop;
            clr_ecran;

            Affiche(Grille, true);

            if Perdu or Abandon then
                ecrire_ligne("Vous avez perdu.. ");
                
            else
                ecrire_ligne("Felicitation!");
            end if;
        end;

        ecrire_ligne("Voulez vous rejouer ? (oui pour rejouer, autre pour quitter) "); lire(rejouer);
        exit when rejouer /= "oui";
    end loop;
    clr_ecran;  
end demineur_texte;
