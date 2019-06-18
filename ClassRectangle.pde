// Classe rectangle qui reprèsente une case de notre grille

class ClassRectangle {
  // Variables 
  int posX;
  int posY;
  int T;
  int minT = 30;
  int maxT = 100;

  // Constructeur de la classe
  public ClassRectangle(int posX, int posY, int T) {
    this.posX = posX;
    this.posY = posY;
    drawRect(T);
  }

  // Fonction de dessin d'un rectangle
  public void drawRect(int T) {
    noStroke();
    colorMode(RGB, 255, 255, 255, 100);
    fill(255, 255, 255, 100);
    if(T<30){
      T = minT;
      rect(posX, posY, T, T);
    }else if(T>100){
      T = maxT;
      rect(posX, posY, T, T);
    }else{
      rect(posX, posY, T, T);
    }
  }
}