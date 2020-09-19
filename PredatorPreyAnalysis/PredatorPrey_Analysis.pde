Table table;
ArrayList<Datapoint> data;
float maxGrass = 5567247;
float maxPrey = 1593;
float maxPred = 1882;
float maxTime = 712;
float scaleFactorX = 1;
float scaleFactorY = .25;
int keyTimer1 = 0;
int keyTimer2 = 0;
int keyTimer3 = 0;
boolean grassToggle = true;
boolean predToggle = true;
boolean preyToggle = true;
//final int TOGGLE_TIMER = 15;
void setup()
{
  table = loadTable("data.csv", "header");
  data = new ArrayList <Datapoint>();
  strokeWeight(1);
  size(1200, 800);
  loadGraph();
  prank();
}
void draw()
{
  background(0);
  //timers();
  drawGraph();
  textAlign(CENTER);
  //drawPrank();
  drawKey();
  println(keyTimer1);
}
void loadGraph()
{
  for (TableRow row : table.rows())
  {
    int grass = row.getInt("Grass");
    int prey = row.getInt("Prey");
    int preds = row.getInt("Predator");
    float time = row.getFloat("Time");

    data.add(new Datapoint(grass, prey, preds, time));
  }
}
void drawGraph()
{  
  //if (keyTimer1 > 0) keyTimer1--;
  strokeWeight(1);
  float grassScale = (width / maxGrass) * scaleFactorY;
  float preyScale = (width / maxPrey) * scaleFactorY;
  float predScale = (width / maxPred) * scaleFactorY;
  float timeScale = (width / maxTime) * scaleFactorX;
  float spacing = width / 3.2;
  for (int i = 0; i < data.size() - 1; i++)
  {
    int grass = data.get(i).getGrass();
    int grass2 = data.get(i + 1).getGrass();
    int prey = data.get(i).getPrey();
    int prey2 = data.get(i + 1).getPrey();
    int preds = data.get(i).getPredator();
    int preds2 = data.get(i + 1).getPredator();
    float time = data.get(i).getTime();
    float time2 = data.get(i + 1).getTime();

    if (keyPressed && key == '1' && keyTimer1 <= 0)
    {
      grassToggle = !grassToggle;
      keyTimer1 = 5;
    } 
    if (keyTimer1 > 0)
    {
      keyTimer1--;
    }
    if (grassToggle)
    {
      stroke (0, 255, 0);
      line(time * timeScale, (grass * grassScale), time2 * timeScale, (grass2 * grassScale));
    }
    if (keyPressed && key == '2' && keyTimer2 <= 0)
    {
      predToggle = !predToggle;
      keyTimer2 = 5;
    } 
    if (keyTimer2 > 0)
    {
      keyTimer2--;
    }
    if (predToggle)
    {
      stroke(255, 0, 0);
      line(time * timeScale, (preds * predScale) + spacing, time2 * timeScale, (preds2 * predScale) + spacing);
    }    
    if (keyPressed && key == '3' && keyTimer3 <= 0)
    {
      preyToggle = !preyToggle;
      keyTimer3 = 5;
    } 
    if (keyTimer3 > 0)
    {
      keyTimer3--;
    }
    if (preyToggle)
    {
      stroke (255);
      line(time * timeScale, (prey * preyScale) + spacing, time2 * timeScale, (prey2 * preyScale) + spacing);
    }
  }
}
void keyPressed()
{
}
void prank()
{
  PFont f = createFont("Comic Sans MS", 36);
  textFont(f);
}
void drawPrank()
{
  fill (random(255), random(255), random(255));
  text("LINE GRAPH", width/2, height/2);
}
void drawKey()
{
  text("Grass (1)", width - 300, 50); 
  stroke(0, 255, 0);
  strokeWeight(40);
  line (width - 200, 25, width - 20, 25);
  text("Predator (2)", width - 330, 100);
  stroke(255, 0, 0);
  line (width - 200, 90, width - 20, 90);
  text("Prey (3)", width - 300, 150);
  stroke (255);
  line (width - 200, 160, width - 20, 100);
}