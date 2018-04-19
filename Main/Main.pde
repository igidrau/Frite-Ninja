import processing.sound.*;


Fenetre fenetre;

void setup() {
  fullScreen();
  frameRate(30);
  
  try {
    meilleurs_scores = new IntList();                    //Récupération de la sauvegarde
    raquettesAchetees = new ArrayList<Boolean>();
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
    racket_activ = int(save.getChild("actif").getContent());
    
    int scoretotal = 0;                                  //Surveillance de potentielles triches.
    for (int i = 0; i<meilleurs_scores.size(); i++)
      scoretotal+=meilleurs_scores.get(i);
    if(!raquettesAchetees.get(racket_activ) || meilleurs_scores.get(meilleurs_scores.size()-1)<=0 && scoretotal<argent){
      println("Triche détectée, suppression de la sauvegarde");
      import java.io.File;                  //En cas de triche, génération d'une erreur et suppression du fichier de sauvegarde
      File f = new File("save.save");
      f.delete();
      save.getChildren(str(random(1)));
    }
    
  } catch (Exception e) {                                //En cas d'erreur, réinitialisation des variables.
    println(e);
    println("Erreur lors de la récupération de la sauvegarde");
    meilleurs_scores = new IntList();
    raquettesAchetees = new ArrayList<Boolean>();
    argent = 0;
    raquettesAchetees.add(true);
    meilleurs_scores.append(0);
    for (int i = 1; i<5; i++){
      meilleurs_scores.append(0);
      raquettesAchetees.add(false);
    }
    racket_activ = 0;
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
  save.addChild("actif").setContent(str(racket_activ));
  saveXML(save, "save.save");
  exit();
}