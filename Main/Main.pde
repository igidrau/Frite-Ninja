import processing.sound.*;    //Bibliothèque qui gère les sons
final int framerate = 30;     //Nombre d'images par seconde
PFont police;
ArrayList<PImage> patatesEtFrites;



Fenetre fenetre;

void chargerMenu(){
  recupSave();
  triche();

  chargerSons();
  chargerImages();
    
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
  musicNyan = new SoundFile(this, "son/nyan.wav");
  nyanYes = new SoundFile(this, "son/nyanYes.wav");
  nyanNo = new SoundFile(this, "son/nyanNo.wav");
}

void chargerImages(){
  patatesEtFrites = new ArrayList<PImage>();
  patatesEtFrites.add(loadImage("images/patates/patate-0-0.png")); //0-3
  patatesEtFrites.add(loadImage("images/patates/patate-0-1.png"));
  patatesEtFrites.add(loadImage("images/patates/patate-0-2.png"));
  patatesEtFrites.add(loadImage("images/patates/patate-0-3.png"));
  patatesEtFrites.add(loadImage("images/patates/patate-1.png")); //4-7
  patatesEtFrites.add(loadImage("images/patates/patate-2.png"));
  patatesEtFrites.add(loadImage("images/patates/patate-3.png"));
  patatesEtFrites.add(loadImage("images/patates/patate-4.png"));
  patatesEtFrites.add(loadImage("images/patates/frite-0.png")); //8-13
  patatesEtFrites.add(loadImage("images/patates/frite-1.png"));
  patatesEtFrites.add(loadImage("images/patates/frite-2.png"));
  patatesEtFrites.add(loadImage("images/patates/frite-3.png"));
  patatesEtFrites.add(loadImage("images/patates/frite-4.png"));
  patatesEtFrites.add(loadImage("images/patates/frite-5.png"));
  patatesEtFrites.add(loadImage("images/patates/potato-0.png")); //14-17
  patatesEtFrites.add(loadImage("images/patates/potato-1.png"));
  patatesEtFrites.add(loadImage("images/patates/potato-2.png"));
  patatesEtFrites.add(loadImage("images/patates/potato-3.png"));
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
