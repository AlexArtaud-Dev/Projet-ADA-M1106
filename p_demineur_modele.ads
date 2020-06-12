---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--************************************ COPYRIGHT 2020 - Artaud Alexandre ************************************--
--******************** Toute copie de ce fichier doit se faire en citant son auteur *************************--
--************************************ Date de création : 12/06/2020 ****************************************--
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------




package p_demineur_modele is

	type T_Etat is (couverte, decouverte, marquee);
	type TR_Case is record
		Occupee : Boolean;
		Etat    : T_Etat;
	end record;
      
	type TV_Grille is array (positive range <>, positive range <>) of TR_Case;

	Type TV_Around is array(1..2) of integer;

	procedure InitialiseGrille (G : out TV_Grille ; NbMines : in natural);
	--{NbMines < G'length(1)*G'length(2)} => {NbMines ont été placées au hasard dans G ; toutes les cases sont couvertes}

	function DefaiteJoueur (G: in TV_Grille; L, C : in Positive) return Boolean;
	--{}=>{vrai si une case est découverte et occupée}

	function NombreMineAutour(G : in TV_Grille; L : in positive; C : in positive) return natural;
	--{} => {résultat = le nombre de mines présentes dans les cases adjacentes à la case (L,C) de la grille G}

	procedure DevoileCase (
		G : in out	TV_Grille;  
		L : in		positive;   
		C : in		positive ); 
	--{} => {la case en position (L,C) dans la grille G est dévoilée et éventuellement ses voisines}

	procedure MarqueCase (
		G : in out 	TV_Grille;  
		L : in     	positive;   
		C : in     	positive; 
		isMarquee : out boolean
		); 
	--{} => {la case en position (L,C) dans la grille G est marquée si elle était couverte / couverte si elle était marquée}
  
	function VictoireJoueur (
		G : in     	TV_Grille )  
    return Boolean;
	--{} => {résultat = vrai si toutes les cases libres de la grille G sont dévoilées}
  
	procedure GetMarque(G : in TV_Grille; NBombe, NCase : out integer);

	procedure Restart (G : in out TV_Grille);
	--{} => {Remet la grille à Zéro}

	function VerificationMarquage(G : in TV_Grille;  NombreBombe : in Positive) return boolean ;
	 

end p_demineur_modele;
