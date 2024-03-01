//this is a macro to correct lensing effects on IFA images before continuing microcyte analysis
//make sure to have run ReName before attempting to use this macro
//arguments: directory to process, eg image_1
//inputs: edu.orig.tif
//output: edu.tif (overwrites) 
//output: edu_corrected.png (byproduct of format conversion)
//j: the number of image folders per condition 

//Changelog:
//SP 2023.11.29 - wrote macro with assistance of C. Hendrickson
//SP 2023.12.13 - updated annotations for clarity

//directory of condition folders
ex_dir = "Z:/Lab Members/Sarah Perritt/Data/SPp35 MAPKi PIT assay/replicates/MicroCyte/files"
//checking that a directory was provided
if( getArgument() != "") {
	ex_dir = getArgument();
}

//close all open windows on imageJ (prevents correction of a random file)
close("*");
//generates a list of the condition files
condition_dirs = getFileList(ex_dir);
for(i = 0; i < condition_dirs.length; i++) { 
		for(j = 1;j<=5;j++) {
			//generates a list of the image files within the 'condition' directory
			image_dir = ex_dir+"/"+condition_dirs[i]+"image_"+j;
			print("processing "+image_dir);
			//making variables for each of the file versions
			fname_orig = image_dir + "/edu.orig.tif";
			fname_out = image_dir+"/edu.tif";
			fname_corrected = image_dir+"/edu_corrected.png";
			//renaming the original file - this is the new file which will be corrected
			//this is done so that the output file can be saved in a microcyte-friendly format without replacing the original
			if (!File.exists(fname_orig)) {
				print("Backing up original edu.tif file");
				open(fname_out);
				saveAs("Tiff", fname_orig);
				close("*");
			}
			//open the input file
			open(fname_orig);
			//convert to CIELAB stack format because BaSiC must have stack as input - no RGB
			run("RGB to CIELAB");
			//run BaSiC to correct lensing
			run("BaSiC ", "processing_stack=[edu.orig.tif Lab] flat-field=None dark-field=None shading_estimation=[Estimate shading profiles] shading_model=[Estimate flat-field only (ignore dark-field)] setting_regularisationparametes=Automatic temporal_drift=Ignore correction_options=[Compute shading and correct images] lambda_flat=0.50 lambda_dark=0.50");
			//jump through hoops due to file saving silliness
			//if we save directly to TIF, the file gets bleached
			//saving to png and re-opening, then saving as tif fixes this
			//don't know why, but it works
			selectImage("Corrected:edu.orig.tif Lab");
			saveAs("PNG", fname_corrected);
			open(fname_corrected);
			saveAs("Tiff", fname_out);
			//close out all image windows and delete the temporary png file
			close("*");
			File.delete(fname_corrected);
			print("Done with image_dir="+image_dir);
		} // 1-8 images in cond dir
		print("Done with condition_dir="+condition_dirs[i]);
	} // for each cond dir
print("Done");
