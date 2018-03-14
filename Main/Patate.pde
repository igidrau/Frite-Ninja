final PVector g = new PVector(0, -9.86);
final float G = 6.67*(10^(-11));
final float viscosite = 0.000017; //0.01002 (air : 0.000017, eau : 0.001002 (remonté à 0.01002 pour accentuer l'effet))
final float densite = 0; //1 (air : 0, eau : 1)
final float parsec = 500; // le nombre d'images par seconde
final float echelle = 500; // 1 m = ...px
final float mvpatate = 1; // la densité d'une patate (à ajuster)


class Patate{
  int type;
  float masse, taille;
  PImage img;
  PVector position, v;
  public Patate(int x, int y, float vx, float vy, float taille, int type){
    this.position = new PVector(x, y);
    this.v = new PVector(vx, vy);
    this.masse = 4*PI/3*pow(taille,3)*mvpatate; //calcul de la masse en fonction du diamètre et de la densité
    this.taille = taille;
    this.type = type;
    
    if (type == 0){
      this.img = loadImage("images/patate-" + type + "-" + int(random(3))); //chargement du skin de la patate en fonction de son type (non fonctionnel)
    }else{
      this.img = loadImage("images/patate-" + type);
    }
  }
  
  void mouvementTerrestre(){ //simule le déplacement d'une patate dans un référentiel terrestre (fonctionnel)
    PVector grav = PVector.mult(g, masse);
    PVector frottement = PVector.mult(v, -6*PI*taille*viscosite);
    PVector f = PVector.add(grav, frottement).add(PVector.mult(g, -densite*4*PI/3*pow(taille,3)));
    PVector a = PVector.div(f, this.masse);
    this.v = PVector.add(v, PVector.div(a, parsec));
    this.position = PVector.add(this.position, PVector.div(this.v, parsec/echelle));
  }
  /*
  void mouvementGeo(){ //simule le déplacement d'une patate dans un référentiel géocentrique (non fonctionnel)
    int d = (int)sqrt(pow(this.x,2)+(this.x)^2);
    float alpha = atan(x/y);
  }*/
}
