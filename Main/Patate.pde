final PVector g = new PVector(0, -9.86);
final float G = 6.67*(10^(-11));
final float viscosite = 0.017*(10^-3);
final float densite = 0;
final float parsec = 2.5;

class Patate{
  int type;
  float masse, taille;
  PImage img;
  PVector position, v;
  public Patate(int x, int y, int vx, int vy, int masse, float taille, int type){
    this.position = new PVector(x, y);
    this.v = new PVector(vx, vy);
    this.masse = masse;
    this.taille = taille;
    this.type = type;
    
    if (type == 0){
      this.img = loadImage("images/patate-" + type + "-" + int(random(3)));
    }else{
      this.img = loadImage("images/patate-" + type);
    }
  }
  
  void mouvementTerrestre(){
    
    PVector f = PVector.mult(g, masse).add(PVector.mult(v, -6*PI*taille*viscosite));//*(1-densite*4*PI/3*pow(taille,3))
    System.out.print(f);
    System.out.print(PVector.mult(g, masse));
    System.out.print(g);
    System.out.println(PVector.mult(v, -6*PI*taille*viscosite));
    this.v = this.v.add(f.div(parsec*this.masse));
    this.position = this.position.add(this.v.div(parsec));
  }
  /*
  void mouvementGeo(){
    int d = (int)sqrt(pow(this.x,2)+(this.x)^2);
    float alpha = atan(x/y);
  }*/
}
