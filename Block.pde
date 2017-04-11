class Block extends Obstacle{
  int hitPoints = 1;
  
  Block()
  {
   framesPerFlash = 1; 
  }
  
  void display()
  {
    if(active)
    {
      
      stroke(255, 255, 255);
      fill(r,g,b);
      processFlash();
      rect(location.x, location.y, size.x, size.y);
    }
  }
 
  void flashEnded()
  {
      active = false;
  }
    
  void destroy()
  {
    flash(255, 255, 255);
  }
  
  void onCollision(){
    hitPoints -= 1;
    if(hitPoints < 1)
    {
     destroy(); 
    }
  }
}