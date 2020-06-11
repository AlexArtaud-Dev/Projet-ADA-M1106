package body p_virus is 

procedure InitPartie(Grille: in out TV_Grille; Pieces: in out TV_Pieces) is

begin 
	-- boucle principale pour i appartenant à la ligne
	for i in Grille'range(1) loop

		-- première sous boucle pour j appartenant à la colonne
		for j in Grille'range(2) loop
			Grille(i, j) := vide;
			Put("vide vérifié");
			New_Line;
		end loop;
		-- fin première sous boucle 

		-- deuxième sous boucle pour k appartenant aux nombres de pièces
		for k in Pieces'Range loop
			Pieces(k) := False; 
			Put("il n'y a pas de pièce pour k");
			New_Line;
		end loop;
		-- fin deuxième sous boucle 

	end loop;
	-- fin boucle principale

end InitPartie;

procedure Configurer(f : in out p_piece_io.file_type; nb : in Integer; 
		     Grille:in out TV_Grille; Pieces: in out TV_Pieces) is
	package p_inte_io is new Integer_IO(Integer); use p_inte_io;
	ElemP : TR_ElemP;

begin

	-- vérification de la fin du fichier
	if not End_Of_File(f) then 

		-- lecture des configurations jusqu'à la configuration demandée
		for k in 1..nb-1 loop 

			Read(f, ElemP);

			-- tant que couleur différent de rouge on lit les éléments
			while ElemP.couleur /= rouge loop
				Read(f, ElemP);
			end loop; 

			-- on lit le dernier élément
			Read(f, ElemP);

		end loop;

			-- on lit le premier
			read(f, ElemP);
			
			-- si couleur n'est pas rouge alors on boucle jusqu'à atteindre rouge
			while ElemP.couleur /= rouge loop
				Grille(ElemP.ligne, ElemP.colonne) := ElemP.couleur;
				Read(f, ElemP); 
			end loop;

			-- Grille prend les couleurs des cases colorées
			Grille(ElemP.ligne, ElemP.colonne) := ElemP.couleur;

			-- on lit les élément rouge
				Read(f, ElemP);
				Grille(ElemP.ligne, ElemP.colonne) := ElemP.couleur;

	else 
		put("la fin du fichier est atteinte");
	end if;

end Configurer;

-- pour test configuration... 
procedure PosPiece(Grille: in TV_Grille; coul: in T_coulP) is
    package p_int_io is new Integer_IO(Integer); use p_int_io; 	


begin		

	-- boucle pour la recherche de couleur dans la grille 
	for  i in Grille'range(1) loop
		for j in Grille'range(2) loop

			-- ecriture de la couleur
			if Grille(i, j) = coul then
				Put(Grille(i,j));

				-- ecriture de la ligne puis de la colonne
				Put(i); Put(j);
				New_Line;
			end if;
		
		end loop;

	end loop;


end PosPiece;

---------------Contrôle du jeu
function Possible (Grille: in TV_Grille; coul: T_CoulP; Dir : in T_Direction) return boolean is

begin 
	
	-- boucle principale pour i appartenant à la ligne
	for i in Grille'range(1) loop
		-- première sous boucle pour j appartenant à la colonne
		for j in Grille'range(2) loop

			-- si cool = blanc alors on test si grille(i,j) = coul
			-- on aura au préalable demandé à l'utilisateur une direction dans la procedure principale

			if coul /= blanc then 
				if Grille(i, j) = coul then
					
					-- si l'users a saisi hg on test : 
					if dir = hg then
						if grille(i-1, T_Col'Pred(j)) /= vide and grille(i-1, T_Col'Pred(j)) /= coul then
							return false;
						end if;

					-- si l'users a saisi bg on test :
					elsif dir = bg then
						if grille(i+1, T_Col'Pred(j)) /= vide and grille(i+1, T_Col'Pred(j)) /= coul then
							return false;
						end if;

					-- si l'users a saisi hd on test :
					elsif dir = hd then
						if grille(i-1, T_Col'Succ(j)) /= vide and grille(i-1, T_Col'Succ(j)) /= coul then
							return false;
						end if;

					-- si l'users a saisi bd on test :
					elsif dir = bd then
						if grille(i+1, T_Col'Succ(j)) /= vide and grille(i+1, T_Col'Succ(j)) /= coul then
							return false;
						end if;
							
					end if;

				end if;
			
			-- si l'users aucun des testes n'a fonctionné on retourne false :
			else	
				return False;
			end if;

		end loop;

	end loop; 
	
	-- on retourne true si la condition demandé par l'users a été vérifié
	return True;

end Possible; 

procedure MajGrille (Grille: in out TV_Grille; coul: in T_coulP; Dir :in T_Direction) is 
	grilleCopy : TV_Grille;

begin

	for i in Grille'range(1) loop
		for j in Grille'range(2) loop 
			grilleCopy(i, j) := vide;
		end loop;
	end loop;
	if Possible(grille, coul, Dir) = true  then 

		for i in Grille'range(1) loop
			for j in Grille'range(2) loop 
				if Grille(i,j) = coul then 

					-- si l'users a saisi hg on avance :
					if dir = hg then
						grilleCopy(i-1, T_Col'Pred(j)) := grille(i,j);

					-- si l'users a saisi bg on avance :
					elsif dir = bg then
						grilleCopy(i+1, T_Col'Pred(j)) := grille(i,j);
				
					-- si l'users a saisi hd on avance :
					elsif dir = hd then
						grilleCopy(i-1, T_Col'Succ(j)) := grille(i,j);

					-- si l'users a saisi bd on avance :
					elsif dir = bd then
						grilleCopy(i+1, T_Col'Succ(j)) := grille(i,j);

					end if;
				elsif grilleCopy(i, j) = vide then
					grilleCopy(i, j) := grille(i,j);
				end if;

			end loop;
		end loop;

		grille := grilleCopy;

	end if;

end MajGrille;

function Guerison(Grille: in TV_Grille) return boolean is 
	
begin 

	return Grille(1,'A') = rouge;

end Guerison;

end p_virus;
