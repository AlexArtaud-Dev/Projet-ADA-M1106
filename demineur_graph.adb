with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_esiut; use p_esiut;
with p_vue_graph; use p_vue_graph;
with p_demineur_modele; use p_demineur_modele;
with ada.calendar;use ada.calendar;
with Text_io; use Text_io;

procedure demineur_graph is
	F : TR_Fenetre;
	score_file : p_scores_io.file_type;
begin
	InitialiserFenetres;
	loop -- Temp que on veut joueur on afiche le menu.
	    F_Main(F);
		MontrerFenetre(F);
		declare
			Click : string := AttendreBouton(F); -- On attend un click sur le menu.
		begin
			if Click = "Jouer" then -- Si on a click sur Jouer on rentre dans la condition
				CacherFenetre(F);
				F_Nom(F);
				MontrerFenetre(F);
				declare
					Click : string := AttendreBouton(F); -- On attend un click sur le menu pour choisir le nom.
					NomJoueur : string(1..1000) := (others => ' ');
					Chars : integer := 0;
				begin
					Chars :=  ConsulterContenu(F, "Nom")'Length
					if Chars = 0 then 
						NomJoueur(1..6) := "Invite";
					else
						NomJoueur(1..Chars) := ConsulterContenu(F, "Nom");
					end if;
					ecrire("Nom Joueur: "); ecrire_ligne(NomJoueur);
					CacherFenetre(F);
					F_Difficulte(F); -- Quand on a defini le nom, on veut choisir le niveau.
					MontrerFenetre(F);
					declare
						Click : string := AttendreBouton(F); -- On attend un click sur le menu pour choisir le niveau.
						Difficulte : TR_Difficulte;
					begin
						if Click = "Facile" then
							Difficulte := D(Facile);
						elsif Click = "Moyen" then 
							Difficulte := D(Moyen);
							Boutton_Size_Jeu := (640,340);
						elsif Click = "Difficile" then -- Si on defaite, on affiche la grilel avec toutes les bombes
							Difficulte := D(Difficile);
							Fenetre_Size := (820,365);
							Barre_Size := (633,1);
							Boutton_Size_Jeu := (660,210);
							Nb_Flag_Pos := (657,110);
							Affichage_Temps_Pos := (657,10);
						end if;
						declare
							G : TV_Grille(1..Difficulte.Colonne, 1..Difficulte.Ligne);
							NMarque, NMarqueBombe : integer := 0;
						begin
							ecrire_ligne(G'Length(1));
							ecrire_ligne(G'Length(2));
							InitialiseGrille(G, Difficulte.NombreBombe);
							CacherFenetre(F);
							F_Jouer(F, G, Difficulte.CaseSize, Difficulte.NombreBombe);
							MontrerFenetre(F);
							loop
								declare 
									Click : string := AttendreBouton(F); -- On attend un click sur le menu pour choisir l'action.
									PosX, PosY: integer;
									Defaite, isMarquee : boolean := false;
								begin 	
									ecrire_ligne(Click);
									if Click = "Abandonner" then -- Si on a click sur Abandonner on rentre dans la condition qui donne defaite
										Defaite := true;
									elsif Click = "Restart" then -- Si on a click sur Restart on rentre dans la condition qui reset la grille et rend tous les boutons clickable
										Restart(G);
										SetEtatBoutton(F, G, marche);
									elsif Click = "Verification" then -- Si on a click sur Verification on rentre dans la condition qui va verifier si toutes les mombes et uniquement les bombes sont marque
										Fenetre_Size := (820,580);
										Defaite := VerificationMarquage(G, Difficulte.NombreBombe);
										CacherFenetre(F);
										if Defaite then
											F_Victoire(F); -- Si seulement les bnombes sont marque on gagne
										else 
											F_Defaite(F); -- Sinon on a perdue
										end if;					
										MontrerFenetre(F);
									elsif Click = "Quitter" then -- Si on a click sur Quitter on rentre dans la condition
										Fenetre_Size := (820,580);
										CacherFenetre(F);
										F_Defaite(F); -- Quitter revient a une Defaite
										MontrerFenetre(F);
									elsif Click = "Menu" then -- Si on a click sur Quitter on rentre dans la condition
										Affichage_Temps_Pos := (640,30);
										Nb_Flag_Pos := (640,160);
										Boutton_Size_Jeu := (640,300);
										Barre_Size := (600,1);
										exit;
									else
										GetPosition(Click, PosX, PosY); -- Si on a click sur autre chose on rentre dans la condition qui gere les click boutons
										if ClickDroit then -- Si on a click droit, on marque la case
											MarqueCase(G, PosX, PosY, isMarquee);
										else
											DevoileCase(G, PosX, PosY); -- Si on a click gauche sur une case, on devoile la case et on gere la logique
											ecrire("NumCase: "); ecrire_ligne(Click);
											ecrire("PosX "); ecrire_ligne(PosX);
											ecrire("PosY: "); ecrire_ligne(PosY);
											ecrire("NombreMineAutour: "); ecrire_ligne(NombreMineAutour( G, PosX, PosY));
											Defaite := DefaiteJoueur(G, PosX, PosY);
										end if;
									end if;
									if Defaite then
										RafraichirGrille(F, G, true); -- Si on defaite, on affiche la grilel avec toutes les bombes.
									else
										RafraichirGrille(F, G, false); -- Sinon on rafraichi seulement la grille.
									end if;
								end;
							end loop;
						end;
					end;
				end;
			elsif Click = "Score" then -- Si on a click sur Score on rentre dans la condition
				CacherFenetre(F);
				F_Score(F); 
				MontrerFenetre(F);
				declare
					Click : string := AttendreBouton(F);
				begin
					if Click="Retour" then 
						CacherFenetre(F);
						F_Main(F);
						MontrerFenetre(F);
					end if;
				end;
			elsif Click = "Aide" then
				CacherFenetre(F);
				F_Aide(F);
				MontrerFenetre(F);
				declare
					Click : string := AttendreBouton(F);
				begin
					if Click="Retour" then 
						CacherFenetre(F);
						F_Main(F);
						MontrerFenetre(F);
					end if;
				end;
			elsif Click = "Quitter" then
				exit;
			end if;
		end;
		CacherFenetre(F);
	end loop;
end demineur_graph;