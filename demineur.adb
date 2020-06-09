with p_esiut; use p_esiut;
with p_demineur_modele; use p_demineur_modele;
with p_vue_texte; use p_vue_texte;


procedure demineur is

  ----Problemes Actuel
  --Possibilité de tomber sur une mine au premier 'essaie'

  --Note
  --C'est jouable, dans l'état c'est une grille de 3*3 qui est affiché
  -- car plus simple et moins chiant à tester
  -- Pour changer la grille sans tous faire exploser
  --Modifier Les constantes nb_caseX et nb_caseY TOUJOUTS METTRE LA MEME VALEUR  GENRE 5*5, 8*8 25*25 etc
  --ET SURTOUT METTRE CETTE MEME VALEUR A LA LIGNE 5 DE PACKAGE p_demineur.ads EN SECONDE BORNE DU TYPE randomCaseX
--Les constantes pour le mode Faciles

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
  exit when nb_mine < nb_caseX * nb_caseY;
  end loop;
  declare
    Grille : TV_Grille(1..nb_caseX,1..nb_caseY);
  begin
  InitialiseGrille(Grille, nb_mine);

  while not Perdu  and not VictoireJoueur(Grille) loop
    Affiche(Grille, false);
    Saisie(SaisieX, SaisieY, Grille);
    DevoileCase(Grille, SaisieX, SaisieY);
    --Defaite(Grille, Perdu);
  end loop;

Affiche(Grille,false);
  if Perdu then
    ecrire_ligne("Tes naze");
    DevoileCase(Grille);
    Affiche(Grille,false);
  else
    ecrire("GG");
  end if;
end;







end demineur;