class Instructions implements Fenetre {
  
  PFont policeinstructions;
  String[] instructions;
  PImage fond, b_retour;
  public Instructions() {
    fond = loadImage("images/fonds/fond-menu.png");
    fond.resize(displayWidth,displayHeight);
    background(fond);
    b_retour = loadImage("images/boutons/bouton-9.png");
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    int police = 30;
    textSize(police);
    fill(#ffff00);
    policeinstructions = loadFont("TrebuchetMS-30.vlw");
    instructions = loadStrings("data/instructions-1.txt");
    StringList texte = new StringList();
    for(int i=0; i< instructions.length; i = i+1){
      texte.append(decouperTexte(instructions[i], police));
    }
    for(int i=0; i<texte.size(); i++){
      text(texte.get(i), 100, i*40+50);
      println(texte.get(i));
    }
    
  }
  void drow(){}
  void mousePress(){}
  void mouseClick(){
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      fenetre = new Menu();
  }
}



class Records implements Fenetre {
  
  PImage fond, b_retour;
  public Records() {
    textSize(50);
    fill(255,255,0);
    fond = loadImage("images/fonds/fond-menu.png");
    fond.resize(displayWidth,displayHeight);
    background(fond);
    b_retour = loadImage("images/boutons/bouton-9.png");
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    text("Mode Cuisine", displayWidth/10-20, displayHeight/7);
    for(int i=0; i<meilleurs_scoresT.size(); i = i+1)
      text("#"+str(i+1)+":  "+str(meilleurs_scoresT.get(i)), displayWidth/10, (i+2)*displayHeight/7);
    text("Mode Espace", displayWidth/2, displayHeight/7);
    for(int i=0; i<meilleurs_scoresG.size(); i = i+1)
      text("#"+str(i+1)+":  "+str(meilleurs_scoresG.get(i)), displayWidth/2+20, (i+2)*displayHeight/7);
    
    }
  
  
  void drow(){}
  void mousePress(){}
 
  void mouseClick(){
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      fenetre = new Menu();
  }
}

StringList decouperTexte(String texte, int taille){        // Découpe un texte en plusieures lignes pour pouvoir l'afficher correctement
  int max = 2*(displayWidth-200)/taille;
  StringList lignes = new StringList();
  String[] mots = split(texte, " ");
  String ligne = "    ";
  for(String mot : mots){
    if((ligne+" "+mot).length() < max){
      ligne = ligne + " " + mot;
    }else{
      lignes.append(ligne);
      ligne = mot;
    }
  }
  lignes.append(ligne);  
  return lignes;
}