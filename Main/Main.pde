import processing.sound.*;


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
      raquettesAchetees.add(raquettes[i].getContent()=="true");
    }
  } catch (Exception e) {
    println("Erreur lors de la récupération de la sauvegarde");
    for (int i = 0; i<5; i++){
      meilleurs_scores.append(0);
      raquettesAchetees.add(false);
    }
  }
  fenetre = new Menu();
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