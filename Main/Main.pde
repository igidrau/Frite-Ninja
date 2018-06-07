import processing.sound.*;    //Bibliothèque qui gère les sons
final int framerate = 30;     //Nombre d'images par seconde
PFont police;


Fenetre fenetre;

void chargerMenu(){
  recupSave();
  triche();
    
  chargerSons();
    
  musique_menu();
  police = loadFont("TrebuchetMS-30.vlw");    //police d'écriture du jeu
  textFont(police);
  
  fondMenu = loadImage("images/fonds/fond-menu.png");  //fond des menus
  fondMenu.resize(displayWidth,displayHeight);
  fenetre = new Menu();
}

void chargerSons(){
  sonstart = new SoundFile(this, "son/son-start.wav");
  sonrate = new SoundFile(this, "son/son-rate.mp3");
  sonerreur = new SoundFile(this, "son/son-erreur.wav");
  sonachat = new SoundFile(this, "son/son-monnaie.wav");
  sonx2 = new SoundFile(this, "son/son-x2.wav");
  soneau = new SoundFile(this,"son/son-eau.wav");
}

void setup() {
  fullScreen();
  frameRate(framerate);
  fenetre = new Chargement();
}

void draw() {
  if(fenetre!=null)
    fenetre.drow();
}


void mouseClicked() {
  if(fenetre != null){
    fenetre.mouseClick();
  }
}

void mousePressed() {
  if(fenetre != null){
    fenetre.mousePress();
  }
}

void keyPressed(){
  if(fenetre != null)
    fenetre.keyPress();
}

void quitter(){
  sauvegarde();      //on sauvegarde avant de quitter
  exit();
}