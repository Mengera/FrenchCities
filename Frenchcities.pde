//Mengzhu.Deng Assingment #1#2

float minX, maxX;
float minY, maxY;
int totalCount; // total number of places
float minPopulation, maxPopulation;
float minSurface, maxSurface;
float minAltitude, maxAltitude;

int[] poscode, population;
float[] x,y,density,surface;
String[] name;
boolean[] highlighted;

Place[] city;
HScrollbar hs;

int lastPickedCity = totalCount;
float minPopulationToDisplay = 10000;

color black = color(0);
color orange = color(204, 102, 0);
PFont myFont;

void parseInfo(String line) {
  String infoString = line.substring(2); // remove the #
  String[] infoPieces = split(infoString, ',');
  totalCount = int(infoPieces[0]);
  minX = float(infoPieces[1]);
  maxX = float(infoPieces[2]);
  minY = float(infoPieces[3]);
  maxY = float(infoPieces[4]);
  minPopulation = float(infoPieces[5]);
  maxPopulation = float(infoPieces[6]);
  minSurface = float(infoPieces[7]);
  maxSurface = float(infoPieces[8]);
  minAltitude = float(infoPieces[9]);
  maxAltitude = float(infoPieces[10]);
  println(  maxPopulation);
}

void setup(){
  size(800,800);
  myFont = loadFont("Athelas-Regular-48.vlw");
  textFont(myFont,16);
  readData();
  hs = new HScrollbar(0, height-150, width, 16, 16);
}

void draw(){
  background(225);
  city = new Place[totalCount];
  text("Displaying populations above " + int (minPopulationToDisplay), 300, 700);
  text("Manipulate slider or Press LEFT/RIGHT", 285, 730);
  for(int i = 0; i < totalCount; ++i){
    city[i] = new Place(poscode[i], name[i], x[i], y[i], population[i],density[i], highlighted[i]);
    if(city[i].population > minPopulationToDisplay){
      city[i].draw();
    }
  } 
  //log scale
  float temp = hs.getPos();
  float minPopulationToDisp = map(temp, 0,800, minPopulation+1, log(maxPopulation)/log(8));
  minPopulationToDisplay = pow( minPopulationToDisp, 8);
  hs.update();
  hs.display();
}

int pick(int px, int py){
  for(int i = totalCount -1; i > 0; i--){
   if(city[i].contains(px, py) == true){
     return i;
   }   
  }
  return -1;
}

void mouseMoved() {
  int number = pick(mouseX, mouseY);
  if(pick(mouseX, mouseY) != -1){
  highlighted[number] = true;
  if(number != lastPickedCity){
      highlighted[lastPickedCity] = false;
      lastPickedCity = number;
      redraw();
  } 
  }  
}

void readData(){
  String[] lines = loadStrings("villes.tsv");
  //println(lines);
  parseInfo(lines[0]); // read the header line
  
  poscode = new int[totalCount];
  x = new float[totalCount];
  y = new float[totalCount];
  density = new float[totalCount];
  name = new String[totalCount];
  population = new int[totalCount];
  surface = new float[totalCount];
  highlighted = new boolean[totalCount+1];
  
  for(int i = 2; i < totalCount; ++i){
    String pieces[] = split(lines[i], TAB);
    poscode[i-2] = int (pieces[0]);
    x[i-2] = float (pieces[1]);
    y[i-2] = float (pieces[2]);
    name[i-2] = pieces[4];
    population[i-2] = int (pieces[5]);
    surface[i-2] = float (pieces[6]);
    highlighted[i-2] = false;
  }
}