SoundFile musique, soneau, sonstart, soncoupe, sonrate,sonerreur, sonachat, musique_mlg, sonx2;
int aleat;


void musique_menu(){
  musique = new SoundFile(this, "son/musique-menu.mp3");
  musique.loop();
}

void musique_cuisine(){
  musique = new SoundFile(this, "son/musique-partie.wav");
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
  soncoupe = new SoundFile(this,"son/son-coupe"+str(aleat)+".mp3");
  soncoupe.play();
}