with p_fenbase; use p_fenbase;
with Forms; use Forms;
with p_esiut; use p_esiut;
with p_vue_graph; use p_vue_graph;

procedure demineur_graph is
	F : TR_Fenetre;
	Nom : string(1..10) := (others => ' ');
begin 
	InitialiserFenetres;

	Main(F);

    Nom := InitNom;

	--Jouer(F, "Denimeur", 500, 250);

	-------------------------------------------
	-------------------------------------------
	--Fenetre := DebutFenetre("Demineur", 200, 100);
		--AjouterChamp(Fenetre, "dqzjdopq", "fqieoq", "fise",85,10,100,30);
		--AjouterBouton(Fenetre, "TestButton", "TextButton", 85, 10, 100, 30);
		--AjouterBoutonRond(Fenetre, "TestButtonRond", "TextButtonRond", 70, 10, 50);
	--FinFenetre(Fenetre);
	--MontrerFenetre(Fenetre);
	-------------------------------------------
	-------------------------------------------

  --fenChoixNom (Fenetre);

end demineur_graph;