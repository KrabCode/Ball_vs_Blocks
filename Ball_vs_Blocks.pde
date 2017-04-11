enum Direction{up, right, down, left}
ArrayList<Obstacle> obstacles;

Ball ball;
Platform platform;

int startX;
int startY;
int endX;
int endY;

int blockXCount = 6;
int blockYCount = 3;


float ballSpeed = 6;
int sceneX = 1240;
int sceneY = 700;

void setup()
{
  background(0);
  frameRate(30);
  orientation(LANDSCAPE);
  obstacles = new ArrayList<Obstacle>();
  buildScene();
  buildWalls();
  buildBlocks(blockXCount, blockYCount);  
  buildPlatform();
  buildBall(platform.location, platform.size);
}

void draw()
{
   background(0);
   noStroke();
   fill(0);
   rect(0,0, startX, endY);
   rect(0,0, width, startY);
   rect(0,endY, width, startY);
   rect(endX, startY, width, height);
   ball.update();
   ball.display();
   platform.update();
   platform.display();
   int blockCount = 0;
   for(Obstacle o : obstacles)
   {
     o.display();
     if(o.isBlock && o.active) blockCount++;
   } 
   if(blockCount == 0){
     buildBlocks(++blockXCount, ++blockYCount);
   }
}

void buildScene()
{
    sceneX = width;
    sceneY = height;
    startX = (width - sceneX) / 2;
    startY = (height - sceneY) / 2;
    endX = width - startX;
    endY = height - startY;
    println(width + "*"  + height);
}

void buildBlocks(int blockHorizontalCount, int blockVerticalCount)
{ 
  int bottomMargin = 400;
  int leftMargin = 50;
  int rightMargin = 100;
  int topMargin = 100;
  PVector blockSize = new PVector((endX - startX - rightMargin) / blockHorizontalCount, (endY - bottomMargin)/ blockVerticalCount); 
  for(int x = 0 ;x < blockHorizontalCount; x++)
  {
    for(int y = 0 ;y < blockVerticalCount; y++)
    {
      Block b = new Block();      
      b.location = new PVector(startX + leftMargin + x * blockSize.x, startY + topMargin + y * blockSize.y);
      b.size = blockSize;
      b.isBlock = true;
      obstacles.add(b);
    }
  }
}

void buildWalls()
{
  Wall left = new Wall();
  left.location = new PVector(startX, startY);
  left.size = new PVector(10, endY - startY);
  
  Wall right = new Wall();
  right.location = new PVector(endX-11, startY);
  right.size = new PVector(10, endY - startY);
  
  Wall top = new Wall();
  top.location = new PVector(startX, startY);
  top.size = new PVector(endX - startX, 10);
  
  BottomWall bottom = new BottomWall();
  bottom.location = new PVector(startX, endY - 10);
  bottom.size = new PVector(endX - startX, 10);
  
  obstacles.add(left);
  obstacles.add(right);
  obstacles.add(top);
  obstacles.add(bottom);
}

void buildBall(PVector platformLocation, PVector platformSize)
{
  ball = new Ball();
  ball.location = PVector.sub(platformLocation, platformSize);
  ball.radius = 10;
  ball.velocity = new PVector(ballSpeed, -ballSpeed); 
}

void buildPlatform()
{
  platform = new Platform();
  platform.location = new PVector(width/2, endY - 50);
  platform.size = new PVector(130, 25);
  platform.speed = 10;
  obstacles.add(platform);
}

void mousePressed()
{  
    if(mouseX < platform.location.x + platform.size.x/2)
    {
      platform.inputLeft = true;
    }    
    else
    {
      platform.inputRight = true;
    }
}

void mouseReleased()
{   
    platform.inputLeft = false;    
    platform.inputRight = false;    
}

void keyPressed()
  {
    if(keyCode == LEFT || key == 'A')
    {
      platform.inputLeft = true;
    }    
    if(keyCode == RIGHT || key == 'D')
    {
      platform.inputRight = true;
    }
  }
  void keyReleased()
  {
    if(keyCode == LEFT|| key == 'A')
    {
      platform.inputLeft = false;
    }    
    if(keyCode == RIGHT|| key == 'D')
    {
      platform.inputRight = false;
    }
}