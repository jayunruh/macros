//run("To ROI Manager");
fitch=2;
otherch=1;
roiManager("Show All");
saveAs("Tiff");
orig=getTitle();
run("Duplicate...", "title=otherchan duplicate channels="+otherch);
selectWindow(orig);
run("Duplicate...", "title=fitchan duplicate channels="+fitch);
selectWindow(orig); close();
profname=removeExtension(orig);
profname=profname+"_realigned.tif";
selectWindow("fitchan");
rename(profname);
run("fit 3D multi gaussian jru v1", "z_ratio=3.12383 xy_stdev=0.95000 z_stdev=1.20000 calibrate? show");
selectWindow(profname); rename("fitchan");
run("thick 3D polyline profile jru v1", "3d=[MultiGaus Plot] z=[fitchan] thickness=15 z_ratio=3.12383 end=1.5 straighten single");
rename("C"+fitch+"_realigned");
run("thick 3D polyline profile jru v1", "3d=[MultiGaus Plot] z=[otherchan] thickness=15 z_ratio=3.12383 end=1.5 straighten single");
rename("C"+otherch+"_realigned");
run("Merge Channels...", "c1=[C1_realigned] c2=[C2_realigned] create");
wait(200);
selectWindow("Composite");
rename(profname);
saveAs("Tiff");
roiManager("reset");
selectWindow("otherchan"); close();
selectWindow("fitchan"); close();
selectWindow("MultiGaus Plot"); close();
selectWindow("Avg Projections"); close();
selectWindow("Z Profiles"); close();
selectWindow("fit");
run("autoscale hyperstack jru v1");

function removeExtension(fname){
	var dotpos=lastIndexOf(fname,".");
	if(dotpos<0) return fname;
	else return substring(fname,0,dotpos);
}
