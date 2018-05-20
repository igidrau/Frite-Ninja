void recupSave(){
  try{
    meilleurs_scores = new IntList();                    //Récupération de la sauvegarde
    raquettesAchetees = new ArrayList<Boolean>();
    XML save = loadXML("save.save");
    XML[] scores = save.getChildren("score");
    XML[] raquettes = save.getChildren("raquette");
    argent = int(save.getChild("argent").getContent());
    argent_total = int(save.getChild("argentTotal").getContent());
  
    for (int i = 0; i<scores.length; i++){
      meilleurs_scores.append(int(scores[i].getContent()));
    }
    for (int i = 0; i<raquettes.length; i++){
      raquettesAchetees.add(boolean(raquettes[i].getContent()));
    }
    racket_activ = int(save.getChild("actif").getContent());
  }catch(Exception e){
    println(e);
    println("Erreur lors de la récupération de la sauvegarde");
    nouvellePartie();
  }
}

void triche(){                                 //Surveillance de potentielles triches.
  XML[] raquettes = loadXML("data/raquettes.data").getChildren("raquette");
  int prixRaquettes=0;
  for(int i = 0; i<5; i++){
    if(raquettesAchetees.get(i))
      prixRaquettes+=raquettes[i].getInt("prix");
  }
  if(!raquettesAchetees.get(racket_activ) || prixRaquettes+argent!=argent_total){
    println(prixRaquettes+argent);
    println(argent_total);
    println("Triche détectée, suppression de la sauvegarde");
    nouvellePartie();
    sauvegarde();
  }
}

void nouvellePartie(){
  
  meilleurs_scores = new IntList();
  raquettesAchetees = new ArrayList<Boolean>();
  argent = argent_total = 0;
  raquettesAchetees.add(true);
  meilleurs_scores.append(0);
  for (int i = 1; i<5; i++){
    meilleurs_scores.append(0);
    raquettesAchetees.add(false);
  }
  racket_activ = 0;
}

void sauvegarde(){
  XML save = new XML("save");
  save.addChild("argent").setContent(str(argent));
  save.addChild("argentTotal").setContent(str(argent_total));
  for(int i : meilleurs_scores){
    save.addChild("score").setContent(str(i));
  }
  for(int i = 0; i<raquettesAchetees.size(); i++){
    XML raquettei = save.addChild("raquette");
    raquettei.setContent(str(raquettesAchetees.get(i)));
    raquettei.setString("n", str(i));
  }
  save.addChild("actif").setContent(str(racket_activ));
  saveXML(save, "save.save");
}