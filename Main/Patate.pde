final PVector g = new PVector(0, -9.86);
final float G = 6.67*(10^(-11));
final float viscosite = 0.001002;//0.000017;
final float densite = 1;
final float parsec = 500;
final float echelle = 300;
final float mvpatate = 0.9;


class Patate{
  int type;
  float masse, taille;
  PImage img;
  PVector position, v;
  public Patate(int x, int y, float vx, float vy, float taille, int type){
    this.position = new PVector(x, y);
    this.v = new PVector(vx, vy);
    this.masse = 4*PI/3*pow(taille,3)*mvpatate;
    this.taille = taille;
    this.type = type;
    
    if (type == 0){
      this.img = loadImage("images/patate-" + type + "-" + int(random(3)));
    }else{
      this.img = loadImage("images/patate-" + type);
    }
  }
  
  void mouvementTerrestre(){
    PVector grav = PVector.mult(g, masse);
    PVector frottement = PVector.mult(v, -6*PI*taille*viscosite);
    PVector f = PVector.add(grav, frottement).add(PVector.mult(g, -densite*4*PI/3*pow(taille,3)));
    PVector a = PVector.div(f, this.masse);
    /*System.out.print(f);
    System.out.print(a);
    System.out.print(PVector.mult(v, -6*PI*taille*viscosite));
    System.out.print(this.position);
    System.out.println(this.v);*/
    this.v = PVector.add(v, PVector.div(a, parsec));
    this.position = PVector.add(this.position, PVector.div(this.v, parsec/echelle));
  }
  /*
  void mouvementGeo(){
    int d = (int)sqrt(pow(this.x,2)+(this.x)^2);
    float alpha = atan(x/y);
  }*/
}
