package body p_fenbase is

    procedure InitialiserFenetres;
        -- d�finir une nouvelle fen�tre ----------------------------------------------
        function DebutFenetre (
        Titre : in String; -- nom de la fen�tre
        Largeur, -- sa largeur en pixels
        Hauteur : in Positive) -- sa hauteur en pixels
        return TR_Fenetre; -- r�sultat : la fen�tre cr��e

    begin

    end InitialiserFenetres;

end p_fenbase;