final PVector g = new PVector(0, -9.86);
final float Gnb = 6.67; //SI
final int Gpw = -11;
final float viscosite = 0.000017; // (air : 0.000017, eau : 0.001002 (remonté à 0.002002 pour accentuer l'effet)) SI
final float densite = 0; //1 (air : 0, eau : 1) kg/L
final float mvpatate = 1.1; // la densité d'une patate (à ajuster) kg/L
final float mTerrenb = 5.9722; //kg
final int mTerrepw = 24;
final float rTerrenb = 3.1855; //m
final int rTerrepw = 6;
final PVector terre = new PVector(0,0);


class Patate{
  int type;
  float masse, taille;
  PImage img;
  PVector position, v;
  public Patate(float x, float y, float vx, float vy, float taille, int type){
    this.position = new PVector(x, y);
    this.v = new PVector(vx, vy);
    this.masse = 4*PI/3*pow(taille,3)*mvpatate; //calcul de la masse en fonction du diamètre et de la densité
    this.taille = taille;
    this.type = type;
    
    String nom ="";
    if (type == 0){
      nom = "patate-" +type + "-" + int(random(3)) + ".png";
    }else{
      nom = "patate-" + type + ".png";
    }
    this.img = loadImage(nom);
  }
  
  void mouvementTerrestre(){ //simule le déplacement d'une patate dans un référentiel terrestre (fonctionnel)
    PVector grav = PVector.mult(g, masse);
    PVector frottement = PVector.mult(v, -6*PI*taille*viscosite);
    PVector f = PVector.add(grav, frottement).add(PVector.mult(g, -densite*4*PI/3*pow(taille,3)));
    PVector a = PVector.div(f, this.masse);
    this.v = PVector.add(v, PVector.div(a, parsec));
    this.position = PVector.add(this.position, PVector.div(this.v, parsec));
  }
  
  void mouvementGeo(){ //simule le déplacement d'une patate dans un référentiel géocentrique (non fonctionnel)
    float d = sqrt(pow(this.position.x,2)+pow(this.position.y,2));
    float pds = Gnb*mTerrenb*this.masse/pow(d,2) * pow(10, Gpw+mTerrepw);
    float alpha = atan(this.position.y/this.position.x)%(2*PI);
    PVector a = PVector.div(this.position, d).mult(-pds/this.masse);
    this.v.add(PVector.div(a,parsec));
    this.position.add(PVector.div(this.v, parsec));
  }
}
