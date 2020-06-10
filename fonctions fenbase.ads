with Forms; use Forms; 
with Interfaces.C;use Interfaces.C; 
package p_fenbase is 
 ------------------------------------------------------------------------------  -- types à connaître pour utiliser le paquetage 
  ------------------------------------------------------------------------------  type  TA_String is access String;    -- pointeur sur une chaîne de caractères  type  TR_Fenetre;            -- une fenêtre de l'interface graphique  type  T_EtatBouton is (Marche, Arret); -- état d'un bouton (actif ou inactif)  subtype T_Couleur is FL_COLOR;      -- couleurs disponibles dans le paquetage forms 
   	--  FL_BLACK, FL_RED, FL_GREEN, FL_YELLOW, FL_BLUE, FL_MAGENTA, FL_CYAN, 
   	--  FL_WHITE, FL_TOMATO, FL_INDIANRED, FL_SLATEBLUE, FL_COL1, FL_RIGHT_BCOL, FL_BOTTOM_BCOL, 
   	--  FL_TOP_BCOL, FL_LEFT_BCOL, FL_MCOL, FL_INACTIVE, FL_PALEGREEN, FL_DARKGOLD, 
   	--  FL_ORCHID, FL_DARKCYAN, FL_DARKTOMATO, FL_WHEAT, FL_DARKORANGE, FL_DEEPPINK, 
   	--  FL_CHARTREUSE, FL_DARKVIOLET, FL_SPRINGGREEN, FL_DODGERBLUE 
 ------------------------------------------------------------------------------  -- types internes au paquetage, inutile de les connaître ! 
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
 -- Initialisation du mode graphique, définition fenêtres et groupes d'éléments 
 ------------------------------------------------------------------------------  -- initialiser le mode graphique ---------------------------------------------  procedure InitialiserFenetres; 
 
 -- définir une nouvelle fenêtre ---------------------------------------------- 
 function DebutFenetre (Titre: in String; Largeur, Hauteur in Positive) return TR_Fenetre;              	-- résultat : la fenêtre créée  
 
 
 -- terminer la définition d'une nouvelle fenêtre ----------------------------- 
 procedure FinFenetre (F: in TR_Fenetre );   -- nom de la fenêtre 
 
 -- définir un groupe d'éléments graphiques -----------------------------------  
 procedure DebutGroupe (F: in out TR_Fenetre; 	-- la fenêtre du groupe     NomGroupe : in   String ); 	-- le nom du groupe 
 
  -- terminer un groupe d'éléments --------------------------------------------  procedure FinGroupe;             -- clôt le groupe précédemment défini  ------------------------------------------------------------------------------ 
 -- primitives d'ajout d'éléments graphiques dans une fenêtre déjà définie 
 ------------------------------------------------------------------------------  -- ajouter un bouton de forme rectangulaire ----------------------------------  
 procedure AjouterBouton (
    F: in out TR_Fenetre; 	-- la fenêtre où on ajoute 
    NomElement : in   String; 	-- le nom du bouton (unique) 
    Texte : in   String;       	-- le texte affiché dans le bouton 
    X, 	-- abscisse coin HG en pixels 
    Y : in   Natural;       	-- ordonnée coin HG en pixels 
    Largeur,                 	-- largeur du bouton en pixels 
    Hauteur   : in   Positive; 	--  hauteur du bouton en pixels 
    TypeBouton : in   FL_Button_Type := FL_NORMAL_BUTTON); -- type du bouton (optionnel) 
    -- types de boutons : cf documentation XForms 
    -- FL_NORMAL_BUTTON (retourne une valeur quand relâché) 
    -- FL_PUSH_BUTTON (retourne une valeur si relâché, reste enfoncé jusqu'à nouveau clic)  
    -- FL_MENU_BUTTON (retourne une valeur quand pressé) 
    -- FL_TOUCH_BUTTON (retourne une valeur tant que l'utilisateur le presse) 
    -- FL_RETURN_BUTTON (bouton classique mais qui réagit à la touche ENTER du clavier) -- ajouter un bouton de forme circulaire -------------------------------------  procedure AjouterBoutonRond (          
    F      	: in out TR_Fenetre;     	-- la fenêtre où on ajoute 
    NomElement : in   String;       	-- le nom du bouton (unique) 
    Texte    : in   String;       	-- le texte affiché dans le bouton 
    X 	   	 	 	-- abscisse coin HG du carré englobant en pixels 
    Y      	: in   Natural;       	-- ordonnée coin HG du carré englobant en pixels 
    Diam     : in   Positive  );   	-- diamètre du bouton en pixels 
 
 
 -- ajouter une boîte à cocher ------------------------------------------------  procedure AjouterBoiteCocher (         
    F      	: in out TR_Fenetre;     	-- la fenêtre où on ajoute 
    NomElement : in   String; 	-- le nom de la boîte à cocher (unique) 
    Texte    : in   String;       	-- le texte affiché en légende 
    X, 	  	 	-- abscisse coin HG rectangle englobant en pixels 
    Y      	: in   Natural;   	-- ordonnée coin HG rectangle englobant en pixels 
    Largeur,   	 	--  sa largeur en pixels 
    Hauteur   : in   Positive  ); 	-- sa hauteur en pixels 
 
 -- ajouter un bouton radio ---------------------------------------------------  procedure AjouterBoutonRadio (         
    F   	: in out TR_Fenetre;    	-- la fenêtre où on ajoute 
    NomElement : in   String; 	-- le nom du bouton radio (unique) 
    Texte 	: in   String;       	-- le texte affiché en légende 
    X,  	 	  	 	-- abscisse coin HG du carré englobant en pixels 
    Y   	: in   Natural;   	-- ordonnée coin HG du carré englobant en pixels 
    Diam 	: in  Positive; 	-- son diamètre en pixels 
    Actif 	: in   Boolean := false); 	--  inactivé par défaut 
   -- NOTE : un bouton radion est intéressant dans un groupe d'autres boutons radio  
 -- ajouter un bouton décoré d'une image (format XPM) ------------------------  procedure AjouterBoutonImage (         
    F   	: in out TR_Fenetre;     	-- la fenêtre où on ajoute 
    NomElement : in   String; 	-- le nom du bouton (unique) 
    Texte 	: in   String;       	-- le texte affiché en légende 
  NomImage : in  String; 	-- le nom de l'image décor 
    X,  	 	  	 	--  abscisse du bouton en pixels 
    Y      	: in   Natural; 	-- ordonnée du bouton en pixels 
    Largeur,  	  	 	-- largeur du bouton en pixels 
    Hauteur   : in   Positive  ); 	-- hauteur du bouton en pixels 
 
 -- ajouter une zone de texte non modifiable ----------------------------------   procedure AjouterTexte (            
    F      	: in out TR_Fenetre; 	-- la fenêtre où on ajoute 
    NomElement  : in   String; 	-- le nom de la zone de texte 
    Texte    : in   String; 	-- son contenu 
    X,  	  	 	 	--  abscisse du coin HG de la zone de texte 
    Y      	: in   Natural; 	--  ordonnée du coin HG de la zone de texte 
    Largeur,   	 	 	-- largeur de la zone de texte 
    Hauteur   : in   Positive  ); 	-- hauteur de la zone de texte 
 
 -- ajouter un champ de saisie -----------------------------------------------   procedure AjouterChamp (            
    F      	: in out TR_Fenetre; 	--  la fenêtre où on ajoute 
    NomElement  : in   String; 	--  le nom du champ 
    Texte    	: in   String; 	--  le texte affiché en légende 
    Contenu   : in   String; 	--  le contenu initial du champ 
    X, 	  	 	 	--  abscisse du coin HG du champ 
    Y      	: in   Natural; 	--  ordonnée du coin HG du champ 
    Largeur,    	 	 	--  largeur du champ 
    Hauteur  	: in   Positive  ); 	--  hauteur du champ 
 
 -- ajouter une zone de texte avec ascenseur ---------------------------------   procedure AjouterTexteAscenseur (        
    F      	: in out TR_Fenetre; 	-- la fenêtre où on ajoute 
    NomElement  : in   String; 	-- le nom de la zone de texte 
    Texte    	: in   String; 	-- le texte affiché en légende 
    Contenu   : in   String; 	-- le contenu de la zone 
    X,  	   	 	--  abscisse du coin HG de la zone 
    Y      	: in   Natural; 	-- abscisse du coin HG de la zone 
    Largeur, 	   	 	-- largeur de la zone de texte 
    Hauteur   : in   Positive  ); 	-- hauteur de la zone de texte 
  
 -- ajouter une horloge analogique -------------------------------------------  procedure AjouterHorlogeAna (           
    F      	: in out TR_Fenetre; 	-- la fenêtre où on joute 
    NomElement  : in   String; 	-- le nom de l'horloge 
    Texte    	: in   String; 	-- le texte affiché en légende 
    X,  	   	 	--  abscisse du coin HG  
    Y      	: in    	Natural; 	--  ordonnée du coin HG  
    Largeur, 	   	 	--  largeur 
    Hauteur   : in   Positive  ); 	-- hauteur 
 
 -- ajouter une horloge digitale --------------------------------------------  procedure AjouterHorlogeDigi (           
    F      	: in out TR_Fenetre; 	-- la fenêtre où on joute 
    NomElement  : in   String; 	-- le nom de l'horloge 
    Texte    	: in   String; 	-- le texte affiché en légende 
    X,  	  	 	 	--  abscisse du coin HG  
    Y      	: in   Natural; 	--  ordonnée du coin HG  
    Largeur, 	  	 	 	--  largeur 
    Hauteur   : in   Positive  ); 	-- hauteur 
 
  
 
 -- ajouter un minuteur ----------------------------------------------------  procedure AjouterMinuteur (            
    F      	: in out TR_Fenetre; 	-- la fenêtre où on ajoute 
    NomElement  : in   String; 	--  le nom du minuteur 
    Texte    	: in   String; 	-- le texte affiché en légende 
    X,  	     	 	-- abscisse du coin HG  
    Y      	: in   Natural; 	-- ordonnée du coin HG  
    Largeur, 	     	 	-- largeur 
    Hauteur   	: in   Positive  ); 	-- hauteur 
 
 -- ajouter un chronomètre ----------------------------------------------------  procedure AjouterChrono (            
    F      	: in out TR_Fenetre; 	-- la fenêtre où on ajoute 
    NomElement  : in   String; 	--  le nom du chronomètre 
    Texte    	: in   String; 	-- le texte affiché en légende 
    X,  	     	 	--  abscisse du coin HG  
    Y      	: in   Natural; 	--  ordonnée du coin HG  
    Largeur, 	     	 	--  largeur 
    Hauteur   	: in   Positive  ); 	-- hauteur 
 
 -- ajouter une image --------------------------------------------------------  procedure AjouterImage (            
    F   	: in out TR_Fenetre; 	--  la fenêtre où on ajoute 
    NomElement : in   String; 	--  le nom de l'élément 
   NomImage : in  String; 	-- le nom de l'image 
    Text 	: in   String; 	--  le texte affiché en légende, en bas de l'image 
    X,  	     	 	--  son abscisse en pixels 
    Y      	: in   Natural; 	--  son ordonnée en pixels 
    Largeur, 	     	 	--  largeur 
    Hauteur   	: in   Positive  ); 	-- hauteur 
 ------------------------------------------------------------------------------ 
 -- primitives d'accès à un élément graphique existant 
 ------------------------------------------------------------------------------  -- récupérer le nom du bouton cliqué ----------------------------------------  function AttendreBouton (            
    F   	: in   TR_Fenetre )     	--  nom de la fenêtre 
  return String;                	--  Résultat = nom du bouton pressé  
 -- récupérer le contenu d'un champ de saisie --------------------------------  function ConsulterContenu (           
    F      	: in   TR_Fenetre;      	--  nom de la fenêtre 
    NomElement  : in   String   )     	--  nom du champ de saisie 
  return String;               	--  Résultat : la chaîne saisie ! 
 
 -- récupérer le temps résiduel d'un minuteur --------------------------------  function ConsulterTimer (            
    F      	: in   TR_Fenetre;      	-- nom de la fenêtre 
    NomElement  : in   String   )     	--  nom du minuteur 
  return Float;                 	--  Résultat : le temps restant ! 
 
 -- récupérer l'état d'une boîte à cocher ou d'un bouton radio ---------------  function ConsulterEtatBCRB (           	 
    F      : in   TR_Fenetre; --  nom de la fenêtre     NomElement  : in   String   ) --  nom de l'élément 
  return boolean;     	 	--  Résultat :true si coché, false sinon 
 ------------------------------------------------------------------------------ 
 -- primitives de modification du comportement d'éléments graphiques existants 
 ------------------------------------------------------------------------------  -- rendre visible une fenêtre ------------------------------------------------  procedure MontrerFenetre (           
    F   	: in   TR_Fenetre ); 	--  nom de la fenêtre 
 
 -- masquer une fenêtre -------------------------------------------------------  procedure CacherFenetre (            
    F   	: in   TR_Fenetre ); 	--  nom de la fenêtre 
     
 -- rendre visible un élément graphique caché jusque là ----------------------  procedure MontrerElem (            	 
    F      	: in out TR_Fenetre; 	--  nom de la fenêtre 
    NomElement  : in   String ); 	--  nom de l'élément 
 
 -- rendre invisible un élément graphique jusque-là visible ------------------  procedure CacherElem (            	 
    F      	: in out TR_Fenetre; 	--  nom de la fenêtre 
    NomElement  : in   String ); 	--  nom de l'élément 
 
 -- activer ou désactiver un bouton -----------------------------------------  procedure ChangerEtatBouton (          
    F      	: in out TR_Fenetre;     	--  nom de la fenêtre 
    NomElement  : in   String;       	--  nom du bouton 
    Etat     	: in   T_EtatBouton );   	--  valeur : marche (cliquable) ou arret (désactivé) 
  
 	 
 -- forcer l'état d'un bouton radio -----------------------------------------  procedure ChangerEtatBoutonRadio (       
    F      	: in out TR_Fenetre; 	--  nom de la fenêtre 
    NomElement  	: in   String; 	--  nom du bouton 
    Etat     	: in   Boolean   ); 	--  valeur : true (coché) ou false (non coché) 
 
 -- forcer l'état d'une boîte à cocher ----------------------------------------  procedure ChangerEtatBoiteCocher (       
    F      	: in out TR_Fenetre; 	--  nom de la fenêtre 
    NomElement  	: in   String; 	--  nom de la boîte à cocher 
    Etat     	: in   Boolean   ); 	--  valeur : true (coché) ou false (non coché) 
 
  -- passer d'un mode minuteur à un mode chronomètre --------------------------- 
 -- le temps s'incrémente au lieu de se décrémenter 
  procedure ChangerMinuteurEnChrono (        
    F   	: in out TR_Fenetre; 	-- nom de la fenêtre 
    NomElement 	: in   String  ); 	-- nom de l'élément 
 
  -- passer d'un mode chronomètre à un mode minuteur --------------------------- 
 -- le temps se décrémente au lieu de s'incrémenter  procedure ChangerChronoEnMinuteur(        
    F   	: in out TR_Fenetre;   	-- nom de la fenêtre     NomElement 	: in   String  ); 	-- nom de l'élément 
 
  -- mettre en pause en timer en marche ----------------------------------------  procedure PauseTimer (             
    F   	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement 	: in   String  ); 	-- nom de l'élément 
 
  -- mettre en marche en timer en pause ----------------------------------------  procedure RepriseTimer (            
    F   	: in out TR_Fenetre; 	-- nom de la fenêtre 
    NomElement 	: in   String  ); 	-- nom de l'élément 
 ------------------------------------------------------------------------------ 
 -- primitives de modification de l'apparence ou du contenu d'un élément 
 ------------------------------------------------------------------------------  -- modifier la couleur du fond d'un élément grapique -------------------------  procedure ChangerCouleurFond (         
    F         	 : in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement     : in   String;     	-- nom de l'élément 
    NouvelleCouleur  : in   T_Couleur  );  	-- La nouvelle couleur ! 
 
 -- modifier la couleur du label d'un élément ou d'un texte fixe ------------- 
 procedure ChangerCouleurTexte (        	 
    F         	 : in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement     : in   String;     	-- nom de l'élément 
    NouvelleCouleur  : in   T_Couleur  );  	-- La nouvelle couleur ! 
 
 -- modifier le style du label d'un élément ou d'un texte fixe --------------- 
 procedure ChangerStyleTexte (         	 
    F         	: in out TR_Fenetre; 	-- nom de la fenêtre 
    NomElement    : in   String;     	-- nom de l'élément 
    NouveauStyle : in   FL_TEXT_STYLE  ); 	-- Le nouveau style ! 
 
 -- modifier la taille du label d'un élément ou d'un texte fixe --------------  procedure ChangerTailleTexte (         
    F        	: in out TR_Fenetre; 	-- nom de la fenêtre 
    NomElement    : in   String; 	-- nom de l'élément 
    Taille 	: in   X11.Int  ); 	-- La nouvelle taille ! 
 
 -- modifier l'alignement du label d'un élément ou d'un texte fixe ------------  procedure ChangerAlignementTexte (       
    F        	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement    : in   String;     	-- nom de l'élément 
    Alignement    : in   FL_ALIGN  );  	-- Le nouvel alignement ! 
 
 -- modifier le label d'un élément graphique ou la valeur d'un texte fixe------  procedure ChangerTexte (            
    F       	: in out TR_Fenetre;     	-- nom de la fenêtre 
    NomElement   : in   String;       	-- Le nom de l'élément à modifier 
    NouveauTexte  : in   String   );   -- La nouvelle valeur de légende   
 -- modifier le style du contenu d'une zone de texte ascenseur ----------------  procedure ChangerStyleContenu (         
    F         	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement    : in   String;     	-- nom de la zone de texte     NouveauStyle  : in   FL_TEXT_STYLE  ); 	-- Le nouveau style ! 
 
 -- modifier la taille du contenu d'une zone de texte ascenseur ---------------  procedure ChangerTailleContenu (        
    F         	: in out TR_Fenetre; 	-- nom de la fenêtre 
    NomElement    : in   String; 	-- nom de l'élément 
    Taille  	: in   X11.Int  ); 	-- La nouvelle taille ! 
 
  
 
-- modifier le contenu d'un champ de saisie ou d'une zone de texte ascenseur---  procedure ChangerContenu (           
    F        	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement    : in   String;     	-- nom de l'élément 
    NouveauContenu : in   String   );  	-- La nouvelle valeur de contenu 
 
 -- effacer le contenu d'un champ de saisie ou d'une zone de texte ascenseur---  procedure EffacerContenu (           
    F   	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement 	: in   String   ); 	-- nom de l'élément 
 
 -- ajouter une nouvelle ligne dans une zone de texte avec ascenseur------------  procedure AjouterNouvelleLigne (        
    F         	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement    : in   String;     	-- nom de l'élément 
    NouvelleLigne  : in   String   );  	-- Le contenu de la nouvelle ligne  
 -- modifier une ligne dans une zone de texte avec ascenseur-------------------  procedure ChangerLigne (            
    F         	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement    : in   String;     	-- nom de l'élément 
    NumeroLigne    : in   Natural;     	-- numéro de ligne à modifier 
    NouveauTexte   : in   String   );  	-- Le nouveau contenu de la ligne  
 -- supprimer une ligne dans une zone de texte avec ascenseur------------------  procedure SupprimerLigne (           
    F         	: in out TR_Fenetre;   	-- nom de la fenêtre 
    NomElement    : in   String;     	-- nom de l'élément 
    NumeroLigne    : in   Natural   );  	-- Le numéro de ligne à supprimer  
 -- changer la durée du temps résiduel d'un minuteur --------------------------  procedure ChangerTempsMinuteur (          
    F         	: in out TR_Fenetre; 	-- nom de la fenêtre     NomElement    : in   String; 	--  nom du minuteur 
    NouveauTemps  :  in   Float  );  	-- La durée du décompte ! 
 
 -- changer l'image d'un bouton image ----------------------------------------- 
 procedure ChangerImageBouton (        	 
    F   	: in out TR_Fenetre; 	-- nom de la fenêtre 
    NomElement  	: in   String; 	-- nom de l'élément 
    NomImage 	: in   String  ); 	-- nom de la nouvelle image décor 
 
 -- changer l'image d'un bouton image ----------------------------------------- 
 procedure ChangerImage (        	    
    F   	: in out TR_Fenetre; 	-- nom de la fenêtre 
    NomElement  	: in   String; 	-- nom de l'élément 
    NomImage 	: in   String   ); 	-- nom de la nouvelle image  
 ------------------------------------------------------------------------------ 
 -- Autre primitive : tester l’utilisation du click droit de la souris 
 ------------------------------------------------------------------------------  function ClickDroit return boolean; -- vrai si on a pressé le bouton droit de la souris  ------------------------------------------------------------------------------ 
 end p_fenbase; 
