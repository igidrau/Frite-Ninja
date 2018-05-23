SoundFile musique, soneau, sonstart, soncoupe, sonrate,sonerreur, sonachat, musique_mlg, sonx2, sad;
int aleat;

void musique_menu(){                                                //charge et joue la musique du menu en boucle
  musique = new SoundFile(this, "son/musique-menu.mp3");
  musique.loop();
}

void musique_cuisine(){                                             //charge et joue la musique de a cuisine en boucle
  musique = new SoundFile(this, "son/musique-partie.mp3");
  musique.loop();
}

void musique_space(){                                                //charge et joue la musique de l'espace en boucle
  musique = new SoundFile(this, "son/musique-space.mp3");
  musique.loop();
}

void musique_mlg(){                                              //charge et joue la musique du bonus MLG
  musique_mlg = new SoundFile(this, "son/musique-MLG.mp3");
  musique_mlg.play();
}

void son_coupe(){                                                      //charge et joue un son de coupe entre deux possibilité
  String nom = "son/son-coupe"+str((int)random(0,3))+".mp3";
  soncoupe = new SoundFile(this,nom);
  soncoupe.play();
}

void defaite(){                                      //charge et joue le célèbre sad trombone pour se moquer du joueur venant tout juste de perdre
  sad = new SoundFile(this, "son/sad trombone.mp3");
  sad.play();
}