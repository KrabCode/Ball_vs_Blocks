class Wall extends Obstacle{
  
  void flashEnded()
  {
    
  }
   
  void onCollision(){
    framesPerFlash=5;
    flash(0,0,255);
  }
  void display(){
    stroke(r,g,b);
    fill(0);
    processFlash();
    rect(location.x, location.y, size.x, size.y);
  }
}

class BottomWall extends Wall{
  void onCollision(){
    //platform.flash(255,0,0);
    framesPerFlash = 5;
    flash(255,0,0);
  }
}