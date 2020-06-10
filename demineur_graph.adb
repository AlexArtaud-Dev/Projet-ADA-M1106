with p_vue_graph; use p_vue_graph;
with p_fenbase; use p_fenbase;
with Forms; use Forms;

procedure demineur_graph is
	Fenetre : TR_Fenetre;

begin 
	InitialiserFenetres;
	Fenetre:=DebutFenetre 

	Fenetre := DebutFenetre("Demineur", 900, 750);

	-------------------------------------------
	-------------------------------------------
	DebutGroupe(Fenetre, "Groupe1");
		AjouterButton(F, "TestButton", "TextButton", 800, 600, 50, 100, FL_NORMAL_BUTTON);
	FinGroupe;
	-------------------------------------------
	-------------------------------------------


    FinFenetre(Fenetre);
    
end demineur_graph;

