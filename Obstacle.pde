abstract class Obstacle{
  PVector location = new PVector(0, 0);
  PVector size = new PVector(0, 0);
  boolean active = true;
  boolean isBlock = false;
  abstract void onCollision();
  abstract void display();
  int r, g, b;
  int r0, g0, b0;
  int framesPerFlash = 3;
  int flashFramesShown = 0;
  boolean flashNow = false;
  abstract void flashEnded();
  
  void flash(int _r,int _g, int _b)
  {
    r = _r;
    g = _g;
    b = _b;
    flashNow = true;
  }
  void resetColor()
  {
    r = r0;
    g = g0;
    b = b0;
  }  
  void flashEnd()
  {
    flashNow = false;
    flashFramesShown = 0;
    resetColor();
    flashEnded();
  }
  void processFlash()
  {
    if(flashNow)
    {
      if(flashFramesShown++ > framesPerFlash)
      {
       flashEnd();
      }
    }
  }
}