with p_demineur_modele; use p_demineur_modele;
with p_vue_texte; use p_vue_texte;
with p_esiut; use p_esiut;

procedure demineur_texte is
    nb_ligne, nb_colone, nb_mine: integer;
    Perdu, Abandon : boolean := false;
    Rejouer : string(1..3);
begin
    loop --boucle pour rejouer
        Perdu := false;
        nb_ligne := 0;
        nb_colone := 0; 
        nb_mine := 0;

        while nb_ligne < 1 or nb_colone < 1 loop -- vérifier que les colonnes et lignes > 1
            clr_ecran;
            ecrire("Nombre de lignes : "); lire(nb_ligne);
            ecrire("Nombre de colonnes : "); lire(nb_colone);
            if nb_ligne <= 0 or nb_colone <= 0 then
                ecrire_ligne("Le nombre de ligne ainsi que de colonne doit etre > 0 ");
                pause;
            end if;
        end loop;

        while nb_mine <= 0 or (nb_mine > nb_ligne * nb_colone) loop --on rentre dans la boucle ssi le nb_mine>nb_ligne*nb_colone 
            clr_ecran;
            ecrire("Nombre de mines : "); lire(nb_mine);
            if nb_mine > (nb_ligne * nb_colone) then
                ecrire_ligne("Le nombre de mine ne peut etre superieur au  nb_ligne * nb_colone");
                pause;
            elsif nb_mine <= 0 then
                ecrire("Le nombre de mine doit etre superieur à 1 ");
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
            --Affiche(Grille, false);
            if Perdu or Abandon then
                ecrire_ligne("Et ca fait BIM BAM BOUMMMM!!!!");
                Affiche(Grille, true);
            else
                ecrire_ligne("Bravo pour votre victoire grosse salope !!! ");
                Affiche(Grille, true);
            end if;
        end;

        ecrire_ligne("Voulez vous rejouer ? (oui pour rejouer, autre pour quitter) "); lire(rejouer);
        exit when rejouer /= "oui"; --sortie si l'utilisateur en veut pas rejouer
  
    end loop;
end demineur_texte;

-- Si case est libre => la case devient ocupée. 
