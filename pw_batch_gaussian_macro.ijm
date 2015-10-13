run("PlotWindow Extensions jru v1");
var name=getTitle();
Ext.getNSeries(nser);
//print(""+nser);
for(i=0;i<nser;i++){
	selectWindow(name);
	Ext.selectSeries(i);
	run("fit gaussian jru v1");
	waitForUser("Check Fit");
	close();
}
Ext.selectSeries(-1);
