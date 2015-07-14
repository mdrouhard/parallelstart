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
