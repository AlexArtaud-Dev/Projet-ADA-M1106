with p_demineur_modele; use p_demineur_modele;
with p_vue_texte; use p_vue_texte;
with p_esiut; use p_esiut;

procedure demineur_texte is
    nb_ligne, nb_colone, nb_mine : positive;
    --SaisieLigne, SaisieColone : positive;
    Perdu : boolean := false;
    
begin
    ecrire("Nombre de lignes : "); 
    lire(nb_ligne);
  
  --loop
    --    lire(nb_ligne);
    --    exit when nb_ligne > 0;
    --    ecrire("La valeur de ligne doit être positive");
   -- end loop;



    ecrire("Nombre de colonnes : "); lire(nb_colone);
    loop
        ecrire("Nombre de mines : "); lire(nb_mine);
        if ( nb_mine > nb_ligne * nb_colone) then
            ecrire_ligne("Le nombre de mine ne peut etre superieur à nb_ligne * nb_colone");
        end if;
        exit when nb_mine < nb_ligne * nb_colone;
    end loop;

    declare
        Grille : TV_Grille(1..nb_ligne, 1..nb_colone);
    begin
        InitialiseGrille(Grille, nb_mine);
        while not Perdu  and not VictoireJoueur(Grille) loop
            Affiche(Grille, false);
            Saisie( nb_ligne,  nb_colone, Grille);
            DevoileCase(Grille, nb_ligne, nb_colone);
           Perdu := DefaiteJoueur(Grille,nb_ligne,nb_colone);
        end loop;
        Affiche(Grille, false);
        if Perdu then
            ecrire_ligne("Et ca fait BIM BAM BOUMMMM!!!!");
            Affiche(Grille, true);
        else
            ecrire("Bravo pour votre victoire");
        end if;
    end;
end demineur_texte;
