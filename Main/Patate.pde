final float g = 9.86;
final float G = 6.67*(10^(-11));
final float friction = 0;
final float densite = 0;

class Patate{
  int x, y, type;
  float vx, vy, masse, taille;
  String img;
  public Patate(int x, int y, int vx, int vy, int masse, float taille, int type){
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.masse = masse;
    this.taille = taille;
    this.type = type;
    
    if (type == 0){
      this.img = "patate-" + type + "-" + random(3);
    }else{
      this.img = "patate-" + type;
    }
  }
  
  void mouvementTerrestre(){
    float ax = 
    this.x += this.vx/20;
    this.y += this.vy/20;
    this.vy -= g;  
  }
  
  void mouvementGeo(){
    int d = (int)sqrt((this.x)^2+(this.x)^2);
    float alpha = atan(x/y);
  }
}}
