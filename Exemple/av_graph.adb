with p_vuetxt, p_virus, text_io; use p_vuetxt, p_virus, text_io; 
use p_virus.p_piece_io; 
use p_virus.p_dir_io;
use p_virus.p_coul_io;
with p_fenbase ; use p_fenbase ;
with Forms ; use Forms;
with p_esiut; use p_esiut;
with p_vue_graph; use p_vue_graph;


procedure av_graph is
    fenetre : TR_Fenetre;

begin 
    InitialiserFenetres;

    fenChoixNom(fenetre);

    MontrerFenetre(fenetre);

    loop

        if AttendreBouton(fenetre)="Jouer" then
            exit;

        elsif AttendreBouton(fenetre)="Score" then
            CacherFenetre(fenetre);
            fenChoixConfig(fenetre); 
            MontrerFenetre(fenetre);

            if AttendreBouton(fenetre)="Aide" then
                CacherFenetre(fenetre);
                fenJeu(fenetre);
                montrerFenetre(fenetre);

            elsif AttendreBouton(fenetre)="Quitter" then

                exit;
        
            end if;

        end if;

    end loop;
    


end av_graph;