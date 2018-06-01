// Une interface qui permet notamment de séparer les fonctions draw(), mouseClick() etc. pour chaque affichage.
float parsec; // le nombre d'images par seconde
final int echelleTerre = 300; // pxl/m
final float echelleGeopw = 4.5; //(10^)pxl/m
IntList meilleurs_scoresT, meilleurs_scoresG;
int argent, argent_total;
PImage fondMenu;


static interface Fenetre {
  
  void drow();
  void mousePress();
  void mouseClick();
}

class Chargement implements Fenetre {
  public Chargement(){
    thread("chargerMenu");
    PImage logo = loadImage("images/logo.png");
    imageMode(CENTER);
    image(logo, displayWidth/2, displayHeight/2);
  }
  
  void drow(){}
  void mousePress(){}
  void mouseClick(){}
}


class Menu implements Fenetre {
  
  
  PImage jouer, boutique, m_score, quitter, instruct;
  public Menu() {
    jouer = loadImage("images/boutons/bouton-0.png"); //chargement des boutons du menu
    boutique = loadImage("images/boutons/bouton-1.png");
    m_score = loadImage("images/boutons/bouton-2.png");
    quitter = loadImage("images/boutons/bouton-4.png");
    instruct = loadImage("images/boutons/bouton-5.png");
    background(fondMenu);
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
      thread("son_coupe");
      fenetre = new MenuJeu();
    }
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < 2*displayHeight/3 + 131/2) && (mouseY > 2*displayHeight/3 - 131/2)){ //bouton boutique
      thread("son_coupe");
      fenetre = new MenuBoutique();
    }
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      quitter();
    if ((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && mouseY > displayHeight-143){
      thread("son_coupe");
      fenetre = new Instructions();
    }
    if (mouseX < 188 && mouseY > displayHeight-143){
      thread("son_coupe");
      fenetre = new Records();
    }
  }
}




class MenuJeu implements Fenetre {
 
  PImage b_classique, b_espace, b_retour;
  int temps;
  
  public MenuJeu(){
    b_retour = loadImage("images/boutons/bouton-9.png");
    b_classique = loadImage("images/boutons/bouton-7.png"); //chargement des boutons
    b_espace = loadImage("images/boutons/bouton-8.png");
    background(fondMenu);
    temps = framerate*6;
  }
  
  void drow(){
    temps++;
    if(temps==framerate*1)
      background(fondMenu);
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
      son_coupe();
      musique.stop();
      fenetre = new JeuTerre(patates, frites, 0, 3, 0, false, false, u , u, u);
    }
    else if (((mouseX < displayWidth/2 + 614/2) && (mouseX > displayWidth/2 - 614/2) && (mouseY < 2*displayHeight/3 + 131/2) && (mouseY > 2*displayHeight/3 - 131/2))){
      if(meilleurs_scoresT.get(0) >= 1500){
        son_coupe();
        musique.stop();
        fenetre = new JeuGeo(patates, frites, 0, 3, 0, false, false, u , u);}
      else{
        sonerreur.play();
        fill(255);
        rect(displayWidth/5, displayHeight/2-20, 3*displayWidth/5, 40);
        textSize(20);
        fill(255, 0, 0);
        rectMode(CORNER);
        text("Il faut avoir fait plus de 1500 points dans la cuisine avant de pouvoir décoller", displayWidth/5+20, displayHeight/2+10);
        temps=0;
      }
    }
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143){
      son_coupe();
      fenetre = new Menu();
    }
  }
}