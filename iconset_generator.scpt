(* Script for creating App Icon Images:

icon_16x16.png
icon_16x16@2x.png
icon_32x32.png
icon_32x32@2x.png
icon_128x128.png
icon_128x128@2x.png
icon_256x256.png
icon_256x256@2x.png
icon_512x512.png
icon_512x512@2x.png

Author: Jan Semrau @ Tenqyu 2015
License: Feel free to use it, modify it and spread it.
Complaints: > /dev/null 2>&1
Praises: Contact
*)

on run
	
	try
		(* Let the user choose a original file to down-size and a folder where the new files are saved *)
		tell application "Finder"
			activate
			set fileOriginal to (choose file with prompt "Please choose the original image file:" without multiple selections allowed) as string
			
			set folderIconFiles to (choose folder with prompt "Please choose the folder to save the newly created icon-images into:" without multiple selections allowed) as string
		end tell
		
		tell application "Adobe Photoshop CS6"
			activate
			open file fileOriginal
		end tell
		
		(* Resize the current document and save it *)
		#set pathToDesktop to path to the desktop as text
		
		(* iPhone App - iOS 7,8 60pt*)
		(* iPhone SpotLight - iOS 5-8 29pt*)
		(* iPhone SpotLight - iOS 7,8 40pt*)
		(* iPhone App - iOS 5,6 50pt*)
		(* iPhone App - iOS 5,6 57pt*)
		
		#Needs to go from the largest to the smallest
		tell me to resizeAndSave(folderIconFiles, "iTunesArtwork", 512, "x", 512, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "iTunesArtwork", 512, "x", 512, "", 1, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-60", 60, "x", 60, "@", 3, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-76", 76, "x", 76, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-72", 72, "x", 72, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-60", 60, "x", 60, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small-40", 40, "x", 40, "@", 3, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon", 57, "x", 57, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small-50", 50, "x", 50, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small", 29, "x", 29, "@", 3, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small-40", 40, "x", 40, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-76", 76, "x", 76, "", 1, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-72", 72, "x", 72, "", 1, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small", 29, "x", 29, "@", 2, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon", 57, "x", 57, "", 1, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small-50", 50, "x", 50, "", 1, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small-40", 40, "x", 40, "", 1, ".png")
		tell me to resizeAndSave(folderIconFiles, "Icon-Small", 29, "x", 29, "", 1, ".png")
		
		(* Close the original file *)
		tell application "Adobe Photoshop CS6"
			close current document saving no
		end tell
		
	on error (e)
		log "Error: " & e
	end try
	
end run


on resizeAndSave(path, prefix, sizex, dingsda, sizey, dingsbums, factor, suffix)
	
	log "entered resizeAndSave"
	
	if (factor as integer) = 1 then
		(* Like this: icon_16x16@2x.png *)
		set newFileName to prefix & suffix
	else if (factor as integer) = 2 then
		(* Like this: icon_16x16@2x.png *)
		set newFileName to prefix & dingsbums & factor & dingsda & suffix
	else if (factor as integer) = 3 then
		(* Like this: icon_16x16@2x.png *)
		set newFileName to prefix & dingsbums & factor & dingsda & suffix
	else
		display dialog "Invalid factor." buttons {"Does not compute?"}
		return
	end if
	set filePath to path & ":" & newFileName
	
	
	tell application "Adobe Photoshop CS6"
		
		set UserPrefs to properties of settings
		set ruler units of settings to pixel units
		
		tell current document
			width as pixels
			height as pixels
			resize image width (sizex * factor) height (sizey * factor) resample method bicubic
			save in file filePath as PNG copying yes
			
		end tell
		
	end tell
	
end resizeAndSave

