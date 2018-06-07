ArrayList<Score> meilleurs_scoresT, meilleurs_scoresG;

class Records implements Fenetre {
  
  PImage fond, b_retour;
  public Records() {
    textSize(50);
    fill(255,255,0);
    background(fondMenu);
    b_retour = loadImage("images/boutons/bouton-9.png");
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    text("Mode Cuisine", displayWidth/10-20, displayHeight/7);
    for(int i=0; i<meilleurs_scoresT.size(); i = i+1){
      text("#"+str(i+1)+":  "+str(meilleurs_scoresT.get(i).score), displayWidth/10, (i+2)*displayHeight/7);
      text(meilleurs_scoresT.get(i).nom, 3*displayWidth/10, (i+2)*displayHeight/7);
    }
    text("Mode Espace", displayWidth/2, displayHeight/7);
    for(int i=0; i<meilleurs_scoresG.size(); i = i+1){
      text("#"+str(i+1)+":  "+str(meilleurs_scoresG.get(i).score), displayWidth/2+20, (i+2)*displayHeight/7);
      text(meilleurs_scoresG.get(i).nom, 7*displayWidth/10+20, (i+2)*displayHeight/7);
    }
  }
  
  
  void drow(){}
  void mousePress(){}
 
  void mouseClick(){
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      fenetre = new Menu();
  }
  void keyPress(){}
}

class Score{
  int score;
  String nom;
  public Score(int nscore, String nnom){
    this.score = nscore;
    this.nom = nnom;
  }
  void keyPress(){}
}

ArrayList<Score> triScores(ArrayList<Score> liste){
  for(int i = 0; i<liste.size(); i++){
    int valMin = liste.size()-1;
    for(int j = liste.size()-1; j>=i; j--){
      if(liste.get(j).score>liste.get(valMin).score){
        valMin = j;
      }
    }
    Score c = liste.get(i);
    liste.set(i, liste.get(valMin));
    liste.set(valMin, c);
  }
  return liste;
  
}