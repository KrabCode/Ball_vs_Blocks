class Platform extends Obstacle{
  PVector velocity;
  
  int speed;
  private boolean inputRight;
  private boolean inputLeft;
  Platform()
  {
   framesPerFlash = 10; 
   r0 = 0;
   g0 = 0;
   b0 = 0;
  }
  void flashEnded()
  {
    
  }
  void display()
  {
    stroke(255);
    fill(r,g,b);
    processFlash();
    rect(location.x, location.y, size.x, size.y);
  }
  
  void update()
  {    
      if(inputLeft && location.x > startX) velocity = new PVector(-speed, 0);      
      else if(inputRight && location.x < endX - size.x) velocity = new PVector(speed, 0);        
      else velocity = new PVector(0, 0);      

      location.add(velocity);    
  }
  
    
  void onCollision(){    
    flash(100, 100, 255);
    ball.velocity.rotate(this.velocity.x);    
  }
  
}