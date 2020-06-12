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
							Fenetre_Size := (820,365);
							Barre_Size := (633,1);
						end if;
						declare
							G : TV_Grille(1..Difficulte.Colonne, 1..Difficulte.Ligne);
							--Debut, Fin : Time;
						begin
							ecrire_ligne(G'Length(1));
							ecrire_ligne(G'Length(2));
							InitialiseGrille(G, Difficulte.NombreBombe);
							CacherFenetre(F);
							F_Jouer(F, G, Difficulte.CaseSize);
							MontrerFenetre(F);
				
							--Debut := Clock;
							loop -- Attendre un click
								declare 
									Click : string := AttendreBouton(F);
									PosX, PosY : integer;
									Defaite : boolean := false;
								begin 	
									ecrire_ligne(Click);
									if Click = "Abandonner" then
										Defaite := true;
									elsif Click = "Restart" then
										Restart(G);
										SetEtatBoutton(F, G, marche);
									elsif Click = "Victoire" then
										Fenetre_Size := (820,580);
										CacherFenetre(F);
										F_Victoire(F);
										MontrerFenetre(F);
									elsif Click = "Defaite" then
										Fenetre_Size := (820,580);
										CacherFenetre(F);
										F_Defaite(F);
										MontrerFenetre(F);
									elsif Click = "menu" then -- Marche pas
										CacherFenetre(F);
										F_Main(F);
										MontrerFenetre(F);
									else
										GetPosition(Click, Difficulte.Colonne, Difficulte.Ligne, PosX, PosY);
										if ClickDroit then 
											MarqueCase(G, PosX, PosY);
										else
										
											DevoileCase(G, PosX, PosY);
											ecrire("NumCase: "); ecrire_ligne(Click);
											ecrire("PosX "); ecrire_ligne(PosX);
											ecrire("PosY: "); ecrire_ligne(PosY);
											ecrire("NombreMineAutour: "); ecrire_ligne(NombreMineAutour( G, PosX, PosY));
											Defaite := DefaiteJoueur(G, PosX, PosY);
										end if;
									end if;
									if Defaite then
										RafraichirGrille(F, G, true);
									else
										RafraichirGrille(F, G, false);	
									end if;
								end;
								--exit when Defaite or Abandonner;
							end loop;
							
							--Fin := Clock;
							--ecrire_ligne(Fin);
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
				exit;
			end if;
		end;
		CacherFenetre(F);
	end loop;


	-------------------------------------------	
	-------------------------------------------

	-------------------------------------------
	-------------------------------------------



end demineur_graph;