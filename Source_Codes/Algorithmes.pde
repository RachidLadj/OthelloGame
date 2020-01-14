Arbre maxok2(ArrayList<Arbre> liste){  //Attribut noeudOpt
  Arbre temp = liste.get(0);
  for (int i = 1 ; i<liste.size();i++){
//      println("list.get(i) = "+liste.get(i).getHeuristique() + " --> Prof =  "+liste.get(i).getProfondeur() );
      if(liste.get(i).getHeuristique()>=temp.getHeuristique()){
        if(liste.get(i).getHeuristique()>temp.getHeuristique())
          temp = liste.get(i);  
        else
          if(liste.get(i).getProfondeur() == Prof && liste.get(i).getHeuristiqueP()>temp.getHeuristiqueP())
            temp = liste.get(i);  
//        println("temp = "+temp.getHeuristique() + " --> Prof =  "+temp.getProfondeur());
      }
  }
  return temp;
}

int x = 0;
Arbre NegaMinMax2(Arbre t){
      Arbre z;
      ArrayList<Arbre> liste = new ArrayList<Arbre>();
  if (t.getFils().size() == 0) 
        return t;
  else {
        for (int i =0 ; i<t.getFils().size();i++){
        liste.add(NegaMinMax2(t.getFils().get(i)));
        }   
        Arbre y = maxok2(liste);
//        print("\nLe y.numfils Optimal est = "+y.getNumFils() +"Meilleur Heristique  "+y.getHeuristique()+"   prof = "+t.getProfondeur());
        if(t.getCpt() == 0){
            t.setNoeudOpt(maxok2(liste).getNumFils());
  //        print("\ny == "+(-y.getHeuristique())+"  t.getprofondeur "+t.getProfondeur());
        }
        else{
            t.setNoeudOpt(-1);
  //        print("\ny == "+(-y.getHeuristique())+"  t.getprofondeur "+t.getProfondeur());
        }
        if(t.getProfondeur() == 0){
          t.setHeuristique(abs(y.getHeuristique())); 
         // println("tprofondeur racine heuristique = "+t.getHeuristique());
          return t;
        }
        t.setHeuristique(y.getHeuristique()*-1); 
        return t;
  }
}

/*float max(ArrayList<Float> liste){
  float temp = liste.get(0);
  for (int i = 1 ; i<liste.size();i++){
      if(liste.get(i)>temp) temp = liste.get(i);
  }
  return temp;
}

float fctA_B(Arbre t,float alpha,float beta){    //Elle retourne la meilleure Valeur qui doit me
      float z = -1;
      ArrayList<Float> liste = new ArrayList<Float>();
  if (t.getFils().size() == 0) {
      if(t.getProfondeur()%2 == 0){
        print("\ntaux == "+(-t.getTaux())+" - PROF "+t.getProfondeur()+"    ");  
        return -t.getTaux();
      }
      else{
        print("\ntaux == "+(+t.getTaux())+" - PROF "+t.getProfondeur()+"    ");
        return +t.getTaux();
      }
  }
  else {
    //if (t.getProfondeur() %2 == 1){
        t.setMP(-100);
        for (int i =0 ; i<t.getFils().size();i++){
          if (t.getProfondeur()%2 == 0)
             z = +fctA_B(t.getFils().get(i),-beta,-t.getMP());
          else
             z = +fctA_B(t.getFils().get(i),-beta,-t.getMP());
          liste.add(z);
        }   
        float y = max(liste);
        print("\ny == "+(-y)+"  t.getprofondeur "+t.getProfondeur());
        if(t.getProfondeur() == 0) return abs(y);
        return -y;
  }
}*/




















/**********************************/

float AlphaBeta(Arbre t,float alpha,float beta){
      Arbre z;
      ArrayList<Arbre> liste = new ArrayList<Arbre>();
  if (t.getFils().size() == 0) {
      if(t.getProfondeur()%2 == 0){
        //print("\ntaux == "+(-t.getTaux())+" - PROF "+t.getProfondeur()+"    ");
        //t.setTaux(-t.getTaux());
        return t.getTaux();
      }
      else{
        //print("\ntaux == "+(+t.getTaux())+" - PROF "+t.getProfondeur()+"    ");
        return t.getTaux();
      }
  }
  else {
    if (t.getProfondeur() %2 == 0){
       // t.setMP(-100);
        for (int i =0 ; i<t.getFils().size() && alpha<beta;i++){
            /*if (t.getProfondeur()%2 == 0)
               z = fctA_Bok(t.getFils().get(i),-beta,-t.getMP());
            else*/
            println("Prof "+t.Profondeur + "  Fils  "+i+ "Parmis "+t.getFils().size()+"   alpha "+alpha);
            alpha = max(alpha,AlphaBeta(t.getFils().get(i),alpha,beta));
            println("Prof "+t.Profondeur + "Fils  "+i+ "Parmis "+t.getFils().size()+"   alpha "+alpha);
          //z = NegaMax(t.getFils().get(i),-beta,-t.getMP());
          //liste.add(z);
        }   
        return alpha;
    }
    else{
      for (int i =0 ; i<t.getFils().size() && alpha<beta;i++){
            /*if (t.getProfondeur()%2 == 0)
               z = fctA_Bok(t.getFils().get(i),-beta,-t.getMP());
            else*/
            println("Prof "+t.Profondeur + "  Fils  "+i+ "Parmis "+t.getFils().size()+"   beta "+beta);
            beta = min(beta,AlphaBeta(t.getFils().get(i),alpha,beta));
            println("Prof "+t.Profondeur + "Fils  "+i+ "Parmis "+t.getFils().size()+"   beta "+beta);
          //z = NegaMax(t.getFils().get(i),-beta,-t.getMP());
          //liste.add(z);
        }   
      return beta;
    }
  }
}

float NegaMaxAlphaBeta(Arbre t,float alpha,float beta){
      Arbre z;
      //ArrayList<Arbre> liste = new ArrayList<Arbre>();
  if (t.getFils().size() == 0) {
      if(t.getProfondeur()%2 == 0){
        //print("\ntaux == "+(-t.getTaux())+" - PROF "+t.getProfondeur()+"    ");
        //t.setTaux(-t.getTaux());
        return -t.getTaux();
      }
      else{
        //print("\ntaux == "+(+t.getTaux())+" - PROF "+t.getProfondeur()+"aux());
        return t.getTaux();
      }
  }
  else {
    //if (t.getProfondeur() %2 == 1){
       // t.setMP(-100);
        for (int i =0 ; i<t.getFils().size() && alpha<beta;i++){
            
            println("Prof "+t.Profondeur + "  Fils  "+i+ "   alpha "+alpha);
            float score = -NegaMaxAlphaBeta(t.getFils().get(i),-beta,-alpha);
            if (score >alpha) alpha = score;                 // println("Prof "+t.Profondeur + "Fils  "+i);
          //z = NegaMax(t.getFils().get(i),-beta,-t.getMP());
          //liste.add(z);
        }   
        return alpha;
  }
}