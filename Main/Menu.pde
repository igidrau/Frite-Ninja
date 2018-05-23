// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.
float parsec; // le nombre d'images par seconde
final int echelleTerre = 300; // pxl/m
final float echelleGeopw = 4.5; //(10^)pxl/m
IntList meilleurs_scoresT, meilleurs_scoresG;
int argent, argent_total;


static interface Fenetre {
  
  void drow();
  void mousePress();
  void mouseClick();
}


class Menu implements Fenetre {
  
  
  PImage jouer, boutique, m_score, quitter, instruct, fond;
  public Menu() {
    jouer = loadImage("images/boutons/bouton-0.png"); //chargement des boutons du menu
    boutique = loadImage("images/boutons/bouton-1.png");
    m_score = loadImage("images/boutons/bouton-2.png");
    quitter = loadImage("images/boutons/bouton-4.png");
    instruct = loadImage("images/boutons/bouton-5.png");
    fond = loadImage("images/fonds/fond-menu.png");
    fond.resize(displayWidth,displayHeight);
    background(fond);
  }
  
  void drow(){
    
    imageMode(CENTER); //affichage des boutons du menu
    image(this.jouer,displayWidth/2, displayHeight/3);
    image(this.boutique,displayWidth/2, 2*displayHeight/3);
    image(this.m_score, 188/2, displayHeight - 143/2);
    image(this.quitter, displayWidth - 188/2, displayHeight - 143/2);
    image(this.instruct, displayWidth/2, displayHeight - 140/2);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < displayHeight/3 + 131/2) && (mouseY > displayHeight/3 - 131/2)){ //bouton jouer
      fenetre = new MenuJeu();
      son_coupe();}
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < 2*displayHeight/3 + 131/2) && (mouseY > 2*displayHeight/3 - 131/2)){ //bouton boutique
      fenetre = new MenuBoutique();
      son_coupe();}
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      quitter();
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && mouseY > displayHeight-143){
      fenetre = new Instructions();
      son_coupe();}
    if (mouseX < 188 && mouseY > displayHeight-143){
      fenetre = new Records();
      son_coupe();}
  }
}




class MenuJeu implements Fenetre {
 
  PImage b_classique, b_espace, b_retour, fond;
  
  public MenuJeu(){
    fond = loadImage("images/fonds/fond-menu.png");
    fond.resize(displayWidth,displayHeight);
    background(fond);
    b_retour = loadImage("images/boutons/bouton-9.png");
    b_classique = loadImage("images/boutons/bouton-7.png"); //chargement des boutons
    b_espace = loadImage("images/boutons/bouton-8.png");
    
  }
  
  void drow(){
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    imageMode(CENTER); //affichage des boutons
    image(this.b_classique,displayWidth/2, displayHeight/3);
    image(this.b_espace,displayWidth/2, 2*displayHeight/3);
  }
  
  void mousePress(){}
  
  void mouseClick(){
    int u = framerate * 20;
    patates = new ArrayList<Patate>();
    frites = new ArrayList<Frite>();
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < displayHeight/3 + 131/2) && (mouseY > displayHeight/3 - 131/2)){
      musique.stop();
      son_coupe();
      fenetre = new JeuTerre(patates, frites, 0, 5, 0, false, false, u , u, u);
    }
    else if (((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < 2*displayHeight/3 + 131/2) && (mouseY > 2*displayHeight/3 - 131/2))){
      if(meilleurs_scoresT.get(0) >= 1500){
        musique.stop();
        son_coupe();
        fenetre = new JeuGeo(patates, frites, 0, 5, 0, false, false, u , u);}
      else{
        sonerreur.play();
        textSize(20);
        fill(255);
        text("Il faut avoir fait plus de 1500 dans la cuisine avant de pouvoir décoller", 10, 20);}
    }
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143){
      fenetre = new Menu();
      son_coupe();}
}
}