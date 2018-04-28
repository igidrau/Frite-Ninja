import processing.sound.*;    //Bibliothèque qui gère les sons
final int framerate = 30;     //Nombre d'images par seconde



Fenetre fenetre;

void setup() {
  fullScreen();
  frameRate(framerate);
  
  
  try {
    recupSave();
    
    triche();
    
  } catch (Exception e) {                                //En cas d'erreur, réinitialisation des variables.
    nouvellePartie(e);
  }
  fenetre = new Menu();
  sonstart = new SoundFile(this, "son/son-start.wav");
  sonrate = new SoundFile(this, "son/son-rate.mp3");
  sonerreur = new SoundFile(this, "son/son-erreur.wav");
  sonachat = new SoundFile(this, "son/son-monnaie.wav");
  sonx2 = new SoundFile(this, "son/son-x2.wav");
  soneau = new SoundFile(this,"son/son-eau.wav");
  musique_menu();
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

void quitter(){
  sauvegarde();
  exit();
}