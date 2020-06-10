with p_esiut; use p_esiut;
with text_io; use text_io;
with p_demineur_modele; use p_demineur_modele;

package p_vue_texte is
	
    procedure Affiche(G : in out TV_Grille; Triche : in boolean);
    --{} => {Affiche la grille de jeu}
    
    procedure Saisie(L, C : in out positive; G : in TV_Grille);
    -- {} => {L'utilisateur saisie un coup}

end p_vue_texte;