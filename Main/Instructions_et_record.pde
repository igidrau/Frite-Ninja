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
    textSize(20);
    fill(#ffff00);
    policeinstructions = loadFont("TrebuchetMS-30.vlw");
    textFont(policeinstructions);
    instructions = loadStrings("data/instructions-1.txt");
    StringList texte = new StringList();
    for(int i=0; i< instructions.length; i = i+1){
      texte.append(decouperTexte(instructions[i], 85));
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
    for(int i=0; i<meilleurs_scores.size(); i = i+1)
      text("#"+str(i+1)+":  "+str(meilleurs_scores.get(i)), displayWidth/10, (i+1)*displayHeight/6);
    }
  
  
  void drow(){}
  void mousePress(){}
 
  void mouseClick(){
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      fenetre = new Menu();
  }
}

StringList decouperTexte(String texte, int max){        // Découpe un texte en plusieures lignes pour pouvoir l'afficher correctement
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