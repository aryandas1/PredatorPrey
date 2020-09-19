class Tile
{
  Cell myCell;
  private float grass;
  private float fertility;
  private int tileID;
  private float passChance;
  private boolean canGrow;
  private float acidPassChance;
  
  Tile(Cell c)
  {
    myCell = c;
    grass = (int) random(0, MAX_GRASS);
    canGrow = true;
    tileID = 0;
    passChance = 1;
    acidPassChance = 1;
  }
  public float getGrass()
  {
    return grass;
  }
  public boolean canPass()
  {
    return Math.random() < passChance;
  }
  public boolean canPass2()
  {
    return Math.random() < acidPassChance;
  }

  public void setFertility()
  {
    float noiseScale = .05;
    fertility = noise (myCell.getX() * noiseScale, myCell.getY() * noiseScale);
    grass = MAX_GRASS * fertility;
    if (fertility > SHALLOW_WATER_THRESHOLD)
    {
      canGrow = false; 
      tileID = 1;
      passChance = .6;
    }
    if (fertility > DEEP_WATER_THRESHOLD)
    {
      canGrow = false; 
      tileID = 2;
      passChance = 0;
    }
    if (fertility < ACID_THRESHOLD)
    {
      canGrow = false; 
      tileID = 3;
      passChance = 1;
    }
  }
  public void setSlowFertility()
  {
    float noiseScale = .045;
    fertility = noise (myCell.getX() * noiseScale, myCell.getY() * noiseScale);
    grass = MAX_GRASS * fertility;
    if (fertility > DESERT_THRESHOLD)
    {
      canGrow = false; 
      tileID = 4;
      passChance = .3;
    }
    if (fertility > .7)
    {
      canGrow = false; 
      tileID = 5;
      passChance = .005;
    }
  }
  public void display ()
  {
    noStroke();
    switch(tileID)
    {
    case 0:
      fill(105, 105 + grass/2, 0);
      break;
      //SHALLOW
    case 1:
      //fill(255,255,2);
      fill (0, 75, 205);
      break;
      //DEEP
    case 2:
      fill (0, 25, 205);
      break;
      //NUCLEAR WASTE
    case 3:
      fill (20, 255, 0);
      //fill(255,100,0);
      break;
      //SAND
    case 4:
      fill (255, 240, 100);
      break;
      //OASIS???
    case 5:
      fill (0, 240, 200);
      break;
    }
    rect (myCell.getX() * CELL_SIZE, myCell.getY() * CELL_SIZE, CELL_SIZE, CELL_SIZE);
  }
  public void act()
  {
    if (canGrow) 
    {
      grass+= GRASS_GROW * fertility;
    } else
    {
      grass = 0;
    }
    if (grass > MAX_GRASS * fertility)
    {
      grass = MAX_GRASS * fertility;
    }
  }
  public void removeGrass(float amount)
  {
    grass -= amount;
    if (grass < 0) grass = 0;
  }
}