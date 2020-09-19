Cell [][] cells;
Table table;

int countPrey;
int countPred;
int countGoodPrey;
int countGoodPred;
int countGrass;
int time = 0;

void setup()
{
  noStroke();
  size (1000, 850);
  setupCells();
  makePrey();
  makePredator();
  setupFertility();
  setupSlow();
  //setupTable();
}

void draw()
{
  display();
  println ("FPS: " + (int)frameRate);
  println ("GRASS COUNT: " + countGrass);
  displayCells();
  actCells();
  updateCells();
  //makeCells();
}
void setupTable()
{
  table = new Table();
  table.addColumn("Grass");
  table.addColumn("Prey");
  table.addColumn("Predator");
  table.addColumn("Time");
}
void display()
{
  time++;
  println("TIME: " + (float)time/60);
  background(0);
  fill(255);
  textSize(18);
  text("Prey Count = " + (countPrey - countGoodPrey), 20, 820);
  text("Predator Count = " + (countPred - countGoodPred), 220, 820);
  fill(255, 255, 0);
  text("Smart Prey Count = " + countGoodPrey, 470, 820);
  fill(255, 0, 0);
  text("Smart Predator Count = " + countGoodPred, 720, 820);
  fill(0);
}
void setupSlow()
{
  noiseSeed((Long) Long.MAX_VALUE);
  for (int i = 0; i < WORLD_WIDTH; i++)
  {
    for (int j = 0; j < WORLD_HEIGHT; j++)
    {
      cells [i][j].setSlowFertility();
    }
  }
}
void setupFertility()
{
  //noiseSeed((Long) Long.MAX_VALUE);
  for (int i = 0; i < WORLD_WIDTH; i++)
  {
    for (int j = 0; j < WORLD_HEIGHT; j++)
    {
      cells [i][j].setFertility();
    }
  }
}
void makePredator()
{
  for (int i = 0; i < STARTING_PREDATOR; i++)
  {
    int rX;
    int rY;
    do
    {
      rX = (int) random(WORLD_WIDTH);
      rY = (int) random(WORLD_HEIGHT);
    }
    while  (cells[rX][rY].hasAnimal() || !cells [rX][rY].getTile().canPass());
    cells[rX][rY].addAnimal(new Predator(cells [rX][rY]));
  }
}
void makePrey()
{
  for (int i = 0; i < STARTING_PREY; i++)
  {
    int rX;
    int rY;
    do
    {
      rX = (int) random(WORLD_WIDTH);
      rY = (int) random(WORLD_HEIGHT);
    }
    while  (cells[rX][rY].hasAnimal() || !cells [rX][rY].getTile().canPass());
    cells[rX][rY].addAnimal(new Prey(cells [rX][rY]));
  }
}
void setupCells()
{
  cells = new Cell[WORLD_WIDTH][WORLD_HEIGHT];
  for (int i = 0; i < WORLD_WIDTH; i++)
  {
    for (int j = 0; j < WORLD_HEIGHT; j++)
    {
      cells [i][j] = new Cell (i, j);
    }
  }
}
void displayCells()
{
  for (int i = 0; i < WORLD_WIDTH; i++)
  {
    for (int j = 0; j < WORLD_HEIGHT; j++)
    {
      cells [i][j].display();
    }
  }
}
void actCells()
{
  for (int i = 0; i < WORLD_WIDTH; i++)
  {
    for (int j = 0; j < WORLD_HEIGHT; j++)
    {
      cells [i][j].act();
    }
  }
}
void updateCells()
{
  countPrey = 0;
  countPred = 0;
  countGoodPrey = 0;
  countGoodPred = 0;
  countGrass = 0;

  for (int i = 0; i < WORLD_WIDTH; i++)
  {
    for (int j = 0; j < WORLD_HEIGHT; j++)
    {
      cells [i][j].update();
    }
  }
  //drawTable();
}
void drawTable()
{
  TableRow newRow = table.addRow();
  newRow.setInt("Grass", countGrass);
  newRow.setInt("Prey", countPrey);
  newRow.setInt("Predator", countPred);
  newRow.setFloat("Time", time/60);

  saveTable(table, "data.csv");
}
public boolean inBounds(int x, int y)
{
  return x >= 0 && y >= 0 && x < WORLD_WIDTH && y < WORLD_HEIGHT;
}