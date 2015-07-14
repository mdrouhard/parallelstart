//draw axes and labels 
public class Axis {

  void displayAxes() {
    smooth();
  for( int col = 0; col < numCols; col++) {
    xTotalDist= xDist + col*xDist;
    //line(xTotalDist, plotTop, xTotalDist, plotBottom);
    fill(0);
    stroke(0);
    textAlign(CENTER, BOTTOM);
    text(data.getColumnTitle(col), xTotalDist, axisMiddle);
    
    // better not to recalculate this on each draw loop
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

//    calculateDataPoints(col);
//    drawDataPoints(col);
    noFill();
    }
  }
 

}
