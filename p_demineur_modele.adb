with p_esiut; use p_esiut;
with text_io; use text_io;

with Ada.Numerics.Discrete_Random;

package body p_demineur_modele is

procedure InitialiseGrille (G : out TV_Grille ; NbMines : in natural ) is
  --{NbMines < G'length(1)*G'length(2)} => {NbMines ont été placées au hasard dans G ; toutes les cases sont couvertes}
     
    package randomizer is new Ada.Numerics.Discrete_Random(Positive); use randomizer;
	gen : Generator;
	x, y : Positive;
begin
    Reset(gen); 
	for ligne in G'range(1) loop -- range(1) = première dim
		for colonne in G'range(2) loop -- range(2) = deuxieme dim
		G(ligne, colonne).Etat := couverte; -- 
			for k in 1..NbMines loop
                --Reset(gen);
				x := random(gen);
				y := random(gen);
				G(x, y).Occupee := true; -- mise en place des bombes aux coordonnées
			end loop;
		end loop;
	end loop;
end InitialiseGrille;
  
function NombreMinesAutour (G : in TV_Grille ; L : in positive ; C : in positive ) return natural is
  --{} => {résultat = le nombre de mines présentes dans les cases adjacentes à la case (L,C) de la grille G}
    n : natural := 0;
    around : TV_Around := (-1,1);
  begin
    for ligne in around'range loop -- Loop le check si il y a quelque chose sur la ligne
      for colonne in around'range loop -- Loop le check si il y a quelque chose sur la colonne
        if (ligne + L in G'range (1) and colonne + C in G'range (2)) then
          if G (ligne + L, colonne + C).occupee then
            n := n + 1;
          end if;
        end if;
      end loop;
    end loop;
    return n;
end NombreMinesAutour;

procedure DevoileCase (G : in out TV_Grille ; L : in positive ; C : in positive ) is
  --{} => {la case en position (L,C) dans la grille G est dévoilée et éventuellement ses voisines}
    around : TV_Around := (-1,1);
begin
  G (L, C).Etat := decouverte;
  if NombreMinesAutour (G, L, C) = 0 then
    for ligne in around'range loop
      for colonne in around'range loop
         if (L + ligne in G'range (1) and C + colonne in G'range (2)) then
          DevoileCase (G, L + ligne, C + colonne);
        end if;
      end loop;
    end loop;
  end if;
end DevoileCase;

  procedure MarqueCase (G : in out TV_Grille; L : in positive ; C : in positive ) is
  --{} => {la case en position (L,C) dans la grille G est marquée si elle était couverte / couverte si elle était marquée}
  begin
    if G(L, C).Etat = couverte then
      G(L, C).Etat := marquee;
    else
      G(L, C).Etat := couverte;
      end if;
  end MarqueCase;
  
  function VictoireJoueur (G : in TV_Grille ) return Boolean is
  --{} => {résultat = vrai si toutes les cases libres de la grille G sont dévoilées}
  
  a_gagne : boolean := true;
  begin
    for j in 1..G'last(1) loop
      for k in 1..G'last(2) loop
        if G(j, k).Occupee = false then
          if G(j, k).Etat = couverte then
            a_gagne := false;
          end if;
        end if;
      end loop;
    end loop;
    return a_gagne;
  end VictoireJoueur;



end p_demineur_modele;