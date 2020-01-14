public class Arbre{
  private int Joueur;
  private int Profondeur;
  private int matrice[][];
  private Arbre pere;
  private int numfils; // Le numero du fils chez son pere ( pour remonter le chemin )
  private ArrayList<Noeud> NoeudOk;
  private ArrayList<Arbre> fils;
  private int NoeudOpt;  // Le noeud Optimal a jouer par la mahcine ;)
  private int cpt;
  private float taux;
  private float heuristique;
  private float heuristiqueP;


/******* Constructeur qui général l'arbre total  *************/  //Appel : Arbre (matrice,null,joueuractuel,-1)
  Arbre(int mat[][],Arbre pere, int joueuractuel,int Profondeur,int numfils){
    this.Joueur = joueuractuel%2+1;    //Prof 0 c'est le joueur ..niveau 1 ==machine
    this.Profondeur = Profondeur;
    matrice = mat;
    this.pere = pere;
    this.numfils = numfils;  
    if(Profondeur == 0){
      this.cpt=0;
    }
    else{
      this.cpt = pere.getCpt();
    }
    ArrayList<Noeud> temp = new ArrayList<Noeud>();
    NoeudOk =new ArrayList<Noeud>();
      for (int i = 0;i<8;i++){
        for (int j = 0;j<8;j++){
          if (matrice[i][j] == 0 && voisinsok(i, j, joueuractuel,matrice).size()!=0) {  // il peu au moins jouer a la position i et j
              if (poids[i][j] == -2 && Profondeur%2==0){
                  temp.add(new Noeud(i,j));  //jouer ici au pire!
              }
              else
                NoeudOk.add(new Noeud(i,j));  // Masha'Allah - autre que les 3 cases a eviter
          } 
        }
      }
    if (NoeudOk.size() == 0){
      for (int y = 0;y<temp.size();y++){
        NoeudOk.add(temp.get(y));
      }
    }
    if (NoeudOk.size() == 0)  //il ne peut pas jouer le joueuractuel à ce niveau là
      this.cpt++;
    else            // sinon sil peut joueer on remet le cpt à 0
      this.cpt=0;
    fils =new ArrayList<Arbre>();
    if (this.getProfondeur()<Prof    && this.cpt<2){
       if (cpt == 0)
         for (int i = 0;i<NoeudOk.size();i++){
              int mat2 [][] = Clone(matrice);
              play(mat2,joueuractuel,NoeudOk.get(i));
              Arbre  t =  new Arbre (mat2,this,joueuractuel%2+1,this.getProfondeur()+1,i);
              fils.add(t);
          }
        else{    //cpt=1 //passer le tour 
            int mat2 [][] = Clone(matrice);
            Arbre  t =  new Arbre (mat2,this,joueuractuel%2+1,this.getProfondeur()+1,-1);  //NumFils = -1
            fils.add(t);
        }
    }
    else{        //prof = profmax ou cpt =2 donc feuille calculer heuristique
        float ratioJetons = pourcentagemachine(this.matrice);
        float mob = mobilitemachine(this.matrice);
        if( this.getProfondeur()%2==1){
          if(numfils != -1){
            heuristique = ratioJetons+mob+poids[pere.getNoeud().get(this.numfils).geti()][pere.getNoeud().get(this.numfils).getj()];
            heuristiqueP = +poids[pere.getNoeud().get(this.numfils).geti()][pere.getNoeud().get(this.numfils).getj()];  
          }
          else
            heuristique = ratioJetons+mob;
        }
        else{

          if(numfils != -1){
            heuristique = -ratioJetons-mob-poids[pere.getNoeud().get(this.numfils).geti()][pere.getNoeud().get(this.numfils).getj()];
            heuristiqueP = -poids[pere.getNoeud().get(this.numfils).geti()][pere.getNoeud().get(this.numfils).getj()];
          }
          else
            heuristique = -ratioJetons-mob;
        }
    }
}



/************************ Setteurs et Getteurs   **************************/
  void setJoueur(int joueur){
    this.Joueur = joueur;
  }
  
  int getJoueur(){
    return this.Joueur;
  }
  
  void setProfondeur(int Prof){
    this.Profondeur = Prof;
  }  
  
  int getProfondeur(){
   return this.Profondeur;
  }
  
  void setMatrice(int[][] mat){
    this.matrice = mat;
  }
  
  int[][] getMatrice(){
   return this.matrice;
  }
  
  void setPere(Arbre pere){
   this.pere = pere;
  }
  
  Arbre getPere(){
   return pere ;
  }
  
  void setFils(int fils){
    this.numfils = fils; 
  }
  
  int getNumFils(){
    return this.numfils;
  }
  
  ArrayList<Arbre> getFils(){
   return this.fils;
  }
  
  ArrayList<Noeud> getNoeud(){
   return this.NoeudOk;
  }

  void setNoeudOpt(int opt){
    this.NoeudOpt = opt;
  }

  int getNoeudOpt(){
    return NoeudOpt;
  }  
  
  void setCpt(int cpt){
    this.cpt = cpt;
  }
  
  int getCpt(){
   return this.cpt;
  }
  
  void setHeuristique(Float heuris){
    this.heuristique = heuris;
  }
  
  float getHeuristique(){
    return this.heuristique;
  }
  
  float getHeuristiqueP(){
    return this.heuristiqueP;
  }
  
  void setTaux(float taux){
    this.taux = taux;
  }
 
  float getTaux(){
    return this.taux;
  }  
/************* Fin Setteurs et Getteurs ***********/

/******************Methodes****************/
void play(int [][]mattemp,int joueuractuel,Noeud n){
  
  if (/*joueuractuel == joueur && */peutjouer(joueuractuel,matrice)) {
      ArrayList<Integer> sauv = new ArrayList<Integer>();
      sauv = succ(n.geti(), n.getj(), joueuractuel,mattemp);
      for (int o = 0; o<sauv.size(); o+=2) { 
        if (comparer(n.geti(), n.getj(), sauv.get(o), sauv.get(o+1), joueuractuel,mattemp)) {
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
  
  
   /* 
   void AffichageMatrice (int mat[][]){
      for (int i = 0;i<8; i++){
        for (int j = 0;j<8; j++){
            if (mat[i][j] == 0)
              print("  .");
            if (mat[i][j] == 1)
              print("  1");
            if (mat[i][j] == 2)
              print("  2");
        }
        println("");
      }
    }
    */
}