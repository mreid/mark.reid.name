import controlP5.*;
import geomerative.*;
import name.reid.mark.geovex.*;

/**
 * <p>
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 * </p><p>
 * The left graph shows curves on a cost-loss plot.
 * </p><p>
 * The right graph shows the same curves converted to an ROC representation
 * with prior probability for the positive class controlled by ¹.
 * </p><p>
 * Move your mouse over the cost space window to see the corresponding line in the
 * ROC graph and <i>vice versa</i>. 
 * </p><p>
 * The prior ¹ can be modified using the slider underneath the graphs. 
 * </p><p>
 * The duality relationships are computed using the 
 * <a href="http://github.com/mreid/geovex">geovex</a> Java library while the visualisation
 * is done with the standard Processing library and the 
 * <a href="http://www.ricardmarxer.com/processing/geomerative/documentation/">geomerative</a> 
 * library.
 * </p>
 */
PlotView rocView = new PlotView(0.0, 0.0, 1.0, 1.0);
PlotView siView  = new PlotView(0.0, 0.0, 1.0, 0.5);

SIROCConverter sirocConvert = new SIROCConverter();
ROCSIConverter rocsiConvert = new ROCSIConverter();

SpecPoint siCursor = new SpecPoint(0.0, 0.0);
SpecPoint rocCursor = new SpecPoint(0.0, 0.0);
GLine rocDualCursor = new DualLine(siCursor, sirocConvert);
GLine siDualCursor = new DualLine(rocCursor, rocsiConvert); 

PFont titleFont = createFont("Arial", 16);
PFont tickFont  = createFont("Arial", 12);

color grey = color(160,160,160);
color black = color(0,0,0);

float prior = 0.5;

SpecCurve roc;
GCurve si;

void setup(){
  size(700,400,JAVA2D);
  frameRate(20);
  background(255);

  siView.setView(30, 30, 300, 300);
  siView.setTitle("Cost Space");
  siView.xAxisTitle = "Cost";
  siView.yAxisTitle = "Loss";
  siView.setCurveStart(1,0);
  siView.setCurveEnd(0,0);
  
  rocView.setView(360, 30, 300, 300);
  rocView.setTitle("ROC Space");
  rocView.xAxisTitle = "False Pos. Rate";
  rocView.yAxisTitle = "True Pos. Rate";

  SpecCurve rocDiag = new SpecCurve();
  rocDiag.add(0, 0);
  rocDiag.add(1, 1);

  rocView.add(rocDiag, grey);

  GCurve siTent = new DualCurve(rocDiag, rocsiConvert);
  siView.add(siTent, grey);

  roc = new SpecCurve();
  roc.add(0.0, 0.0);
  roc.add(0.1, 0.5);
  roc.add(0.3, 0.8);
  roc.add(0.7, 0.95);
  roc.add(1.0, 1.0);

  si = new DualCurve(roc, rocsiConvert);

  siView.add(si, black);
  rocView.add(roc, black);  

  // Controls for prior value
  ControlP5 priorControl = new ControlP5(this);
  Slider s = priorControl.addSlider("priorSlider", 0.0, 1.0, 0.5, 250, 350, 200, 20);
  
  smooth();
}

void priorSlider(float value) {
  prior = value;
  sirocConvert.setPrior(prior);
  rocsiConvert.setPrior(prior);
}

void draw(){
  // Clear the screen
  background(255);
  
  siView.draw(g);
  rocView.draw(g);

  textAlign(CENTER, BOTTOM);
  textFont(tickFont);
  text("Prior Probability of Positive Class", 350, 345);

  if(siView.active()) {
    siCursor.setX(siView.viewToModelX(mouseX));
    siCursor.setY(siView.viewToModelY(mouseY));
    
    stroke(200,0,0);
    siView.drawPoint(siCursor);
    rocView.drawLine(rocDualCursor);
  }
  
  if(rocView.active()) {
    rocCursor.setX(rocView.viewToModelX(mouseX));
    rocCursor.setY(rocView.viewToModelY(mouseY)); 

    stroke(0,0,200);    
    rocView.drawPoint(rocCursor);
    siView.drawLine(siDualCursor);
  }
}
