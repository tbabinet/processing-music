import java.io.*;

class Decideur{
 int[][] chMat;
 ArrayList<ArrayList<ClassRectangle>> chMatRect;
 ArrayList<ArrayList<Regle>> chMatRegle;
 
  public Decideur(ArrayList<ArrayList<ClassRectangle>> matRect){
    newMat(1);
    chMatRect = matRect;
    regle();
  }//cstr
  
  public void dessin(int octave, int t){
    for(int i = 0; i< chMatRegle.get(octave).size();i++){
      Regle r = chMatRegle.get(octave).get(i);
      chMatRect.get(r.posX).get(r.posY).drawRect(t);
    }// for i   
  }//dessin
    
  
  public void newMat(int numMat){
    String fichier ="/Grids/grid"+numMat+".txt";
    int[][] newMat = new int[9][9];
    int i = 0;
    //lecture du fichier texte  
    try{
      
      BufferedReader br=createReader(fichier);
      String ligne;
      while ((ligne=br.readLine())!=null){
        String ligneSplit[] = ligne.split(" ");
        for(int k = 0; k < ligneSplit.length;k++){
          int x = Integer.parseInt(ligneSplit[k]);
          newMat[i][k] = x;
        }//for k
        i++;
      }//while
      br.close(); 
    }//try    
    catch (Exception e){
      System.out.println(e.toString());
    }//catch
    
    chMat = newMat;
    regle();
  }//newMat
  
  public void regle(){
    chMatRegle = new ArrayList<ArrayList<Regle>>();
    for(int i = 0; i<9;i++){
      ArrayList<Regle> listR = new ArrayList<Regle>();
      chMatRegle.add(listR);
    }
    
    for(int i = 0;i<chMat.length;i++){
      for(int j = 0; j < chMat[i].length;j++){
        Regle r = new Regle(j,i);
        int octave = chMat[i][j] - 1;
        if(octave>0 && octave <10)
          chMatRegle.get(octave).add(r);
      }//for j
    }
  }
  
    
  
  
  
}