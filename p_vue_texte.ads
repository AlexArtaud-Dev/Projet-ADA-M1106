with p_esiut; use p_esiut;
with text_io; use text_io;
with p_demineur_modele; use p_demineur_modele;

package p_vue_texte is
	
    procedure Affichage (G : in out TV_grille);
    --{} => {rafraichi l'affichage grille}
    
    procedure Saisie (L, C : out positive; choix : out T_action);
    -- {} => {L'utilisateur saisie un coup}

end p_vue_texte;