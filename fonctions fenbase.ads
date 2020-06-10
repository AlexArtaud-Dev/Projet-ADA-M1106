with Forms; use Forms; 
with Interfaces.C;use Interfaces.C; 
package p_fenbase is 
 ------------------------------------------------------------------------------  -- types � conna�tre pour utiliser le paquetage 
  ------------------------------------------------------------------------------  type  TA_String is access String;    -- pointeur sur une cha�ne de caract�res  type  TR_Fenetre;            -- une fen�tre de l'interface graphique  type  T_EtatBouton is (Marche, Arret); -- �tat d'un bouton (actif ou inactif)  subtype T_Couleur is FL_COLOR;      -- couleurs disponibles dans le paquetage forms 
   	--  FL_BLACK, FL_RED, FL_GREEN, FL_YELLOW, FL_BLUE, FL_MAGENTA, FL_CYAN, 
   	--  FL_WHITE, FL_TOMATO, FL_INDIANRED, FL_SLATEBLUE, FL_COL1, FL_RIGHT_BCOL, FL_BOTTOM_BCOL, 
   	--  FL_TOP_BCOL, FL_LEFT_BCOL, FL_MCOL, FL_INACTIVE, FL_PALEGREEN, FL_DARKGOLD, 
   	--  FL_ORCHID, FL_DARKCYAN, FL_DARKTOMATO, FL_WHEAT, FL_DARKORANGE, FL_DEEPPINK, 
   	--  FL_CHARTREUSE, FL_DARKVIOLET, FL_SPRINGGREEN, FL_DODGERBLUE 
 ------------------------------------------------------------------------------  -- types internes au paquetage, inutile de les conna�tre ! 
 ------------------------------------------------------------------------------ 
 type T_TypeElement is (Bouton, TexteFixe, ChampDeSaisie, TexteAscenseur, Horloge, Fond, CheckBox, 
     PictBouton, BoutonRond, Image, Timer, BoutonRadio, Groupe );  type TR_Element; 
 type TA_Element is access TR_Element;  type TR_Element is record   TypeElement : T_TypeElement; 
  NomElement : TA_String; 
  Texte    : TA_String; 
  Contenu   : TA_String; 
  PElement  : FL_OBJECT_Access;   Suivant   : TA_Element;  end record; 
 type TR_Fenetre is record   PFenetre : FL_FORM_Access; 
  Titre   : TA_String;   PElements : TA_Element;  end record; 
 ------------------------------------------------------------------------------ 
 -- Initialisation du mode graphique, d�finition fen�tres et groupes d'�l�ments 
 ------------------------------------------------------------------------------  -- initialiser le mode graphique ---------------------------------------------  procedure InitialiserFenetres; 
 
 -- d�finir une nouvelle fen�tre ---------------------------------------------- 
 function DebutFenetre (Titre: in String; Largeur, Hauteur in Positive) return TR_Fenetre;              	-- r�sultat : la fen�tre cr��e  
 
 
 -- terminer la d�finition d'une nouvelle fen�tre ----------------------------- 
 procedure FinFenetre (F: in TR_Fenetre );   -- nom de la fen�tre 
 
 -- d�finir un groupe d'�l�ments graphiques -----------------------------------  
 procedure DebutGroupe (F: in out TR_Fenetre; 	-- la fen�tre du groupe     NomGroupe : in   String ); 	-- le nom du groupe 
 
  -- terminer un groupe d'�l�ments --------------------------------------------  procedure FinGroupe;             -- cl�t le groupe pr�c�demment d�fini  ------------------------------------------------------------------------------ 
 -- primitives d'ajout d'�l�ments graphiques dans une fen�tre d�j� d�finie 
 ------------------------------------------------------------------------------  -- ajouter un bouton de forme rectangulaire ----------------------------------  
 procedure AjouterBouton (
    F: in out TR_Fenetre; 	-- la fen�tre o� on ajoute 
    NomElement : in   String; 	-- le nom du bouton (unique) 
    Texte : in   String;       	-- le texte affich� dans le bouton 
    X, 	-- abscisse coin HG en pixels 
    Y : in   Natural;       	-- ordonn�e coin HG en pixels 
    Largeur,                 	-- largeur du bouton en pixels 
    Hauteur   : in   Positive; 	--  hauteur du bouton en pixels 
    TypeBouton : in   FL_Button_Type := FL_NORMAL_BUTTON); -- type du bouton (optionnel) 
    -- types de boutons : cf documentation XForms 
    -- FL_NORMAL_BUTTON (retourne une valeur quand rel�ch�) 
    -- FL_PUSH_BUTTON (retourne une valeur si rel�ch�, reste enfonc� jusqu'� nouveau clic)  
    -- FL_MENU_BUTTON (retourne une valeur quand press�) 
    -- FL_TOUCH_BUTTON (retourne une valeur tant que l'utilisateur le presse) 
    -- FL_RETURN_BUTTON (bouton classique mais qui r�agit � la touche ENTER du clavier) -- ajouter un bouton de forme circulaire -------------------------------------  procedure AjouterBoutonRond (          
    F      	: in out TR_Fenetre;     	-- la fen�tre o� on ajoute 
    NomElement : in   String;       	-- le nom du bouton (unique) 
    Texte    : in   String;       	-- le texte affich� dans le bouton 
    X 	   	 	 	-- abscisse coin HG du carr� englobant en pixels 
    Y      	: in   Natural;       	-- ordonn�e coin HG du carr� englobant en pixels 
    Diam     : in   Positive  );   	-- diam�tre du bouton en pixels 
 
 
 -- ajouter une bo�te � cocher ------------------------------------------------  procedure AjouterBoiteCocher (         
    F      	: in out TR_Fenetre;     	-- la fen�tre o� on ajoute 
    NomElement : in   String; 	-- le nom de la bo�te � cocher (unique) 
    Texte    : in   String;       	-- le texte affich� en l�gende 
    X, 	  	 	-- abscisse coin HG rectangle englobant en pixels 
    Y      	: in   Natural;   	-- ordonn�e coin HG rectangle englobant en pixels 
    Largeur,   	 	--  sa largeur en pixels 
    Hauteur   : in   Positive  ); 	-- sa hauteur en pixels 
 
 -- ajouter un bouton radio ---------------------------------------------------  procedure AjouterBoutonRadio (         
    F   	: in out TR_Fenetre;    	-- la fen�tre o� on ajoute 
    NomElement : in   String; 	-- le nom du bouton radio (unique) 
    Texte 	: in   String;       	-- le texte affich� en l�gende 
    X,  	 	  	 	-- abscisse coin HG du carr� englobant en pixels 
    Y   	: in   Natural;   	-- ordonn�e coin HG du carr� englobant en pixels 
    Diam 	: in  Positive; 	-- son diam�tre en pixels 
    Actif 	: in   Boolean := false); 	--  inactiv� par d�faut 
   -- NOTE : un bouton radion est int�ressant dans un groupe d'autres boutons radio  
 -- ajouter un bouton d�cor� d'une image (format XPM) ------------------------  procedure AjouterBoutonImage (         
    F   	: in out TR_Fenetre;     	-- la fen�tre o� on ajoute 
    NomElement : in   String; 	-- le nom du bouton (unique) 
    Texte 	: in   String;       	-- le texte affich� en l�gende 
  NomImage : in  String; 	-- le nom de l'image d�cor 
    X,  	 	  	 	--  abscisse du bouton en pixels 
    Y      	: in   Natural; 	-- ordonn�e du bouton en pixels 
    Largeur,  	  	 	-- largeur du bouton en pixels 
    Hauteur   : in   Positive  ); 	-- hauteur du bouton en pixels 
 
 -- ajouter une zone de texte non modifiable ----------------------------------   procedure AjouterTexte (            
    F      	: in out TR_Fenetre; 	-- la fen�tre o� on ajoute 
    NomElement  : in   String; 	-- le nom de la zone de texte 
    Texte    : in   String; 	-- son contenu 
    X,  	  	 	 	--  abscisse du coin HG de la zone de texte 
    Y      	: in   Natural; 	--  ordonn�e du coin HG de la zone de texte 
    Largeur,   	 	 	-- largeur de la zone de texte 
    Hauteur   : in   Positive  ); 	-- hauteur de la zone de texte 
 
 -- ajouter un champ de saisie -----------------------------------------------   procedure AjouterChamp (            
    F      	: in out TR_Fenetre; 	--  la fen�tre o� on ajoute 
    NomElement  : in   String; 	--  le nom du champ 
    Texte    	: in   String; 	--  le texte affich� en l�gende 
    Contenu   : in   String; 	--  le contenu initial du champ 
    X, 	  	 	 	--  abscisse du coin HG du champ 
    Y      	: in   Natural; 	--  ordonn�e du coin HG du champ 
    Largeur,    	 	 	--  largeur du champ 
    Hauteur  	: in   Positive  ); 	--  hauteur du champ 
 
 -- ajouter une zone de texte avec ascenseur ---------------------------------   procedure AjouterTexteAscenseur (        
    F      	: in out TR_Fenetre; 	-- la fen�tre o� on ajoute 
    NomElement  : in   String; 	-- le nom de la zone de texte 
    Texte    	: in   String; 	-- le texte affich� en l�gende 
    Contenu   : in   String; 	-- le contenu de la zone 
    X,  	   	 	--  abscisse du coin HG de la zone 
    Y      	: in   Natural; 	-- abscisse du coin HG de la zone 
    Largeur, 	   	 	-- largeur de la zone de texte 
    Hauteur   : in   Positive  ); 	-- hauteur de la zone de texte 
  
 -- ajouter une horloge analogique -------------------------------------------  procedure AjouterHorlogeAna (           
    F      	: in out TR_Fenetre; 	-- la fen�tre o� on joute 
    NomElement  : in   String; 	-- le nom de l'horloge 
    Texte    	: in   String; 	-- le texte affich� en l�gende 
    X,  	   	 	--  abscisse du coin HG  
    Y      	: in    	Natural; 	--  ordonn�e du coin HG  
    Largeur, 	   	 	--  largeur 
    Hauteur   : in   Positive  ); 	-- hauteur 
 
 -- ajouter une horloge digitale --------------------------------------------  procedure AjouterHorlogeDigi (           
    F      	: in out TR_Fenetre; 	-- la fen�tre o� on joute 
    NomElement  : in   String; 	-- le nom de l'horloge 
    Texte    	: in   String; 	-- le texte affich� en l�gende 
    X,  	  	 	 	--  abscisse du coin HG  
    Y      	: in   Natural; 	--  ordonn�e du coin HG  
    Largeur, 	  	 	 	--  largeur 
    Hauteur   : in   Positive  ); 	-- hauteur 
 
  
 
 -- ajouter un minuteur ----------------------------------------------------  procedure AjouterMinuteur (            
    F      	: in out TR_Fenetre; 	-- la fen�tre o� on ajoute 
    NomElement  : in   String; 	--  le nom du minuteur 
    Texte    	: in   String; 	-- le texte affich� en l�gende 
    X,  	     	 	-- abscisse du coin HG  
    Y      	: in   Natural; 	-- ordonn�e du coin HG  
    Largeur, 	     	 	-- largeur 
    Hauteur   	: in   Positive  ); 	-- hauteur 
 
 -- ajouter un chronom�tre ----------------------------------------------------  procedure AjouterChrono (            
    F      	: in out TR_Fenetre; 	-- la fen�tre o� on ajoute 
    NomElement  : in   String; 	--  le nom du chronom�tre 
    Texte    	: in   String; 	-- le texte affich� en l�gende 
    X,  	     	 	--  abscisse du coin HG  
    Y      	: in   Natural; 	--  ordonn�e du coin HG  
    Largeur, 	     	 	--  largeur 
    Hauteur   	: in   Positive  ); 	-- hauteur 
 
 -- ajouter une image --------------------------------------------------------  procedure AjouterImage (            
    F   	: in out TR_Fenetre; 	--  la fen�tre o� on ajoute 
    NomElement : in   String; 	--  le nom de l'�l�ment 
   NomImage : in  String; 	-- le nom de l'image 
    Text 	: in   String; 	--  le texte affich� en l�gende, en bas de l'image 
    X,  	     	 	--  son abscisse en pixels 
    Y      	: in   Natural; 	--  son ordonn�e en pixels 
    Largeur, 	     	 	--  largeur 
    Hauteur   	: in   Positive  ); 	-- hauteur 
 ------------------------------------------------------------------------------ 
 -- primitives d'acc�s � un �l�ment graphique existant 
 ------------------------------------------------------------------------------  -- r�cup�rer le nom du bouton cliqu� ----------------------------------------  function AttendreBouton (            
    F   	: in   TR_Fenetre )     	--  nom de la fen�tre 
  return String;                	--  R�sultat = nom du bouton press�  
 -- r�cup�rer le contenu d'un champ de saisie --------------------------------  function ConsulterContenu (           
    F      	: in   TR_Fenetre;      	--  nom de la fen�tre 
    NomElement  : in   String   )     	--  nom du champ de saisie 
  return String;               	--  R�sultat : la cha�ne saisie ! 
 
 -- r�cup�rer le temps r�siduel d'un minuteur --------------------------------  function ConsulterTimer (            
    F      	: in   TR_Fenetre;      	-- nom de la fen�tre 
    NomElement  : in   String   )     	--  nom du minuteur 
  return Float;                 	--  R�sultat : le temps restant ! 
 
 -- r�cup�rer l'�tat d'une bo�te � cocher ou d'un bouton radio ---------------  function ConsulterEtatBCRB (           	 
    F      : in   TR_Fenetre; --  nom de la fen�tre     NomElement  : in   String   ) --  nom de l'�l�ment 
  return boolean;     	 	--  R�sultat :true si coch�, false sinon 
 ------------------------------------------------------------------------------ 
 -- primitives de modification du comportement d'�l�ments graphiques existants 
 ------------------------------------------------------------------------------  -- rendre visible une fen�tre ------------------------------------------------  procedure MontrerFenetre (           
    F   	: in   TR_Fenetre ); 	--  nom de la fen�tre 
 
 -- masquer une fen�tre -------------------------------------------------------  procedure CacherFenetre (            
    F   	: in   TR_Fenetre ); 	--  nom de la fen�tre 
     
 -- rendre visible un �l�ment graphique cach� jusque l� ----------------------  procedure MontrerElem (            	 
    F      	: in out TR_Fenetre; 	--  nom de la fen�tre 
    NomElement  : in   String ); 	--  nom de l'�l�ment 
 
 -- rendre invisible un �l�ment graphique jusque-l� visible ------------------  procedure CacherElem (            	 
    F      	: in out TR_Fenetre; 	--  nom de la fen�tre 
    NomElement  : in   String ); 	--  nom de l'�l�ment 
 
 -- activer ou d�sactiver un bouton -----------------------------------------  procedure ChangerEtatBouton (          
    F      	: in out TR_Fenetre;     	--  nom de la fen�tre 
    NomElement  : in   String;       	--  nom du bouton 
    Etat     	: in   T_EtatBouton );   	--  valeur : marche (cliquable) ou arret (d�sactiv�) 
  
 	 
 -- forcer l'�tat d'un bouton radio -----------------------------------------  procedure ChangerEtatBoutonRadio (       
    F      	: in out TR_Fenetre; 	--  nom de la fen�tre 
    NomElement  	: in   String; 	--  nom du bouton 
    Etat     	: in   Boolean   ); 	--  valeur : true (coch�) ou false (non coch�) 
 
 -- forcer l'�tat d'une bo�te � cocher ----------------------------------------  procedure ChangerEtatBoiteCocher (       
    F      	: in out TR_Fenetre; 	--  nom de la fen�tre 
    NomElement  	: in   String; 	--  nom de la bo�te � cocher 
    Etat     	: in   Boolean   ); 	--  valeur : true (coch�) ou false (non coch�) 
 
  -- passer d'un mode minuteur � un mode chronom�tre --------------------------- 
 -- le temps s'incr�mente au lieu de se d�cr�menter 
  procedure ChangerMinuteurEnChrono (        
    F   	: in out TR_Fenetre; 	-- nom de la fen�tre 
    NomElement 	: in   String  ); 	-- nom de l'�l�ment 
 
  -- passer d'un mode chronom�tre � un mode minuteur --------------------------- 
 -- le temps se d�cr�mente au lieu de s'incr�menter  procedure ChangerChronoEnMinuteur(        
    F   	: in out TR_Fenetre;   	-- nom de la fen�tre     NomElement 	: in   String  ); 	-- nom de l'�l�ment 
 
  -- mettre en pause en timer en marche ----------------------------------------  procedure PauseTimer (             
    F   	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement 	: in   String  ); 	-- nom de l'�l�ment 
 
  -- mettre en marche en timer en pause ----------------------------------------  procedure RepriseTimer (            
    F   	: in out TR_Fenetre; 	-- nom de la fen�tre 
    NomElement 	: in   String  ); 	-- nom de l'�l�ment 
 ------------------------------------------------------------------------------ 
 -- primitives de modification de l'apparence ou du contenu d'un �l�ment 
 ------------------------------------------------------------------------------  -- modifier la couleur du fond d'un �l�ment grapique -------------------------  procedure ChangerCouleurFond (         
    F         	 : in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement     : in   String;     	-- nom de l'�l�ment 
    NouvelleCouleur  : in   T_Couleur  );  	-- La nouvelle couleur ! 
 
 -- modifier la couleur du label d'un �l�ment ou d'un texte fixe ------------- 
 procedure ChangerCouleurTexte (        	 
    F         	 : in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement     : in   String;     	-- nom de l'�l�ment 
    NouvelleCouleur  : in   T_Couleur  );  	-- La nouvelle couleur ! 
 
 -- modifier le style du label d'un �l�ment ou d'un texte fixe --------------- 
 procedure ChangerStyleTexte (         	 
    F         	: in out TR_Fenetre; 	-- nom de la fen�tre 
    NomElement    : in   String;     	-- nom de l'�l�ment 
    NouveauStyle : in   FL_TEXT_STYLE  ); 	-- Le nouveau style ! 
 
 -- modifier la taille du label d'un �l�ment ou d'un texte fixe --------------  procedure ChangerTailleTexte (         
    F        	: in out TR_Fenetre; 	-- nom de la fen�tre 
    NomElement    : in   String; 	-- nom de l'�l�ment 
    Taille 	: in   X11.Int  ); 	-- La nouvelle taille ! 
 
 -- modifier l'alignement du label d'un �l�ment ou d'un texte fixe ------------  procedure ChangerAlignementTexte (       
    F        	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement    : in   String;     	-- nom de l'�l�ment 
    Alignement    : in   FL_ALIGN  );  	-- Le nouvel alignement ! 
 
 -- modifier le label d'un �l�ment graphique ou la valeur d'un texte fixe------  procedure ChangerTexte (            
    F       	: in out TR_Fenetre;     	-- nom de la fen�tre 
    NomElement   : in   String;       	-- Le nom de l'�l�ment � modifier 
    NouveauTexte  : in   String   );   -- La nouvelle valeur de l�gende   
 -- modifier le style du contenu d'une zone de texte ascenseur ----------------  procedure ChangerStyleContenu (         
    F         	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement    : in   String;     	-- nom de la zone de texte     NouveauStyle  : in   FL_TEXT_STYLE  ); 	-- Le nouveau style ! 
 
 -- modifier la taille du contenu d'une zone de texte ascenseur ---------------  procedure ChangerTailleContenu (        
    F         	: in out TR_Fenetre; 	-- nom de la fen�tre 
    NomElement    : in   String; 	-- nom de l'�l�ment 
    Taille  	: in   X11.Int  ); 	-- La nouvelle taille ! 
 
  
 
-- modifier le contenu d'un champ de saisie ou d'une zone de texte ascenseur---  procedure ChangerContenu (           
    F        	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement    : in   String;     	-- nom de l'�l�ment 
    NouveauContenu : in   String   );  	-- La nouvelle valeur de contenu 
 
 -- effacer le contenu d'un champ de saisie ou d'une zone de texte ascenseur---  procedure EffacerContenu (           
    F   	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement 	: in   String   ); 	-- nom de l'�l�ment 
 
 -- ajouter une nouvelle ligne dans une zone de texte avec ascenseur------------  procedure AjouterNouvelleLigne (        
    F         	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement    : in   String;     	-- nom de l'�l�ment 
    NouvelleLigne  : in   String   );  	-- Le contenu de la nouvelle ligne  
 -- modifier une ligne dans une zone de texte avec ascenseur-------------------  procedure ChangerLigne (            
    F         	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement    : in   String;     	-- nom de l'�l�ment 
    NumeroLigne    : in   Natural;     	-- num�ro de ligne � modifier 
    NouveauTexte   : in   String   );  	-- Le nouveau contenu de la ligne  
 -- supprimer une ligne dans une zone de texte avec ascenseur------------------  procedure SupprimerLigne (           
    F         	: in out TR_Fenetre;   	-- nom de la fen�tre 
    NomElement    : in   String;     	-- nom de l'�l�ment 
    NumeroLigne    : in   Natural   );  	-- Le num�ro de ligne � supprimer  
 -- changer la dur�e du temps r�siduel d'un minuteur --------------------------  procedure ChangerTempsMinuteur (          
    F         	: in out TR_Fenetre; 	-- nom de la fen�tre     NomElement    : in   String; 	--  nom du minuteur 
    NouveauTemps  :  in   Float  );  	-- La dur�e du d�compte ! 
 
 -- changer l'image d'un bouton image ----------------------------------------- 
 procedure ChangerImageBouton (        	 
    F   	: in out TR_Fenetre; 	-- nom de la fen�tre 
    NomElement  	: in   String; 	-- nom de l'�l�ment 
    NomImage 	: in   String  ); 	-- nom de la nouvelle image d�cor 
 
 -- changer l'image d'un bouton image ----------------------------------------- 
 procedure ChangerImage (        	    
    F   	: in out TR_Fenetre; 	-- nom de la fen�tre 
    NomElement  	: in   String; 	-- nom de l'�l�ment 
    NomImage 	: in   String   ); 	-- nom de la nouvelle image  
 ------------------------------------------------------------------------------ 
 -- Autre primitive : tester l�utilisation du click droit de la souris 
 ------------------------------------------------------------------------------  function ClickDroit return boolean; -- vrai si on a press� le bouton droit de la souris  ------------------------------------------------------------------------------ 
 end p_fenbase; 
