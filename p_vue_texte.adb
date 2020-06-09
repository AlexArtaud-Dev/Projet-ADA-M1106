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
end p_vue_texte;

procedure Saisie (L, C : out positive; choix : out T_action) is
-- {} => {'utilisateur saisie un coup}

end p_vue_texte;