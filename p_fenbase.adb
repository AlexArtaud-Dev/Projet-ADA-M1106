package body p_fenbase is

    procedure InitialiserFenetres;
        -- définir une nouvelle fenêtre ----------------------------------------------
        function DebutFenetre (
        Titre : in String; -- nom de la fenêtre
        Largeur, -- sa largeur en pixels
        Hauteur : in Positive) -- sa hauteur en pixels
        return TR_Fenetre; -- résultat : la fenêtre créée

    begin

    end InitialiserFenetres;

end p_fenbase;