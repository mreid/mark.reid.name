import java.util.Vector;

class CurveView {
  GCurve curve;
  color  col;  
  CurveView(GCurve curve, color col) { this.curve = curve; this.col = col; }
}

class LineView {
  GLine line;
  color  col;  
  LineView(GLine line, color col) { this.line = line; this.col = col; }
}

class PointView {
  GPoint point;
  color  col;  
  PointView(GPoint point, color col) { this.point = point; this.col = col; }
}

class PlotView {

  Vector curves = new Vector();
  Vector points = new Vector();  
  Vector lines  = new Vector();
  
  String title = "[Plot Title]";
  String xAxisTitle = "[X Axis]"; String yAxisTitle = "[Y Axis]";
  int vxStart, vyStart;
  int vxEnd, vyEnd;
  float xStart, xEnd;
  float yStart, yEnd;
  float curvex0, curvex1, curvey0, curvey1;
  
  GBounds bounds;
  
  PlotView(
    int vx0, int vy0, int vWidth, int vHeight,
    float x0, float y0, float x1, float y1
  ) {
    vxStart = vx0; vyStart = vy0; vxEnd = vx0 + vWidth; vyEnd = vy0 + vHeight;
    xStart = x0; yStart = y0; xEnd = x1; yEnd = y1;
    curvex0 = xStart; curvey0 = yStart; curvex1 = xEnd; curvey1 = yEnd;
    bounds = new GBounds(xStart, yStart, xEnd, yEnd);
  }

  PlotView(float x0, float y0, float x1, float y1) { this(0, 0, 100, 100, x0, y0, x1, y1); }
  PlotView() { this(0.0, 0.0, 1.0, 1.0); }
  
  void add(GCurve curve, color col) { curves.add(new CurveView(curve, col)); }
  void add(GPoint point, color col) { points.add(new PointView(point, col)); }
  void add(GLine line, color col) { lines.add(new LineView(line, col)); }
  
  void setCurveStart(float x, float y) { this.curvex0 = x; this.curvey0 = y; }
  void setCurveEnd(float x, float y) { this.curvex1 = x; this.curvey1 = y; }
  void setTitle(String title) { this.title = title; }
  void setViewStart(int vx, int vy) { vxStart = vx; vyStart = vy; }
  void setViewEnd(int vx, int vy) { vxEnd = vx; vyEnd = vy; }
  void setView(int vx0, int vy0, int vWidth, int vHeight) { 
    setViewStart(vx0, vy0); 
    setViewEnd(vx0 + vWidth, vHeight); 
  }
  
  int viewWidth() { return vxEnd - vxStart; }
  int viewHeight() { return vyEnd - vyStart; }
  
  float xRange() { return xEnd - xStart; }
  float yRange() { return yEnd - yStart; }
  
  float xResolution() { return xRange() / viewWidth(); }
  float yResolution() { return yRange() / viewHeight(); }
  
  float viewToModelX(float vx) { return xStart + xRange() * (vx - vxStart) / viewWidth(); }
  float viewToModelY(float vy) { return yStart - yRange() * (vy - vyEnd) / viewHeight(); }
  
   boolean active() {
     return (mouseX > vxStart && mouseX < vxEnd && mouseY > vyStart && mouseY < vyEnd);
   }
    
   void preDraw() {
     pushMatrix();
     
     // Set up viewing transformations
     translate(vxStart, vyStart);
     translate(-xStart, -yStart);
     scale(viewWidth()/xRange(),-viewHeight()/yRange());
     translate(0,-yEnd);
     strokeWeight(min(xResolution(), yResolution()));     
   }
   
   void postDraw() {
     popMatrix(); 
   }
  
   void drawTitle() {
     fill(0);
     textFont(titleFont);
     
     textAlign(CENTER, BOTTOM);
     text(title, vxStart + viewWidth()/2, vyStart - 1);
   }
  
   void drawBounds() {
     noFill();
     stroke(grey);
     rect(vxStart,vyStart,viewWidth(),viewHeight());

     fill(0);
     textFont(tickFont);

     // x axis
     textAlign(LEFT, TOP);
     text(nf(xStart, 1, 1), vxStart, vyEnd + 1);

     textAlign(RIGHT, TOP);
     text(nf(xEnd, 1, 1), vxEnd, vyEnd + 1);

     textAlign(CENTER, TOP);
     text(xAxisTitle, vxStart + viewWidth()/2, vyEnd + 3);

     // y axis     
     textAlign(RIGHT, BOTTOM);
     text(nf(yStart, 1, 1), vxStart - 1, vyEnd);     

     textAlign(RIGHT, TOP);
     text(nf(yEnd, 1, 1), vxStart - 1, vyStart);     
     
     textAlign(CENTER, BOTTOM);
     pushMatrix();
     translate(vxStart - 3, vyStart + viewHeight()/2);
     rotate(-PI/2.0);
     text(yAxisTitle, 0, 0);
     popMatrix();
     
   }
  
   void draw(PGraphics g) {
     drawTitle();
     drawBounds();
     
     preDraw();
     // Curves
     for(int i = 0 ; i < curves.size() ; i++) {
       CurveView v = (CurveView) curves.get(i);
       stroke(v.col);
       viewCurve(v.curve);
     }

     // Points
     for(int i = 0 ; i < points.size() ; i++) {
       PointView v = (PointView) points.get(i);
       stroke(v.col);
       viewPoint(v.point);
     }

     // Lines
     for(int i = 0 ; i < lines.size() ; i++) {
       LineView v = (LineView) lines.get(i);
       stroke(v.col);
       viewLine(v.line);
     }     
     postDraw();
   }
   
   void drawPoint(GPoint p) {
     preDraw();
     viewPoint(p);
     postDraw();     
   }
   
   void drawLine(GLine l) {
     preDraw();
     viewLine(l);
     postDraw(); 
   }
   
   void viewCurve(GCurve curve) {
     RContour c = new RContour();
     c.addPoint(curvex0, curvey0);
     for(int i = 0 ; i < curve.size() ; i++) {
       GPoint p = curve.getPoint(i);
       if(! p.isPAI()) {
         c.addPoint(p.getX(), p.getY()); 
       }
     }
     c.addPoint(curvex1, curvey1);     
     c.draw(g);
   }
   
   void viewPoint(GPoint point) {
     float x = point.getX();
     float y = point.getY();
     
     float xRes = 2*xResolution();
     float yRes = 2*yResolution();
     
     line(x - xRes, y - yRes, x + xRes, y + yRes);
     line(x + yRes, y - yRes, x - xRes, y + yRes);
   }
   
   void viewLine(GLine line) {
     GSegment s = bounds.clip(line);
     RContour l = new RContour();
     l.addPoint(s.getStart().getX(), s.getStart().getY());
     l.addPoint(s.getEnd().getX(), s.getEnd().getY());
     l.draw(g);
   }
}
