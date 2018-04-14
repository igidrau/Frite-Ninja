SoundFile musique;


void musique_menu(){
  musique = new SoundFile(this, "musique-menu.mp3");
}

void musique_cuisine(){
  musique = new SoundFile(this, "musique-partie(boucle).mp3");
}

void musique_space(){
  musique = new SoundFile(this, "musique-space.mp3");
}