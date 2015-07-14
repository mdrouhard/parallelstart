Table data;
Axis axis;
Plot plot;

float maxValue;
float minValue;
float average;

int numRows;
int numCols;
int xDist;
int xTotalDist;
int col;

int plotMarginLeft = 20;
int plotMarginRight = 20;
int plotMarginBottom = 40;
int plotMarginTop = 40;
int axisHeight = 20;

int plotLeft, plotRight, plotWidth;
int plotTop, plotBottom, plotHeight;
int plotMiddle;
int axisTop, axisBottom;
int axisMiddle;
int parallelWidth = 10;

ArrayList<float[]> dataPoints;

PFont plotFont;

color notSelectedColor = color(255, 0, 80, 100);
color selectedColor = color(0, 0, 255, 100);

void setup() {
  size(1000, 500);
  axis = new Axis();
  plot = new Plot();
  data = loadTable("cars.csv", "header");
  
  numRows = data.getRowCount();
  numCols = data.getColumnCount();
  plot.drawPlot();

  plotFont = createFont("Verdana", 12);
  textFont(plotFont);
  

}

void draw() {
  background(240);
  axis.displayAxes();
  // What was this for?
//  rect(xDist-5,plotTop,xDist+5, plotBottom);
 }

void setupColumns() {
   // create array of Columns (data structure added)
   
   // for each column
    // calculate min, max, average and set
    // calculate xDist & set col index and XDist 
}

void calculateDataLinePoints() {
  // Create new table or 2D array (See processing reference for more info)
    
  // for each row r
    // for each column c
      // map dataValue from table to y value on axis & store it at array[r][c]
}

void drawDataLines() {
  // for each row index r
    // for each column index c (except last column)
      // x1 = c.xDist
      // y1 = array[r][c]
      // x2 = (c+1).xDist
      // y2 = array[r][c+1]
      
    // draw line (x1, y1, x2, y2)
}

void calculateDataPoints(int col) {
  dataPoints = new ArrayList<float[]>();
  for (int row = 0; row < data.getRowCount(); row++) {
    float dataValue = data.getFloat(row, col);
    // try not to rely on global variables whose values will change
    float x = xTotalDist;

    //float jitter_y = random(14);
    // try not to rely on global variables whose values will change
    float y = map(dataValue, maxValue, minValue, plotTop, plotBottom);// + jitter_y;
    dataPoints.add(new float[] {x, y});
  }
}

void drawDataPoints(int col) {
  noFill();
  //stroke(notSelectedColor);
  //strokeWeight(3);
   //fill(100);
   int endCols = 7;
    rectMode(CORNERS);
  for (int row = 0; row < dataPoints.size()-1; row++) {
  while (col <= endCols) {
    col = col + 1;
    float[] pointA = dataPoints.get(row);
    float[] pointB = dataPoints.get(row+1); //something wrong
    fill(0);
    ellipse(pointA[0], pointA[1], 3, 3);
    //println( "pointA= (" + pointA[0], pointA[1] + ") pointB = (" + pointB[0]+xDist, pointB[1] +")");
    //stroke(random(255),random(255),random(255),80);
    stroke(0,200,230,80);
    line(pointA[0], pointA[1], pointB[0]+xDist, pointB[1]);
//    beginShape(LINES);
//    vertex(pointA[0],pointA[1]);
//    vertex(pointB[0]+xDist,pointB[1]);
//    endShape();
    
  
    
    
 }
  }  
}

void findMinMax(int col) {
  float sum = 0; 
   // find the minimum and maximum data values for the selected column  
  for (int i = 0; i < data.getRowCount(); i++) {
    // get the current value
    float dataValue = data.getFloat(i, col); 
    if (Float.isNaN(dataValue)){
      continue;
    }
    if (i == 0) {
      // if the first data element, we need to set min and max to that value
      minValue = maxValue = dataValue;
    } else {
      // we need to test the data value and update the min and max values accordingly
      if (dataValue < minValue) {
        minValue = dataValue;
      }
      if (dataValue > maxValue) {
        maxValue = dataValue;
      }
    }
    sum += dataValue;
  }
  average= (sum)/(data.getRowCount());
}



