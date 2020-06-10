with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_esiut; use p_esiut;
with p_vue_graph; use p_vue_graph;

procedure demineur_graph is
	FMain, FScore, FJouer, FAide : TR_Fenetre;
    NomJoueur : string(1..10) := (others => ' ');

begin
	InitialiserFenetres;

    Main(FMain);
	Score(FScore);
	Jouer(FJouer);
	Aide(FAide);

	--loop

	



		

	--end loop;

	-------------------------------------------
	-------------------------------------------

	-------------------------------------------
	-------------------------------------------



end demineur_graph;