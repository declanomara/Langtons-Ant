class Ant
{
  private int x;
  private int y;
  private int facing;
  
  public Ant(int xP, int yP)
  {
    x = xP;
    y = yP;
    facing = (int)Math.random() * 4;
  }
  
  public void flipPixel(int[] pixel, int[][] grid)
  {
    int index = x + y * height;
    
    if(grid[y][x] == 0)
    {
      grid[y][x] = 1;
      pixel[index] = BLACK;
    }
    
    else
    {
      grid[y][x] = 0;
      pixel[index] = WHITE;
    }
  }
  
  public void updateFacing(int[][] grid)
  {
    if(grid[y][x] == 1) facing--;
    else facing++;
    if(facing>3) facing = 0;
    if(facing<0) facing = 3;
    
  }
  public void move(PImage board, int[][] grid)
  {
    board.loadPixels();
    
    updateFacing(grid);
    
    int index = x + y * height;
    board.pixels[index] = RED;
    flipPixel(board.pixels, grid);
    
    if(facing == moveUP) y--;
    if(facing == moveDOWN) y++;
    if(facing == moveRIGHT) x++;
    if(facing == moveLEFT) x--;
    
    if(x < 0) x = width-2;
    if(y < 0) y = height-2;
    if(x > (width - 1)) x = 2;
    if(y > (height - 1)) y = 2;
    
    
    board.updatePixels();
  }
}

Ant[] ants = new Ant[10];
PImage board;
int[][] grid;
int moves = 100;

final color WHITE = color(255);
final color BLACK = color(0);
final color RED = color(255,0,0);

final int moveUP = 0;
final int moveRIGHT = 1;
final int moveDOWN = 2;
final int moveLEFT = 3;

void setup()
{
  size(900, 900);
  frameRate(300);
  //fullScreen();
  grid = new int[height][width];
  board = createImage(width, height, RGB);
  
  board.loadPixels();
  
  for(int i = 0; i < board.pixels.length; i++)
  {
    board.pixels[i] = WHITE;
    //System.out.println(board.pixels[i]);
  }
  board.updatePixels();
  
  for(int i = 0; i < ants.length; i++)
  {
    ants[i]=new Ant(width/2,height/2);
  }
}

void draw()
{
  
  if(frameRate < 60 && moves > 1) moves-= 5;
  if(frameRate > 60) moves+=5;
  for(int i = 0; i<moves; i++)
  {
    image(board,0,0);
    for(Ant ant: ants)
      ant.move(board, grid);
  }
  System.out.println("FPS: " + frameRate + " Moves: " + moves);
}
