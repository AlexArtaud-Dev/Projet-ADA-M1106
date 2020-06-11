    -- Score par nom
    --Il faut que la 
    --Nom du joueur (le garder en m�moire)
    --Temps

    -- Ecrire Score



    procedure GetScoresByName(Scores, UserScores : in out TV_Score; Nom : in string) is
        i : integer := 0;
    begin
        for Score in Scores'Range loop
            if Score.Nom = Nom then
                UserScores(i).Score := Score;
            end if;
            i := i+1;
        end loop;
    end GetScoreByName;

    procedure GetScores(f : in p_pays_io.file_type; Scores : out TV_Score) is
        s : TR_Score;
        i : integer := 0;
    begin
        read(f, s);
        while not end_of_file(f) loop
            read(f, s);
            Scores(i) := s;
            i := i+1;
        end loop;
    end GetScore;

    --Un historique des scores des joueurs pourra �galement �tre g�r�.
    procedure FScore(Victoire : in Boolean; Temps : in out Time; Nom : in out String) is
    --{Victoire = true} =>{affiche le temps de l'utilisateur si il a gagn� }
        NewTemps : Time := Temps;
    
     begin
            -- Initialiser les scores au tout d�but.
            if Victoire then 
                AjouterTexte(F, "txt", "VOS MEILLEURS TEMPS", X, Y, Largeur, Hauteur);--ou image 
                AjouterTexte(F, "Facile", "", X, Y, Largeur, Hauteur);
                AjouterTexte(F, "Moyen", "", X, Y, Largeur, Hauteur);
                AjouterTexte(F, "Difficile", "", X, Y, Largeur, Hauteur);
                Temps:=ConsulterTimer(F, "Minuteur");
                ConsulterContenue(F, "Nom");    
                    declare
					    Click : string := AttendreBouton(F);
                    begin
                        if Click="Reset" then 
                            EffacerContenu(F, "Minuteur");

                    end;
                    if Difficulte = "Facile" and Nom = Nom and NewTemps < Temps then -- Assigner une nouvelle valeur de temps < � la pr�cedente � la difficult� facile et au pseudo correspondant
                       NewTemps := Temps;
                    end if;
            
                AjouterTexte(F, "Moyen", "", X, Y, Largeur, Hauteur);
                    if Difficulte = "Moyen" and Nom = Nom and NewTemps < Temps then -- Assigner une nouvelle valeur de temps < � la pr�cedente � la difficult� facile et au pseudo correspondant
                        NewTemps := Temps;
                    end if;
                AjouterTexte(F, "Difficile", "", X, Y, Largeur, Hauteur);
                    if Difficulte = "Difficile" and Nom = Nom and NewTemps < Temps then -- Assigner une nouvelle valeur de temps < � la pr�cedente � la difficult� facile et au pseudo correspondant
                        NewTemps := Temps;
                    end if;
            end if;
    end FScore;
