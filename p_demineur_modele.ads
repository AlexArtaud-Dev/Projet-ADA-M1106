package p_demineur_modele is

	-- case de la grille
	type T_Etat is (couverte, decouverte, marquee); -- état d'une case
	type TR_Case is record
		Occupee : Boolean; -- vrai si la case contient une mine, faux sinon
		Etat    : T_Etat;
	end record; 
      
	-- grille de démineur
	type TV_Grille is array (positive range <>, positive range <>) of TR_Case;

	procedure InitialiseGrille (
		G : out		TV_Grille;
		NbMines : in natural );
	--{NbMines < G'length(1)*G'length(2)} => {NbMines ont été placées au hasard dans G ; toutes les cases sont couvertes}

	function NombreMinesAutour (
		G : in		TV_Grille;  
		L : in		positive;   
		C : in		positive ) 
	return natural; 
	--{} => {résultat = le nombre de mines présentes dans les cases adjacentes à la case (L,C) de la grille G}

	procedure DevoileCase (
		G : in out	TV_Grille;  
		L : in		positive;   
		C : in		positive ); 
	--{} => {la case en position (L,C) dans la grille G est dévoilée et éventuellement ses voisines}

	procedure MarqueCase (
		G : in out 	TV_Grille;  
		L : in     	positive;   
		C : in     	positive ); 
	--{} => {la case en position (L,C) dans la grille G est marquée si elle était couverte / couverte si elle était marquée}
  
	function VictoireJoueur (
		G : in     	TV_Grille )  
    return Boolean;
	--{} => {résultat = vrai si toutes les cases libres de la grille G sont dévoilées}
  
end p_demineur_modele;
