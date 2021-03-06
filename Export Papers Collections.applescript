tell application id "com.mekentosj.papers3"
	-- returns all (manual & smart) collections as scriptable objects
	set CollectionList to every collection item
	-- change the folder below to a folder that exists in your machine
	set FolderBase to "/Users/USERNAME/Desktop/PapersBib/"
	
	repeat with CollectionItem in CollectionList
		set CollectionName to name of CollectionItem
		
		set FileName to FolderBase & (CollectionName as string) & ".bib"
		set outFile to (FileName as POSIX file)
		set pp to publication items of CollectionItem
		export (pp as list) to outFile
		
		set SubCollections to collection items of CollectionItem
		repeat with SubCollectionItem in SubCollections
			set SubCollectionName to name of SubCollectionItem
			
			
			--set SubSubCollections to collection items of SubCollectionItem
			set outFolder to ((FolderBase & (CollectionName as string)) as POSIX file)
			my make_target_folder(outFolder)
			
			--repeat with SubSubCollectionItem in SubSubCollections
			--	set SubSubCollectionName to name of SubSubCollectionItem
			--	set FileName to FolderBase & (CollectionName as string) & "/" & (CollectionName as string) & ".bib"
			--	set outFile to (FileName as POSIX file)
			--	set pp to publication items of SubSubCollectionItem
			--	export (pp as list) to outFile
			--end repeat
			set FileName to FolderBase & "/" & (CollectionName as string) & "/" & (SubCollectionName as string) & ".bib"
			set outFile to (FileName as POSIX file)
			set pp to publication items of SubCollectionItem
			export (pp as list) to outFile
		end repeat
	end repeat
	
	
	
	-- returns list of all manual collection names
	--set m to name of every manual collection item
	
	
	-- returns list of all smart collection names
	-- set s to name of every smart collection item
	
	-- returns all publications for the first manual collection as scriptable objects
	--set pc to collection items of manual collection item 2
	--set pp to publication items of manual collection item 2
	--set px to count of collection items of manual collection item 2
end tell

on make_target_folder(folder_path)
	tell application "Finder"
		try
			set target_folder to folder_path as alias
		on error
			set folder_path to folder_path as string
			set AppleScript's text item delimiters to ":"
			set the_folders to (text items of folder_path) as list
			set AppleScript's text item delimiters to ""
			set new_folder to (item 1 of the_folders) & ":"
			repeat with i from 2 to count of the_folders
				set the_folder_name to (item i of the_folders)
				if the_folder_name is not "" then
					try
						get new_folder & (the_folder_name) & ":" as alias
					on error
						set target_folder to (make new folder at (new_folder as alias) with properties {name:the_folder_name}) as alias
					end try
					set new_folder to new_folder & (the_folder_name) & ":"
				end if
			end repeat
		end try
	end tell
	return target_folder
end make_target_folder

--this script was automatically tagged for 
--color coded syntax by Script to Markup Code 
--written by Jonathan Nathan
