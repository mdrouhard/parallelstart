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
  rect(xDist-5,plotTop,xDist+5, plotBottom);
 }



void calculateDataPoints(int col) {
  dataPoints = new ArrayList<float[]>();
  for (int row = 0; row < data.getRowCount(); row++) {
    float dataValue = data.getFloat(row, col);
    float x = xTotalDist;

    //float jitter_y = random(14);
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
//draw axes and labels 
class Axis {

  void displayAxes() {
    smooth();
  for( int col = 0; col < numCols; col++) {
    xTotalDist= xDist + col*xDist;
    //line(xTotalDist, plotTop, xTotalDist, plotBottom);
    fill(0);
    stroke(0);
    textAlign(CENTER, BOTTOM);
    text(data.getColumnTitle(col), xTotalDist, axisMiddle);
    
    findMinMax(col);
    textAlign(CENTER, TOP);
    text(minValue, xTotalDist, plotBottom);
    textAlign(CENTER, BOTTOM);
    text(maxValue,xTotalDist, plotTop);
    
    //rectangles around axes
    rectMode(CENTER);
    noFill();
    stroke(0,150);
    rect(xTotalDist, plotMiddle, parallelWidth, plotHeight);

    calculateDataPoints(col);
    drawDataPoints(col);
    noFill();
    }
  } 
}
// initialize plot variables
class Plot {
  
  void drawPlot() {
    plotLeft = plotMarginLeft;
    plotRight = width - plotMarginRight;
    plotWidth = plotRight - plotLeft;
    plotTop = plotMarginTop;
    plotBottom = height - plotMarginBottom - axisHeight;
    plotHeight = plotBottom - plotTop;
    plotMiddle = plotTop + (plotHeight/ 2);
    
    xDist = width / (numCols+1);
    
    axisTop = plotLeft;
    axisBottom = axisTop - axisHeight;
    axisHeight = axisBottom - axisTop;
    axisMiddle = height + (axisHeight/ 2);
  }
}

