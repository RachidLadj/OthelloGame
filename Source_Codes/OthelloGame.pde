import processing.sound.*;
import controlP5.*;
int Prof = 5;
PrintWriter output;
BufferedReader reader;
PImage img, img1;
boolean bool = false;
boolean jouer= true;
boolean actu = false;
int w, h, i, j, stepx, stepy, xx, yy;
int joueur, machine, joueuractuel;
int cpt = 0;
ControlP5 cp1;
ControlP5 cp2;
ControlP5 cp3;
ControlP5 cp4;
int myColor = color(255);
Button b, b2, b3;
SoundFile file; 

int [][]mat=
  { {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 1, 2, 0, 0, 0}, 
  {0, 0, 0, 2, 1, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0}};

int [][]poids=
  {{ 8, -2, 3, 3, 3, 3, -2, 8}, 
  {-2, -2, 2, 2, 2, 2, -2, -2}, 
  { 3, 2, 1, 1, 1, 1, 2, 3}, 
  { 3, 2, 1, 1, 1, 1, 2, 3}, 
  { 3, 2, 1, 1, 1, 1, 2, 3}, 
  { 3, 2, 1, 1, 1, 1, 2, 3}, 
  {-2, -2, 2, 2, 2, 2, -2, -2}, 
  { 8, -2, 3, 3, 3, 3, -2, 8}};

int [][]matrice;

void setup() {
  img=loadImage("Image.jpg");
  size(1120, 800);
  smooth(8);
  matrice = Clone(mat);
  img1 = createImage(715, 715, ARGB); //pour la grille
  w=img1.width;
  h=img1.height;
  stepx=w/8;
  stepy=h/8;
  file =new SoundFile(this, "Music.mp3");
  file.play();
  file.loop();
  //file.jump(2);
  interfaceOthello(); //placer les boutons
  println("Le joueur qui devra jouer en premier est : "+joueur);
}

void draw() {
  debdraw();
  if (cpt == 2) {
    finPartie(); //les 2 ne peuvent plus jouer
  } else {     // cpt != 2
    if (joueuractuel != 0) { //ya machine ya humain
      if (joueuractuel == machine) {  // si c machine
        if (!peutjouer(joueuractuel, matrice)) {
          cpt++;
          bool = true;
          //changement de joueur s'il n'a pas de jeu et c le tour au joueur
          joueuractuel = joueuractuel%2+1;
        } else {
          cpt = 0;
          // Algorithme Intelliengent
          if (!bool)

            machine();
        }
      } else { // si c humain
        if (!peutjouer(joueuractuel, matrice)) {
          cpt++;
          joueuractuel = joueuractuel%2+1;
        }
      }
    }
  } 
  actualiserAffichage();
}






//// ******************************    L'interface ed othllo pour lancer le jeu et le PLAY AGAIN    ****************************** ////
void debdraw() {
  image(img, 0, 0);
  image(img1, 40, 40);
  //la grille
  strokeWeight(1);
  for (int i =0; i<8; i++) {
    for (int j=0; j<8; j++) {
      fill(0, 0, 0, 130);
      noStroke();
      rect(i*90+40, j*90+40, 85, 85, 3);
    }
  }
}     


void interfaceOthello() {      // mettre à jour linterface a chaque fois
  joueuractuel=0;
  joueur=0;
  machine=0;
  cpt=0;
  for (int i=0; i<8; i++)
    for (int j=0; j<8; j++) {
      matrice[i][j] = mat[i][j];
    }

  //  carré qui encercle les edux boutons
  fill(30, 110);
  rect(700, 55, 250, 200, 7);

  //// Declaration des trois buttons
  cp1 = new ControlP5(this);
  cp2 = new ControlP5(this);
  cp3 = new ControlP5(this);

  b = cp1.addButton("JouerenPremier")  // Premier boutton
    .setValue(1)
    .setPosition(900, 90)
    .setSize(150, 50)
    .setColorBackground( color( 0, 0, 190) )
    .setCaptionLabel("Jouer en Premier");

  b2 = cp2.addButton("JouerenSecond")  // Deuxieme boutton
    .setValue(2)
    .setPosition(900, 170)
    .setSize(150, 50)
    .setColorBackground( color(0, 0, 190) )
    .setCaptionLabel("Jouer en Second");
  //autour du again
  fill(30, 110);
  rect(892, 610, 195, 70, 7);
  b3 = cp3.addButton("playAgain", 100)  // Troisieme boutton
    .setValue(3)
    .setPosition(900, 620)
    .setSize(180, 50)
    .setColorBackground( color( 100, 0, 195) )
    .setCaptionLabel("Play Again");
  b3.getCaptionLabel().setSize(30);
  //b3.getCaptionLabel().setFont(10);
  //// Fin declaration des trois bouttons

  // initialiser les jetons et le score
  actualiserAffichage();
}




//// ******************************    Actualiser laffichage en mettant a jour le score et les jetons    ****************************** ////
void actualiserAffichage() {
  for (int i=0; i<8; i++) 
    for (int j=0; j<8; j++) {
      if (matrice[i][j]!=0) {
        strokeWeight(4);
        if (matrice[i][j]==1) { //1 re présente le noir 
          fill(0, 0, 0, 150);
          noStroke();
          xx=90*i+82;
          yy=90*j+82;
          ellipse(xx, yy, 75, 75);
          fill(0, 0, 0, 255);
          ellipse(xx, yy, 65, 65);
        } else { //2 représente le blanc
          fill(255, 255, 255, 150);
          noStroke();
          xx=90*i+82;
          yy=90*j+82;
          ellipse(xx, yy, 75, 75);
          fill(255, 255, 255, 255);
          ellipse(xx, yy, 65, 65);
        }
      }
    }
  /*************************juste Affichage du scoree!********************/
  ArrayList<Integer> calculerBN = new ArrayList<Integer>(); 
  calculerBN = calcjetonsBN();
  if (calculerBN.get(0)>calculerBN.get(1)) {
    fill(255, 110);
    stroke(#51002C);
  } else {
    if (calculerBN.get(1)>calculerBN.get(0)) {
      fill(255, 110);
      stroke(205, 205, 225);
    } else {
      fill(255, 110);
      stroke(#51002C);
    }
  }
  //rectongle du score
  rect(835, 335, 200, 200, 9);
  /*score */  rect(855, 355, 160, 40, 9);
  fill (0);
  textSize(22);
  text("Score", 904, 382);
  textSize(20);
  text("Noir    : "+calculerBN.get(0), 890, 440);
  text("Blanc  : "+calculerBN.get(1), 891, 480);
  //  carré qui encercle les edux boutons
  fill(30, 110);
  rect(810, 55, 250, 200, 7);
  // Premier boutton

  b.setPosition(860, 90)
    .setSize(150, 50)
    .setColorBackground( color( 0, 0, 190) )
    .setCaptionLabel("Jouer en Premier");

  // Deuxieme boutton
  b2.setPosition(860, 170)
    .setSize(150, 50)
    .setColorBackground( color(0, 0, 190) )
    .setCaptionLabel("Jouer en Second");
  //;
  //autour du play again
  fill(30, 110);
  rect(842, 610, 200, 70, 7);
  // Troisieme boutton
  b3.setPosition(852, 620)
    .setSize(180, 50)
    .setColorBackground( color( 100, 0, 195) )
    .setCaptionLabel("Play Again");
  //// Fin des trois bouttons


  /****************Pour choisir le tour !****************/
  if (joueuractuel == 0) { //ce n'est pas choisi 
    fill(255, 0, 0);
    strokeWeight(5);
    //  coté noir qui encercle les edux boutons
    rect(810, 265, 250, 60, 7);
    fill(255);
    textSize(15);
    text("Veuillez Choisir votre tour SVP!", 821, 300);
  }

  /***********************Quand il joue à une case invalide ****************************/
  // impossble de jouer ici
  if (!jouer) {
    fill(255, 0, 0);
    strokeWeight(5);
    //  coté noir qui encercle les edux boutons
    rect(810, 265, 250, 60, 7);
    fill(255);
    textSize(15);
    text("Vous ne pouvez pas jouer ici", 830, 300);
  }
  bool = false;
}

void finPartie() {
  if (calcjetonsBN().get(0)>calcjetonsBN().get(1)) {
    stroke(#18a6b6); // BLANC
    fill(255, 0, 0);
    strokeWeight(5);
    rect(839, 265, 190, 60, 9);
    fill(255);
    textSize(15);
    if (joueur == 1)
      text("Le Gagnant est:\n    Le joueur", 880, 290);
    else
      text("Le Gagnant est:\n   La Machine", 880, 290);
  } else {
    stroke(255, 0, 0); 
    fill(#18a6b6); // blanc
    strokeWeight(5);
    rect(839, 265, 190, 60, 9);
    fill(255);
    textSize(15);
    if (calcjetonsBN().get(0)<calcjetonsBN().get(1)) {
      if (joueur == 1)
        text("Le Gagnant est:\n    La machine", 880, 290);
      else
        text("Le Gagnant est:\n   Le joueur", 880, 290);
    } else {
      stroke(#18a6a6); // blanc
      fill(0, 0, 0); 
      strokeWeight(5);
      rect(839, 265, 190, 60, 9);
      fill(255);
      textSize(15);
      text(" Aucun gagnant", 880, 290);
    }
  }
}





//// *************************  caldule du Nombre de jetons noirs et blancs    ************************* ////
ArrayList<Integer>calcjetonsBN() {
  ArrayList<Integer> test = new ArrayList<Integer>();
  int noir=0, blanc=0;
  for (int i = 0; i<8; i++) {
    for (int j = 0; j<8; j++) {
      if (matrice[i][j] == 1 ) {  // il peu au moins jouer a la position i et j
        noir++;
      }
      if (matrice[i][j] == 2 ) {  // il peu au moins jouer a la position i et j
        blanc++;
      }
    }
  }
  //CONTIENT QUE 2 CASES
  test.add(noir);
  test.add(blanc);
  return test;
}

/////////////////////////////////////////////////////////////////

//// ******************************  les successeurs///  reteurn les noeux voisins adverses   ****************************** ////
ArrayList <Integer> succ(int y, int z, int joueuractuel, int matrice2[][]) {  // les cases voisines avec couleur adverse
  ArrayList<Integer> succ = new ArrayList<Integer>();
  for (int i = y-1; i<=y+1; i++) {
    for (int j=z-1; j<=z+1; j++) {
      if (i>=0 && i<8 && j>=0 && j<8 && !(i==y && j==z)) {
        if (matrice2[i][j]==joueuractuel%2+1 /* joueuradverse */) { //si ce n'est pas les frantières (mur) et que ce n'est pas lui meme
          succ.add(i); //index de l'axe x
          succ.add(j); // index de l'axe y
        }
      }
    }
  }
  return succ;
}


//////////////////////////////

//// ********** retourne True si le voisins succx succy sont ok pour jouer a la position [x][y]    ********** ////
boolean comparer(int x, int y, int succx, int succy, int joueuractuel, int [][]matrice2) {
  int a, b, succi, succj; 
  boolean bool = false;
  a= succx - x;
  b= succy - y;
  succi = succx;
  succj = succy;
  while (matrice2[succi][succj]==(joueuractuel%2+1) && succi>=0 && succi<8 && succj>=0 && succj<8) {  // un probleme ici
    succi = succi+a;
    succj = succj+b;
    if (succi<0 || succj<0  || succj>7  || succi>7 ) {
      succi = succi-a;
      succj = succj-b;
      break;
    }
    // println("          succi = "+succi+"  et succj = "+succj);
  }
  if (matrice2[succi][succj]==joueuractuel) return true;

  return bool;
}

///////////////////////////////

//// ******************************    [x][y] ok    ****************************** ////
boolean peutjouer(int joueuractuel, int matrice[][]) {
  for (int i = 0; i<8; i++) {
    for (int j = 0; j<8; j++) {
      if (matrice[i][j] == 0 && voisinsok(i, j, joueuractuel, matrice).size()!=0 ) {  // il y au moins une case à jouer à la position i et j
        return true;
      }
    }
  }
  return false;
}

////////////////////////////////


//// *************************    [x][y] point à jouer retourne les chemain a changer s'il peut jouer ici    ************************* ////
ArrayList<Noeud> voisinsok(int x, int y, int joueuractuel, int matrice[][] ) {     
  ArrayList<Noeud> NoeudsPossible = new ArrayList<Noeud>();
  ArrayList<Integer> sauv = new ArrayList<Integer>();
  sauv = succ(x, y, joueuractuel, matrice);
  if (sauv.size()==0) {
    // Vous ne pouvez pas jouer ici !!!!
    //println("Impossible de jouer ici , joueurActuel = "+joueuractuel); //ICIII!!
  } else {
    for (int i = 0; i<sauv.size(); i+=2) { 
      if (comparer(x, y, sauv.get(i), sauv.get(i+1), joueuractuel, matrice)) {
        NoeudsPossible.add(new Noeud(sauv.get(i), sauv.get(i+1)));
      }
    }
  }
  return NoeudsPossible;
}

////La meme!////////////// A ENLEVER???
/*
ArrayList<Integer> voisinsok(int x, int y, int joueuractuel ,int matrice[][] ) {     
 ArrayList<Integer> caspossible = new ArrayList<Integer>();
 // ArrayList<Noeud> NoeudsPossible = new ArrayList<Noeud>();
 ArrayList<Integer> sauv = new ArrayList<Integer>();
 sauv = succ(x, y, joueuractuel,matrice);
 if (sauv.size()==0) {
 // Vous ne pouvez pas jouer ici !!!!
 //println("Impossible de jouer ici , joueurActuel = "+joueuractuel);
 
 } 
 else {
 // println("/*************************** x= "+x+"    y="+y);
 for (int i = 0; i<sauv.size(); i+=2) { 
 if (comparer(x, y, sauv.get(i), sauv.get(i+1), joueuractuel,matrice)) {
 caspossible.add(sauv.get(i));                   // print("/********************************** isucc= "+(sauv.get(i)));
 caspossible.add(sauv.get(i+1));                 // println("    +jsucc="+(sauv.get(i+1)));
 // NoeudsPossible.add(new Noeud(sauv.get(i),sauv.get(i+1)));
 }
 }
 }
 return caspossible;
 }
 */



////////////////////////

void play(int [][]mattemp, int joueuractuel, Noeud n) {

  if (peutjouer(joueuractuel, matrice)) {   //cpt2=0; --->compteur 2
    //i cpt =2....feuille
    ArrayList<Integer> sauv = new ArrayList<Integer>();
    sauv = succ(n.geti(), n.getj(), joueuractuel, mattemp);
    for (int o = 0; o<sauv.size(); o+=2) { 
      if (comparer(n.geti(), n.getj(), sauv.get(o), sauv.get(o+1), joueuractuel, mattemp)) {
        int a, b, succi, succj;
        succi = sauv.get(o);       // println(" succi = "+succi);
        succj = sauv.get(o+1);     // println(" succj = "+succj);
        a= succi - n.geti();       // println(" a = "+a);
        b= succj - n.getj();       // println(" b = "+b);
        while (mattemp[succi][succj]!=joueuractuel && succi>=0 && succi<8 && succj>=0 && succj<8) {
          mattemp[succi][succj] = joueuractuel; 
          succi = succi+a;         // println(" succi' = "+succi);
          succj = succj+b;         // println(" succi' = "+succi);
        }
        mattemp[n.geti()][n.getj()] = joueuractuel;
      }
    }
  }
} 

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~METHODES DES JOUEURS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

/*------------1.Le joueur Humain------------*/

void mouseClicked() {
  int x=(mouseX-20)/(stepx);
  int y=(mouseY-20)/(stepy);

  if (x<8 && y<8) {   // click dans le jeu

    if (joueuractuel != 0 ) {
      if (peutjouer(joueuractuel, matrice)) { //c'est le tour du jouer 
        jouer=true;
        if (matrice[x][y]==0 && voisinsok(x, y, joueuractuel, matrice).size()!=0) { //on peut jouer et on a quoi  jouer
          cpt=0;  //initialiser le compteur
          ArrayList<Integer> sauv = new ArrayList<Integer>(); //liste de ses successeurs
          sauv = succ(x, y, joueuractuel, matrice);
          // println("les successeur du point["+x+"]["+y+"] =: "+sauv);
          delay(1000);
          for (int o = 0; o<sauv.size(); o+=2) {  //remplaces toutes les cases par notre couleur arrivant à  la premiere qui nous ressemble :p
            if (comparer(x, y, sauv.get(o), sauv.get(o+1), joueuractuel, matrice)) {
              int a, b, succi, succj;
              succi = sauv.get(o);
              succj = sauv.get(o+1);
              a= succi - x;
              b= succj - y;
              while (matrice[succi][succj]!=joueuractuel && succi>=0 && succi<8 && succj>=0 && succj<8) {
                matrice[succi][succj] = joueuractuel;
                succi = succi+a;
                succj = succj+b;
              }
            }
          }

          matrice[x][y] = joueuractuel;
          bool = true;
          joueuractuel=joueuractuel%2+1;
          println("-> Changement de joueur à :" + joueuractuel);
          //delay(2000);
        } else {
          jouer=false;
        }
      } else {
        if (!peutjouer(joueuractuel, matrice))
          cpt++;
        // c'est le tour de la machine
      }
    } else {
      // Veuiller choisir un joueur
    }
  } else {     // clique en dehors du jeu
    clicBouttons();
  }
}   


void clicBouttons() {
  //on affecte le 1 au 1er joueur et -1 au second
  if (b.isMouseOver()) { //bouton jouer en premier
    joueur = 1; 
    machine =2; 
    joueuractuel=1; 
    b.setLock(true); 
    b2.setLock(true); 
    b3.setLock(false); 
    actualiserAffichage();
  }
  if (b2.isMouseOver()) { // bouton jouer en second 
    joueur = 2; 
    machine =1; 
    joueuractuel=1; 
    b.setLock(true); 
    b2.setLock(true); 
    b3.setLock(false); 
    actualiserAffichage();
  }
  if (b3.isMouseOver()) { //bouton play
    b.setLock(false); 
    b2.setLock(false); 
    b3.setLock(true); 
    //file.stop();
    interfaceOthello();
  }
  println("Le joueur est = "+joueur);
}


/*------------2.La Machine------------*/

void machine() {
  if (!peutjouer(joueuractuel, matrice)) {
    cpt++;
    joueuractuel = joueuractuel%2+1;
  } else {
    cpt=0;
    //Appel à l'arbre Alpha-beta
    Arbre t=new Arbre(matrice, null, joueuractuel, 0, -1);
    output = createWriter("Arbre.txt");
    //-->affichageTest(t,0); ICIII!!!!
    output.close();
    boolean h = false;

    for (int i=0; i<t.getNoeud().size(); i++) {
      if ((t.getNoeud().get(i).geti()==0 && t.getNoeud().get(i).getj()==0)  || 
        (t.getNoeud().get(i).geti()==7 && t.getNoeud().get(i).getj()==7)  || 
        (t.getNoeud().get(i).geti()==0 && t.getNoeud().get(i).getj()==7)  || 
        (t.getNoeud().get(i).geti()==7 && t.getNoeud().get(i).getj()==0)  ) {
        play(matrice, joueuractuel, t.getNoeud().get(i));
        h = true;
      }
    }
    if (!h) {
      NegaMinMax2(t);
      Arbre b = t;
      int i=0;
      while (b.getProfondeur()<Prof && b.getCpt() != 2) {
        if (b.getNoeudOpt() != -1 ) {
          b = b.getFils().get(b.getNoeudOpt());
        } else {
          //         println("Noeud de profondeur  "+b.getProfondeur()+"   est le fils =  -1   b.getFils.size = "+b.getFils().size()+"    b.getcpt  =  "+b.getCpt());
          b = b.getFils().get(0);
        }
        //i++;
      }
      play(matrice, joueuractuel, t.getNoeud().get(t.getNoeudOpt()));
    }

    joueuractuel = joueuractuel%2+1;
  }
}


/////////////////////////////////////////ATFER/////////////////////////
//////////////////////////////////////////////////////////////////

float pourcentagemachine(int matrice [][]) {
  int noir=0, blanc=0;
  for (int i = 0; i<8; i++) {
    for (int j = 0; j<8; j++) {
      if (matrice[i][j] == 1) {  // il peu au moins jouer a la position i et j
        noir++;
      }
      if (matrice[i][j] == 2 ) {  // il peu au moins jouer a la position i et j
        blanc++;
      }
    }
  }

  if (joueuractuel == 1) {
    float pourcentage=(noir*15)/(noir+blanc); 
    return pourcentage;
  } else {
    float pourcentage=(blanc*15)/(noir+blanc);
    return pourcentage;
  }
}
///////////////////////Nouvelles fonctions de rashid////////////////////////

float mobilitemachine(int matrice[][]) {
  int mobmachine=0, mobjoueur=0;
  for (int i = 0; i<8; i++) {
    for (int j = 0; j<8; j++) {
      if (matrice[i][j] == 0 && voisinsok(i, j, machine, matrice).size()!=0 ) {  // il peu au moins jouer a la position i et j
        mobmachine++;
      }
      if (matrice[i][j] == 0 && voisinsok(i, j, joueur, matrice).size()!=0 ) {  // il peu au moins jouer a la position i et j
        mobjoueur++;
      }
    }
  }
  //  println("Z ========== "+mobmachine+"  -  "+mobjoueur);
  return 15.00*(mobmachine-mobjoueur)/(mobmachine+mobjoueur);
}

public float Score(int mat[][]) {
  float sm =0, sj = 0;
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {

      if (matrice[i][j]== machine)    sm+=poids[i][j];
      else if (matrice[i][j]==joueur)     sj+=poids[i][j];
    }
  }
  float o = (sm-sj)/(sm+sj);
  println("Score =   "+o);
  return o;
}

/**************         Ecrit l'arbre dans le fichier et initialise les poids         **************///Trés Importante
/*void affichageTest( Arbre t , int j){
 ArrayList<Integer> test =  calcjetonsBN(t.getMatrice());
 output.print("AffichageArbre  de ");
 output.print("\tProfondeur = "+t.getProfondeur() +"  fils : "+j );
 output.print("\tRouge = "+test.get(0)+" ");
 output.print("\tvert = "+test.get(1)+"\tCPT = "+t.getCpt()+"\n");
 for (int i = 0;i<8; i++){
 for (int l=0; l < t.getProfondeur(); l++)
 {
 output.print("\t\t\t");
 }
 output.print("|");
 for (int tt = 0;tt<8; tt++){
 if (t.getMatrice()[i][tt] == 0)
 output.print("  .");
 if (t.getMatrice()[i][tt] == 1)
 output.print("  1");
 if (t.getMatrice()[i][tt] == 2)
 output.print("  2");
 }
 output.println("");
 }
 if (t.getFils().size() == 0){
 //float x = pourcentageR(t.getMatrice(),joueuractuel);
 // println("t.getTayx ===== "+t.getTaux()  +"          "+ t.getProfondeur());
 for (int l=0; l < t.getProfondeur(); l++)
 {
 output.print("\t\t\t");
 }
 output.println("FEUILLE heuristiueJ = "+t.getHeuristiqueJ()+"  heuristiqueM = "+t.getHeuristiqueM()+"  heuristiqueP = "+t.getHeuristiqueP()+"  heuristique = "+t.getHeuristique());
 }
 //if(t.getProfondeur() != 0);
 //println("  PerePronfndeur = "+t.getPere().getProfondeur() );          
 for (int i=0;i<t.getFils().size();i++)
 {
 affichageTest(t.getFils().get(i),i);
 }
 }*/

/////VERIFIER AVEC RASHIDO
//FONCTION POURCENTAGE

int [][] Clone (int matrice[][]) {
  int [][]temp=
    {{0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 1, 2, 0, 0, 0}, 
    {0, 0, 0, 2, 1, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}};
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      temp [i][j] = matrice[i][j];
    }
  }
  return temp;
}
