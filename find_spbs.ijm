fitchan=2;
refchan=1;
orig=getTitle();
Stack.setDisplayMode("composite");
run("Z Project...", "projection=[Sum Slices]");
sum=getTitle();
Stack.setChannel(fitchan);
run("Duplicate...", " ");
dup=getTitle();
run("Gaussian Blur...", "sigma=1");
run("track max not mask jru v1", "threshhold=Max min_separation=30 thresh_fraction=0.15000 edge_buffer=50 max_blobs=1000 display_frame=1 link_range=10.00000 max_link_delay=1 min_traj_length=0");
//run("track max not mask jru v1", "threshhold=Max min_separation=30 thresh_fraction=0.25000 edge_buffer=50 max_blobs=1000 display_frame=1 link_range=10.00000 max_link_delay=1 min_traj_length=0");
run("close table jru v1", "table=[Traj Data]");
selectWindow(dup);
close();
run("traj 2 roi jru v1", "image="+sum+" trajectory=Trajectories roi=Squares square=30");
selectWindow("Trajectories");
close();
selectWindow(sum);
close();
selectWindow(orig);
roiManager("Show All");
nrois=roiManager("count");
run("PlotWindow Extensions jru v1");
var pos=0;
//waitForUser("check rois");
for(i=0;i<nrois;i++){
	selectWindow(orig);
	roiManager("Select",pos);
	run("create hs profile jru v1", "profile_statistic?=Max projection_statistic?=Sum z_profile_(time_projection)?");
	Ext.selectSeries(refchan-1);
	Ext.getSelNpts(npts);
	Ext.getSelStat("Max",refmax);
	Ext.selectSeries(fitchan-1);
	Ext.getSelStat("Max",fitmax);
	Ext.getSelStat("MaxPos",fitmaxpos);
	//waitForUser("check plot");
	close();
	if(refmax<0.1*fitmax || fitmaxpos<1.0 || fitmaxpos>(npts-2.0)){
		//need to eliminate this data set
		//showMessage("deleted");
		print("deleted"+i);
		roiManager("Delete");
	} else {
		selectWindow(orig);
		roiManager("Select",pos);
		run("Duplicate...", "duplicate");
		run("autoscale hyperstack jru v1");
		pos++;
	}
}
