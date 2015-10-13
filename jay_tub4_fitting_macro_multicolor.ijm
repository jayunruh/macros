tub4ch=2;
otherch=1;
run("To ROI Manager");
roiManager("show all");
//saveAs("Tiff");
orig=getTitle();
tub4title=removeExtension(orig);
tub4title=tub4title+"_tub4";
run("Duplicate...", "title="+tub4title+" duplicate channels="+tub4ch);
run("fit custom tub4 jru v1", "z_ratio=3.12383 x_stdev=0.95000 z_stdev=1.20000 calibrate?");
selectWindow(tub4title);
rename("tub4");
selectWindow(tub4title+"_realigned.tif");
rename("tub4_realigned.tif");
roiManager("reset");
selectWindow(orig);
run("Duplicate...", "title=otherchan duplicate channels="+otherch);
run("thick 3D polyline profile jru v1", "3d=[MultiGaus Plot] z=[otherchan] thickness=15 z_ratio=3.12383 end=0.0 straighten single ignore");
run("Merge Channels...", "c1=[Thick 3D Straightened] c2=tub4_realigned.tif create");
selectWindow("Composite");
rename(removeExtension(orig)+"_realigned.tif");
saveAs("Tiff");
//close(); //optional
selectWindow("Profile 1"); close();
selectWindow("Profile 2"); close();
selectWindow("tub4"); close();
selectWindow("otherchan"); close();
selectWindow("MultiGaus Plot"); close();
selectWindow(orig); close(); //optional
//selectWindow("fit"); close(); //optional
//selectWindow("XZ Profile"); close(); //optional

function removeExtension(fname){
	var dotpos=lastIndexOf(fname,".");
	if(dotpos<0) return fname;
	else return substring(fname,0,dotpos);
}
