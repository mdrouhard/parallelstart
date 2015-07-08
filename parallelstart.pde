Table data;
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

ArrayList<float[]> dataPoints;

PFont plotFont;

color notSelectedColor = color(255, 0, 80, 100);
color selectedColor = color(0, 0, 255, 100);

void setup() {
  size(1000, 500);
  data = loadTable("cars.csv", "header");
  numRows = data.getRowCount();
  numCols = data.getColumnCount();
  xDist = width/ (numCols+1);
  
  plotLeft = plotMarginLeft;
  plotRight = width - plotMarginRight;
  plotWidth = plotRight - plotLeft;
  plotTop = plotMarginTop;
  plotBottom = height - plotMarginBottom - axisHeight;
  plotHeight = plotBottom - plotTop;
  plotMiddle = plotTop + (plotWidth/ 2);
  
  axisTop = plotLeft;
  axisBottom = axisTop - axisHeight;
  axisHeight = axisBottom - axisTop;
  axisMiddle = height + (axisHeight/ 2);
  
  plotFont = createFont("Verdana", 12);
  textFont(plotFont);

}

void draw() {
background(240);
drawAxis();
}

void drawAxis() {
  for( int col = 0; col < numCols; col++) {
    xTotalDist= xDist + col*xDist;
    line(xTotalDist, plotTop, xTotalDist, plotBottom);
    fill(0);
    stroke(0);
    textAlign(CENTER, BOTTOM);
    text(data.getColumnTitle(col), xTotalDist, axisMiddle);
    
    findMinMax(col);
    textAlign(CENTER, TOP);
    text(maxValue, xTotalDist, plotBottom);
    textAlign(CENTER, BOTTOM);
    text(minValue,xTotalDist, plotTop);
    
    calculateDataPoints(col);
    drawDataPoints(col);
  }
  
}

void calculateDataPoints(int col) {
  dataPoints = new ArrayList<float[]>();
  for (int row = 0; row < data.getRowCount(); row++) {
    float dataValue = data.getFloat(row, col);
    float x = xTotalDist;

    //float jitter_y = random(14);
    float y = map(dataValue, minValue, maxValue, plotTop, plotBottom);// + jitter_y;
    dataPoints.add(new float[] {x, y});
  }
}

void drawDataPoints(int col) {
  noFill();
  //stroke(notSelectedColor);
  //strokeWeight(3);
  for (int row = 0; row < dataPoints.size()-1; row++) {
    float[] pointA = dataPoints.get(row);
    float[] pointB = dataPoints.get(row+1);
    ellipse(pointA[0], pointA[1], 6, 6);
    println( "pointA= (" + pointA[0], pointA[1] + ") pointB = (" + pointB[0], pointB[1] +")");
    line(pointA[0], pointA[1], pointB[0]+xDist, pointB[1]);

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


