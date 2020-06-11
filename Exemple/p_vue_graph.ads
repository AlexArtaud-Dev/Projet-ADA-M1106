with p_fenbase ; use p_fenbase ;
with Forms ; use Forms;
with text_io, p_virus; use text_io,  p_virus;
use p_virus.p_piece_io, p_virus.p_dir_io, p_virus.p_coul_io;

package p_vue_graph is
    procedure fenChoixNom (fen : in out TR_fenetre);
    --{la fenêtre n'est pas ouverte} => {on demande à l'utilisateur de saisir son pseudo}

    procedure fenChoixConfig (fen : in out TR_fenetre);
    --{la fenetre choix Nom doit etre ouverte} => {l'utilisateur choisi sa configuration}

    procedure fenJeu (fen : in out TR_fenetre);
    --{la fenetre choix config doit etre ouverte} => {retourne le jeu} 


end p_vue_graph;