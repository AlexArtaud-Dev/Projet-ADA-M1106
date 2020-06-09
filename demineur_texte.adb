with p_demineur_modele; use p_demineur_modele;
with p_vue_texte; use p_vue_texte;
with p_esiut; use p_esiut;

procedure demineur_texte is
    nb_caseX : positive;
    nb_caseY : positive;
    nb_mine : positive;

    SaisieX, SaisieY : positive;
    Perdu : boolean := false;
begin
    ecrire("Nombre de lignes : ");lire(nb_caseX);
    ecrire("Nombre de colonnes : ");lire(nb_caseY);
    loop
        ecrire("Nombre de mines : ");lire(nb_mine);
        if not ( nb_mine < nb_caseX * nb_caseY) then
            ecrire("Nombre de mines : ");lire(nb_mine);
        end if;
        exit when nb_mine < nb_caseX * nb_caseY;
    end loop;

    declare
        Grille : TV_Grille(1..nb_caseX,1..nb_caseY);
    begin
        InitialiseGrille(Grille, nb_mine);
        while not Perdu  and not VictoireJoueur(Grille) loop
            Affiche(Grille);
            Saisie(SaisieX, SaisieY, Grille);
            DevoileCase(Grille, SaisieX, SaisieY);
            Defaite(Grille, Perdu);
        end loop;
        Affiche(Grille, false);
        if Perdu then
            ecrire_ligne("Perdu fils de pute");
            Affiche(Grille, true);
        else
            ecrire("Les arabes o cacho.");
        end if;
    end;
end demineurTexte;
