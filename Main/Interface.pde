// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.

interface Fenetre {
  PGraphics getContenu() ;
  
  void mousePress();
  void drow();
}



class Menu implements Fenetre {
  
  private PGraphics contenu;
  public Menu(PGraphics contenu) {
    contenu.beginDraw();
    contenu.endDraw();
    this.contenu = contenu;
  }
  
  PGraphics getContenu() {
    return contenu;
  }
  
  void drow(){}
  
  void mousPress(){}
}
