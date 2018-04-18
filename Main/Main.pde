//amar
import processing.sound.*;
PImage fond;


Fenetre fenetre;

void setup() {
  fullScreen();
  frameRate(30);
  meilleurs_scores = new IntList();
  raquettesAchetees = new ArrayList<Boolean>();
  try {
    XML save = loadXML("save.save");
    XML[] scores = save.getChildren("score");
    XML[] raquettes = save.getChildren("raquette");
    for (int i = 0; i<scores.length; i++){
      meilleurs_scores.append(int(scores[i].getContent()));
    }
    for (int i = 0; i<raquettes.length; i++){
      raquettesAchetees.add(boolean(raquettes[i].getContent()));
    }
    println(raquettesAchetees);
  } catch (Exception e) {
    println(e);
    println("Erreur lors de la récupération de la sauvegarde");
    for (int i = 0; i<5; i++){
      meilleurs_scores.append(0);
      if (i==0)
        raquettesAchetees.add(true);
      else
        raquettesAchetees.add(false);
    }
  }
  fenetre = new Menu();
  soncoupe1 = new SoundFile(this, "son/son-coupe.mp3");
  soncoupe2 = new SoundFile(this, "son/son-coupe2.mp3");
  sonrate = new SoundFile(this, "son/son-rate.mp3");
  musique_menu();
  musique.loop();
 
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
  XML save = new XML("save");
  for(int i : meilleurs_scores){
    save.addChild("score").setContent(str(i));
  }
  for(boolean i : raquettesAchetees){
    save.addChild("raquette").setContent(str(i));
  }
  saveXML(save, "save.save");
  exit();
}