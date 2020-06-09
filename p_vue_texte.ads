with p_esiut; use p_esiut;
with text_io; use text_io;
with p_demineur_modele; use p_demineur_modele;

package p_vue_texte is
	
   procedure AffichePartiel(G : in out TV_Grille);
    --{} => {Affiche la grille de jeu}
    
    procedure Saisie (G : in TV_Grille; L, C : out positive; choix : out T_action);
    -- {} => {L'utilisateur saisie un coup}

    procedure AfficheComplet(G : in out TV_Grille);
    -- {} => {L'utilisateur saisie un coup}

end p_vue_texte;