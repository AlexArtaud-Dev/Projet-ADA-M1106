with text_io; use text_io;
with p_esiut; use p_esiut;
use p_demineur_modele; use p_demineur_modele;

package body p_vue_texte is 


function isDecouverteLibreVide(G: in TV_Grille; x, y: in integer) return boolean is 
--{}=>{resultat=}
    return G(x, y).etat = decouverte and G(x, y).etat /= occupee
end isDecouvert;
-------------------------------------------------------------------------------------------------------------------------------


    procedure AffichePartiel(G : in out TV_Grille) is
    --{} => {Affiche la grille de jeu}
        C : TR_Case;
    begin 
    -- Libre => pas de bombe
    -- Vide => rien autour (verticale, horizontale, diagonale)
        for ligne is G'Range(1) loop
            for colonne in G'range(2) loop
                C := G(ligne, colonne);s
                if C.Etat /= decouverte then
                    ecrire(" * ");
                elsif (C.Occupee= false and C.Etat = decouverte and NombreMinesAutour(G, ligne, colonne) = 0) 
                    ecrire(" . ");
                elsif C.Occupee= false and C.Etat = decouverte and NombreMinesAutour(G, ligne, colonne) > 0) 
                    ecrire(NombreMinesAutour(G, ligne, colonne));
               elsif (Marquecase(G, ligne, colonne))
                    ecrire(" M ");
               elsif (C.Occupee)
                    ecrire(" K ");
               end if; 
            end loop
        end loop;
    --end AfficheGrille;
    end LaMereAKiki;

    procedure Saisie(G : in TV_Grille; L, C : out positive; choix : out T_action) is
        ligne, colonne : positive;
    begin
        put("Entrez le numéro de ligne"); get_line(ligne);
        put("Entrez le numéro de la colonne"); get_line(colonne);
            for ligne in G'First(1)..G'Last(2) loop
                for colonne in G'First(2)..G'Last(2) loop

                end loop;
            end loop;
    end Saisie;

end p_vue_texte;
--stop bande de batard

