class Instructions implements Fenetre {
  
  StringList instructions;
  PImage b_retour;
  public Instructions() {
    background(fondMenu);
    b_retour = loadImage("images/boutons/bouton-9.png");
    image(b_retour,displayWidth - 188/2, displayHeight - 143/2);
    int police = 30;
    textSize(police);
    fill(#ffff00);
    instructions = new StringList();
    for(String paragraphe : loadStrings("data/instructions-1.txt"))
      instructions.append(paragraphe);
    afficherTexte(instructions, police, 120, displayWidth-120, 75, 10);
    
  }
  void drow(){}
  void mousePress(){}
  void mouseClick(){
    if (mouseX > displayWidth-188 && mouseY > displayHeight-143)
      fenetre = new Menu();
  }
  void keyPress(){}
}



StringList decouperTexte(String texte, int taille, int largeur){        // Découpe un texte en plusieures lignes pour pouvoir l'afficher correctement
  int max = int(2.25*largeur/taille);
  StringList lignes = new StringList();
  String[] mots = split(texte, " ");
  String ligne = "    ";
  for(String mot : mots){
    if((ligne+mot).length() < max){
      ligne = ligne + mot + " ";
    }else{
      lignes.append(ligne);
      ligne = mot+" ";
    }
  }
  lignes.append(ligne);
  return lignes;
}

void afficherTexte(StringList texte, int taille, int gauche, int droite, int haut, int interligne){
  int i = 0;
  int largeur = droite-gauche;
  for(String paragraphe : texte){
    for(String ligne : decouperTexte(paragraphe, taille, largeur)){
      text(ligne, gauche, haut+i*(interligne+taille));
      i++;
    }
  }
}