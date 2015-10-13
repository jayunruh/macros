run("PlotWindow Extensions jru v1");
run("function generator jru v1", "extra=[] equation=Math.exp(-x) noise=None gaussian=1.00000 x_min=0.00000 x_max=10.00000 delta=0.50000");
name=getTitle();
Ext.getNSeries(nser);
IJ.log("n ser = "+nser);
Ext.selectSeries(0);
makePoint(150,150);
getSelectionBounds(x1,y1,width,height);
Ext.scalePlotCoords(x1,y1,x,y);
print("x coordinate = "+x+" , y coordinate = "+y);
Ext.setLimits(0.1,11,0.1,1.1);
//waitForUser("Check Scales");
Ext.setLogAxes(0,1);
Ext.setXLabel("Distance");
Ext.setYLabel("Intensity");
Ext.setGridWhiteness(240);
Ext.autoscaleX();
Ext.autoscaleY();
Ext.setMagnification(1.1);
Ext.setMagRatio(1.0);
Ext.getSelNpts(selnpts)
yvals=newArray(selnpts);
xvals=newArray(selnpts);
for(i=0;i<selnpts;i++){
	Ext.getSelIndexXYVals(i,xvals[i],yvals[i]);
	print(""+xvals[i]+" , "+yvals[i]);
	yvals[i]=yvals[i]*0.5;
}
//Ext.addXYSeries(xvals,yvals);
Ext.addXYSeries(newArray(0),yvals);
Ext.updateSelSeries(xvals,yvals);
Ext.selectSeries(1);
Ext.deleteSelected();
close();
Ext.createPlot("x","y",xvals,yvals);
Ext.convertToPW();
