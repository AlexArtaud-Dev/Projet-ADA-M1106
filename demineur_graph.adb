with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_esiut; use p_esiut;
with p_vue_graph; use p_vue_graph;

procedure demineur_graph is
	F : TR_Fenetre;
begin
	InitialiserFenetres;

    F_Main(F);
    MontrerFenetre(F);

	loop
		declare
			Click : string := AttendreBouton(F);
		begin
			if Click = "Jouer" then
				CacherFenetre(F);
				F_Nom(F);
				MontrerFenetre(F);
				declare
					Click : string := AttendreBouton(F);
				begin
					if Click = "Valider" then
						declare 
							NomJoueur : string := ConsulterContenu(F, "Nom");
						begin
							if (NomJoueur = "") then NomJoueur := "Invité"; end if;
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
								-- Genere TR_Grille
								CacherFenetre(F);
								F_Jouer(F);
								MontrerFenetre(F);
							end;
						end;
					elsif Click = "Annuler" then
						CacherFenetre(F);
						F_Main(F);
						MontrerFenetre(F);
					end if;
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

	end loop;


	-------------------------------------------	
	-------------------------------------------

	-------------------------------------------
	-------------------------------------------



end demineur_graph;