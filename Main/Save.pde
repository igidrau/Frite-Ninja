void recupSave() {
  try {
    meilleurs_scoresT = new ArrayList<Score>();                    //Récupération de la sauvegarde
    meilleurs_scoresG = new ArrayList<Score>();
    raquettesAchetees = new ArrayList<Boolean>();
    XML save = loadXML("save.save");
    XML[] scorest = save.getChildren("scoret");
    XML[] scoresg = save.getChildren("scoreg");
    XML[] raquettes = save.getChildren("raquette");
    argent = int(save.getChild("argent").getContent());
    argent_total = int(save.getChild("argentTotal").getContent());

    for (int i = 0; i<scorest.length; i++) {
      meilleurs_scoresT.add(new Score(int(scorest[i].getContent()), scorest[i].getString("nom")));
      meilleurs_scoresG.add(new Score(int(scoresg[i].getContent()), scoresg[i].getString("nom")));
    }

    for (int i = 0; i<raquettes.length; i++) {
      raquettesAchetees.add(boolean(raquettes[i].getContent()));
    }
    racket_activ = int(save.getChild("actif").getContent());
  }
  catch(Exception e) {
    println(e);
    println("Erreur lors de la récupération de la sauvegarde");
    nouvellePartie();
  }
}

void triche() {                                 //Surveillance de potentielles triches.
  XML[] raquettes = loadXML("data/raquettes.data").getChildren("raquette");
  int prixRaquettes=0;
  for (int i = 0; i<5; i++) {
    if (raquettesAchetees.get(i))
      prixRaquettes+=raquettes[i].getInt("prix");
  }
  if (!raquettesAchetees.get(racket_activ) || prixRaquettes+argent!=argent_total || meilleurs_scoresT.size()!=5 || meilleurs_scoresG.size()!=5) {
    println(prixRaquettes+argent);
    println(argent_total);
    println("Triche détectée, suppression de la sauvegarde");
    nouvellePartie();
    sauvegarde();
  }
}

void nouvellePartie() {

  meilleurs_scoresT = new ArrayList<Score>();
  meilleurs_scoresG = new ArrayList<Score>();
  raquettesAchetees = new ArrayList<Boolean>();
  argent = argent_total = 0;
  raquettesAchetees.add(true);
  meilleurs_scoresT.add(new Score(0, ""));
  meilleurs_scoresG.add(new Score(0, ""));
  for (int i = 1; i<5; i++) {
    meilleurs_scoresT.add(new Score(0, ""));
    meilleurs_scoresG.add(new Score(0, ""));
    raquettesAchetees.add(false);
  }
  racket_activ = 0;
}

void sauvegarde() {
  XML save = new XML("save");
  save.addChild("argent").setContent(str(argent));
  save.addChild("argentTotal").setContent(str(argent_total));
  for (Score i : meilleurs_scoresT) {
    XML scori = save.addChild("scoret");
    scori.setContent(str(i.score));
    scori.setString("nom", i.nom);
  }
  for (Score i : meilleurs_scoresG) {
    XML scori = save.addChild("scoreg");
    scori.setContent(str(i.score));
    scori.setString("nom", i.nom);
  }
  for (int i = 0; i<raquettesAchetees.size(); i++) {
    XML raquettei = save.addChild("raquette");
    raquettei.setContent(str(raquettesAchetees.get(i)));
    raquettei.setString("n", str(i));
  }
  save.addChild("actif").setContent(str(racket_activ));
  saveXML(save, "save.save");
}