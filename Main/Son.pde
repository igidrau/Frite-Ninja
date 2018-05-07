SoundFile musique, soneau, sonstart, soncoupe, sonrate,sonerreur, sonachat, musique_mlg, sonx2;
int aleat;

void son_start(){
  SoundFile start = new SoundFile(this, "son/son-start.mp3");
  start.play();
}

void musique_menu(){
  musique = new SoundFile(this, "son/musique-menu.mp3");
  musique.loop();
}

void musique_cuisine(){
  musique = new SoundFile(this, "son/musique-partie.mp3");
  musique.loop();  
}

void musique_space(){
  musique = new SoundFile(this, "son/musique-space.mp3");
  musique.loop();
}

void musique_mlg(){
  musique_mlg = new SoundFile(this, "son/musique-MLG.mp3");
  musique_mlg.play();
}

void son_coupe(){
  String nom = "son/son-coupe"+str((int)random(0,3))+".mp3";
  soncoupe = new SoundFile(this,nom);
  soncoupe.play();
}