SoundFile musique, soncoupe1, soncoupe2, sonrate,sonerreur, musique_mlg;


void musique_menu(){
  musique = new SoundFile(this, "son/musique-menu.mp3");
}

void musique_cuisine(){
  musique = new SoundFile(this, "son/musique-partie(boucle).mp3");
}

void musique_space(){
  musique = new SoundFile(this, "son/musique-space.mp3");
}

void musique_mlg(){
  musique_mlg = new SoundFile(this, "son/musique-MLG.mp3");
}