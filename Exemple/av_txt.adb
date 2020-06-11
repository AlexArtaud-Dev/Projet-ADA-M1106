with p_vuetxt, p_virus, text_io; use p_vuetxt, p_virus, text_io; 
use p_virus.p_piece_io; 
use p_virus.p_dir_io;
use p_virus.p_coul_io;


procedure av_txt is

    f : p_piece_io.File_Type;
    GrilleAv : TV_Grille;
    configN : Integer; -- numéro de configuration
    coule : T_CoulP; 
    direct : T_Direction; 
    depPoss : Boolean;
    guer : Boolean;
    package p_int_io is new Integer_IO(Integer); use p_int_io; 

begin 
    
    -- on initialise la grille  
    InitGrille(GrilleAv);

    -- on demande la configuration 
    Put_Line("choisissez une configuration entre 1 et 20 : "); Get(configN);

    -- on ouvre le fichier de configuration 
    open(f, In_File, "Parties");

    -- on configure la grille
    ConfigGrille(f, configN, GrilleAv);

    -- enfin on affiche la grille
    AfficheGrille(GrilleAv);

    Close(f);

    guer := false;


    while Guer = false loop
    begin
        -- demande à l'users de saisir une couleur et un déplacement
        Put_Line("donner une couleur :"); get(coule);
        Put_Line("choisissez une direction (hg, bg, bd, hd): "); Get(direct);
        depPoss := Possible(GrilleAv, coule, direct);
        if depPoss = true then 
            put("deplacement possible"); New_Line;
            MajGrille(GrilleAv, coule, direct);
            AfficheGrille(GrilleAv);
        else 
            put("deplacement impossible"); New_Line;
        end if;
    
    guer := Guerison(GrilleAv);
        if guer = true then 
            Put_Line("partie terminée");
            exit; 
        end if;

    exception
        when Constraint_Error => put("(exc) deplacement impossible"); New_Line; 
        when text_io.Data_Error => Put("(exc) valeur incorrecte"); New_Line;
    end;
    end loop;

end av_txt;