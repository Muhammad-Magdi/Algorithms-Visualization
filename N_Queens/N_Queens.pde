int cellH = 38, cellW = 38, n = 8;
PImage img;
boolean [][] grid;
boolean [] visC, visMD, visSD;
boolean firstTime = true;

Thread thread;

void setup(){
  size(560, 560);
  cellH = 560/n;
  cellW = 560/n;
  
  grid = new boolean[n][n];
  visC = new boolean[n];
  visMD = new boolean[2*n];
  visSD = new boolean[2*n];
  img = loadImage("queen.png");
  thread = new Thread(new MyThread());
  
  thread.start();
}

void draw(){
  if(thread.isAlive())
    drawGrid();
  else{
    noLoop();
    endRecord();
    return;
  }
}

void drawGrid(){
  background(255);
  for(int r = 0 ; r < n ; ++r){
   for(int c = 0 ; c < n ; ++c){
     if((r&1) != (c&1)) fill(0);
     else  fill(255);
     rect(c*cellW, r*cellH, (c+1)*cellW, (r+1)*cellH);
     if(grid[r][c] == true)
       image(img, c*cellW, r*cellH, cellW, cellH);
   }
  }
}

boolean backTrack(int r){
  if(r == n)  return true;
  else{
    for(int c = 0 ; c < n ; ++c){
      if(!visC[c] && !visMD[n+r-c] && !visSD[r+c]){
        //Do
        grid[r][c] = visC[c] = visMD[n+r-c] = visSD[r+c] = true;
        
        try{
          Thread.sleep(200);
        }catch(InterruptedException e){System.out.println(e);}  
        
        //Recurse
        if(backTrack(r+1))  return true;
        //Undo
        grid[r][c] = visC[c] = visMD[n+r-c] = visSD[r+c] = false;
        
        try{
          Thread.sleep(200);
        }catch(InterruptedException e){System.out.println(e);}
      }
    }
  }
  return false;
}

class MyThread implements Runnable{    
  public void run(){    
    backTrack(0);    
  }
}  

void mousePressed(){
  thread.suspend();
}

void mouseReleased(){
  thread.resume();
}
