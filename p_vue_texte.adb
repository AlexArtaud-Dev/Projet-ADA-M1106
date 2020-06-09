with text_io; use text_io;
with p_demineur_modele; use p_demineur_modele;
package p_int_io is new Integer_IO; use p_int_io; 	

package body p_vue_texte is
	
procedure Affiche (G : in out TV_Grille) is
--{} => {Affiche la grille de jeu}

      begin
        put("  ");
        for i in 1..9 loop
            put(i);
        end loop;
        New_line();
        put_line(" +---------+");
        for i in 1..9 loop
            put(image (i) & '|');
            for j in 1..9 loop
                if G (i, j).Etat = couverte then
                    put('*');
                elsif G (i, j).Etat = marquee then
                    put('M');
                else
                    if NombreMinesAutour (G, i, j) = 0 then
                        put('.');
                    else
                        put(NombreMinesAutour (G, i, j));
                    end if;
                end if;
            end loop;
            put_line('|');
        end loop;
        put_line(" +---------+");
    end Affichage;

procedure Saisie (G : in TV_Grille; L, C : out positive; choix : out T_action) is
-- {} => {L'utilisateur saisie un coup}
	action : String(1..10);
begin
	Put("Saisissez une coordonné pour la ligne : "); Get(L); New_Line;
	Put("Saisissez une coordonné pour la colonne : "); Get(C); New_Line;
	loop
		if G(L, C) /= G then 
			Put_Line("Case hors du jeu");
		elsif G(L, C).Etat = decouverte then 
			Put_Line("Aucune action possible");
		else
			Put("Saisissez une action (marquer, demarquer, devoiler) : "); Get(action);
			choix := T_action'value(action);
			if choix = marquer then
				if G(L, C).Etat = marquee then
					Put_Line("case déjà marquée ");
				else
					G(L, C).Etat := marquee;
					Put_Line("Case marquée ");
				end if;
		end if;
		elsif choix = demarquer then
			if G(L, C).Etat = not marquee then
				Put_Line("case impossible a marquée");
			else
				G(L, C).Etat := marquee;
				Put_Line("Case demarquée");
			end if;
		elsif choix = devoiler then
			if G(L, C).Etat = decouverte then
				Put_Line("case déjà découverte");
			else 
				G(L, C) := devoiler;
				Put_Line("Case decouverte");
			end if;
		else 
			Put("Action invalide");
			end if;
		end if;
		exit when G(L, C).Etat in T_action; 
	end loop;
end Saisie;

procedure AfficheTout (G : in out TV_Grille) is
-- {} => {L'utilisateur saisie un coup}

begin
       put("  ");
       for i in 1..9 loop
           put(i);
       end loop;
       New_line();
       put_line(" +---------+");
       for i in 1..9 loop
           put(image (i) & '|');
           for j in 1..9 loop
             if G (i, j).occupee then
                 put('K');
               else
                 put('.')
             end if;
           end loop;
           put_line('|');
       end loop;
       put_line(" +---------+");
   end AfficheTout;
   
end p_vue_texte;