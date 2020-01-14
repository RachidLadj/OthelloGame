public class Noeud{

  private int i,j;
  
  Noeud(int i,int j){
    this.i = i;
    this.j = j;
  }
  
  public int geti(){
    return i;
  }
  
  public int getj(){
    return j;
  }
  
  public String toString(){
    return ("  (i,j) = ("+this.geti()+","+this.getj()+")");
  }
  
  
  
  


}