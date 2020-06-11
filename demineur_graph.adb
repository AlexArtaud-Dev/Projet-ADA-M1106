with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_esiut; use p_esiut;
with p_vue_graph; use p_vue_graph;
with p_demineur_modele; use p_demineur_modele;
with ada.calendar;use ada.calendar;

procedure demineur_graph is
	F : TR_Fenetre;
begin
	InitialiserFenetres;

	loop
	    F_Main(F);
		MontrerFenetre(F);
		declare
			Click : string := AttendreBouton(F);
		begin
			if Click = "Jouer" then
				CacherFenetre(F);
				F_Nom(F);
				MontrerFenetre(F);
				declare
					Click : string := AttendreBouton(F);
					NomJoueur : string(1..20) := (others => ' ');
					Chars : integer := 0;
				begin
					Chars :=  ConsulterContenu(F, "Nom")'Length;
					if Chars = 0 then 
						NomJoueur(1..6) := "Invite";
					else
						NomJoueur(1..Chars) := ConsulterContenu(F, "Nom");
					end if;
					ecrire("Nom Joueur: "); ecrire_ligne(NomJoueur);
					CacherFenetre(F);
					F_Difficulte(F);
					MontrerFenetre(F);

					declare
						Click : string := AttendreBouton(F);
						Difficulte : TR_Difficulte;
					begin
						if Click = "Facile" then
							Difficulte := D(Facile);
						elsif Click = "Moyen" then 
							Difficulte := D(Moyen);
						elsif Click = "Difficile" then
							Difficulte := D(Difficile);
						end if;
						declare
							G : TV_Grille(1..Difficulte.Colonne, 1..Difficulte.Ligne);
						begin
							InitialiseGrille(G, Difficulte.NombreBombe);
							CacherFenetre(F);
							F_Jouer(F, G, Difficulte.CaseSize);
							MontrerFenetre(F);
							loop -- Attendre un click
								declare 
									Click : string := AttendreBouton(F);
									PosX, PosY : integer;
									Defaite : boolean := false;
								begin 
									if Click = "Abandonner" then
										ecrire_ligne(Click);
									elsif Click = "Restart" then
										ecrire_ligne(Click);
									else

										GetPosition(Click, Difficulte.Colonne, Difficulte.Ligne, PosX, PosY);
										DevoileCase(G, PosX, PosY);
										-- Integer'Image(NombreMineAutour(G, ligne, colone))

										ecrire("NumCase: "); ecrire_ligne(Click);
										ecrire("PosX "); ecrire_ligne(PosX);
										ecrire("PosY: "); ecrire_ligne(PosY);
										ecrire("NombreMineAutour: "); ecrire_ligne(NombreMineAutour( G, PosX, PosY));

										Defaite := DefaiteJoueur(G, PosX, PosY);
										
										if Defaite then 
											RafraichirGrille(F, G, true);
										else 
											RafraichirGrille(F, G, false);
										end if;
									end if;
								end;
								--exit when Defaite;
							end loop;
						end;
					end;
				end;
			elsif Click = "Score" then
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
				--exit;
				CacherFenetre(F);
				F_Main(F);
				MontrerFenetre(F);
			end if;
		end;
		
		CacherFenetre(F);
	end loop;


	-------------------------------------------	
	-------------------------------------------

	-------------------------------------------
	-------------------------------------------



end demineur_graph;