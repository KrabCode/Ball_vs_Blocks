class Ball
{
  float radius;
  PVector location;  
  PVector velocity;
  
  void display()
  {
    
    fill(255);
    ellipse(location.x, location.y, radius, radius);
  }
  
  void update()
  {
    Direction bounceDirection = isCollision(obstacles);
    if(bounceDirection != null) bounceInDirection(bounceDirection);    
    location.add(velocity);
  }
  
  void bounceInDirection(Direction bounceDirection)
  {
    switch(bounceDirection)
      {
        case up:
        {
          bounce(1, -1);
          break;
        }
        case down:
        {
          bounce(1, -1);
          break;
        }
        case right:
        {
          bounce(-1, 1);
          break;
        }
        case left:
        {
          bounce(-1, 1);
          break;
        }
      }
  }
  
  void bounce(int xNormalized, int yNormalized)
  {
    velocity = new PVector(velocity.x * xNormalized, velocity.y * yNormalized);    
  }
  
  Direction isCollision(ArrayList<Obstacle> obstacles)
  {
    for(Obstacle obstacle : obstacles )
    {
      if(obstacle.active)
      {
        float cx = location.x;
        float cy = location.y;
        
        float rx = obstacle.location.x; 
        float ry = obstacle.location.y; 
        float rw = obstacle.size.x;
        float rh = obstacle.size.y;

        // temporary variables to set edges for testing
        float testX = cx;
        float testY = cy;
      
        // which edge is closest?
        if (cx <= rx)    testX = rx;      // test left edge
        else if (cx >= rx+rw) testX = rx+rw;   // right edge        
        if (cy <= ry)    testY = ry;      // top edge
        else if (cy >= ry+rh) testY = ry+rh;   // bottom edge
        
      /*
      -----------------  1=obstacle.location
      ---o-----1xxx----  2=obstacle.size
      --o3o----x--x----  3=this.location
      ---o-----xxx2----  
      -----------------
      */
      
        // get distance from closest edges
        float distX = cx-testX;
        float distY = cy-testY;
        float distance = sqrt( (distX*distX) + (distY*distY) );
        // if the distance is less than the radius, collision!
        if (distance <= radius) {
          obstacle.onCollision();
          // which edge is closest?
          if (cx < rx)         return Direction.left; 
          else if (cx > rx+rw) return Direction.right;
          if (cy < ry)         return Direction.up;  
          else if (cy > ry+rh) return Direction.down;
        }
      }
    }
    return null;
  }
}