extends VBoxContainer


func _on_profile_pressed() -> void:
	OS.shell_open("https://thiagola92.github.io/")


func _on_timeline_item_rect_changed() -> void:
	%Timeline.margins = %Profile.position.x + 32


func _on_timeline_dir_selected(directory: String) -> void:
	var dir := DirAccess.open(directory)
	
	assert(dir != null)
	
	var files := dir.get_files()
	
	for filename in files:
		var filepath := directory.path_join(filename)
		var project := load(filepath) as Project
		
		$ProjectDescription.project = project
