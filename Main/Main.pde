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
    argent = int(save.getChild("argent").getContent());
    for (int i = 0; i<scores.length; i++){
      meilleurs_scores.append(int(scores[i].getContent()));
    }
    for (int i = 0; i<raquettes.length; i++){
      raquettesAchetees.add(boolean(raquettes[i].getContent()));
    }
  } catch (Exception e) {
    println(e);
    println("Erreur lors de la récupération de la sauvegarde");
    argent = 0;
    raquettesAchetees.add(true);
    meilleurs_scores.append(0);
    for (int i = 1; i<5; i++){
      meilleurs_scores.append(0);
      raquettesAchetees.add(false);
    }
  }
  musique_menu();
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
  save.addChild("argent").setContent(str(argent));
  for(int i : meilleurs_scores){
    save.addChild("score").setContent(str(i));
  }
  for(boolean i : raquettesAchetees){
    save.addChild("raquette").setContent(str(i));
  }
  saveXML(save, "save.save");
  exit();
}