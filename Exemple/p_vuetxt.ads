with p_virus, text_io; use p_virus, text_io;
use p_virus.p_piece_io; 

package p_vuetxt is

procedure InitGrille (GrilleVide : in out TV_Grille);
--{} => {la grille a été initialisée avec tout ses éléments à vide}

procedure ConfigGrille (f : in out p_piece_io.file_type; nbConfig : in Integer; 
                        GRilleInit : in out TV_Grille);
-- {f ouvert, nbConfig est un numéro de configuration} => 
-- {une configuration décrit le placement des pièces, 
-- une configuration est terminée par deux rouges}

procedure AfficheGrille(Grille : in TV_Grille);
--{} => la grille a été affiché selon le specs suivante :
--      sorte indiqué par S
--      case inacive ne contient aucun caractère
--      case couleur contient un point 
--      case blanche contient le caractère F (fixe)
--      une case de la couleur d’une pièce mobile contient 
--      le chiffre correspondant à la position de cette couleur dans le type T_Coul}


end p_vuetxt;