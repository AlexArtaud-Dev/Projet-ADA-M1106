with text_io, p_virus; use text_io, p_virus;
use p_virus.p_piece_io;
use p_virus.p_coul_io;
use p_virus.p_dir_io;

procedure testjeu is 
    f : p_piece_io.File_Type;       -- fichier de partie
    gril : TV_Grille;               -- vecteur grille
    coulV : T_CoulP;                -- couleur sans vide
    piec : TV_Pieces;               -- vecteur de pieces
    nbPar : Positive;               -- nombre de parties
    direct : T_Direction;           -- direction 
    depPoss : boolean;              -- position possible ou non 
    package p_int_io is new Integer_IO(Integer); use p_int_io; 


begin 
    -- initialisation de la partie
    InitPartie(gril, piec);

    -- on demande à l'utilisateur de saisir un numéro de configuration
    Put_Line("donner un nombre de configuration entre 1 et 20 :"); get(nbPar);

    -- ouveture du fichier
    open(f, in_file, "Parties");

    Configurer(f, nbPar, gril, piec);

    Put_Line("donner une couleur :"); get(coulV);
    PosPiece(gril,coulV);

    Put_Line("donner une direction : "); get(direct);
    depPoss := Possible(gril, coulV, direct);

    if depPoss = true then 
        put("deplacement possible");
        MajGrille(gril, coulV, direct);
    else 
        put("deplacement impossible");
    end if;

    -- fermeture du fichier
    Close(f);




end testjeu;