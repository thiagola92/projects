extends VBoxContainer


var projects: Array[Project] = []

var current_project: int = 0


func _ready() -> void:
	EventBus.theme_changed.connect(_on_theme_changed)
	%Timeline.press_first()


func _adjust_selection() -> void:
	if current_project == 0:
		%Previous.modulate.a = 0
	else:
		%Previous.modulate.a = 1
	
	if current_project == projects.size() - 1:
		%Next.modulate.a = 0
	else:
		%Next.modulate.a = 1
	
	%ProjectDescription.project = projects[current_project]


func _on_profile_pressed() -> void:
	OS.shell_open("https://thiagola92.github.io/")


func _on_timeline_item_rect_changed() -> void:
	%Timeline.margins = %Profile.position.x + 32


func _on_timeline_dir_selected(directory: String) -> void:
	current_project = 0
	projects.clear()
	
	var dir := DirAccess.open(directory)
	
	assert(dir != null)
	
	var files := dir.get_files()
	
	for filename in files:
		# Exporting to web add ".remap" to files.
		filename = filename.trim_suffix(".remap")
		
		var filepath := directory.path_join(filename)
		var project := load(filepath) as Project
		
		projects.append(project)
	
	_adjust_selection()


func _on_theme_changed(light_theme: bool) -> void:
	if light_theme:
		%Previous.add_theme_color_override("icon_normal_color", Color.WHITE)
		%Previous.add_theme_color_override("icon_focus_color", Color.WHITE)
		%Previous.add_theme_color_override("icon_pressed_color", Color.WHITE)
		%Previous.add_theme_color_override("icon_hover_color", Color.WHITE)
		%Previous.add_theme_color_override("icon_hover_pressed_color", Color.WHITE)
		%Previous.add_theme_color_override("icon_disabled_color", Color.WHITE)
		%Next.add_theme_color_override("icon_normal_color", Color.WHITE)
		%Next.add_theme_color_override("icon_focus_color", Color.WHITE)
		%Next.add_theme_color_override("icon_pressed_color", Color.WHITE)
		%Next.add_theme_color_override("icon_hover_color", Color.WHITE)
		%Next.add_theme_color_override("icon_hover_pressed_color", Color.WHITE)
		%Next.add_theme_color_override("icon_disabled_color", Color.WHITE)
	else:
		%Previous.add_theme_color_override("icon_normal_color", Color.html("#292929"))
		%Previous.add_theme_color_override("icon_focus_color", Color.html("#292929"))
		%Previous.add_theme_color_override("icon_pressed_color", Color.html("#292929"))
		%Previous.add_theme_color_override("icon_hover_color", Color.html("#292929"))
		%Previous.add_theme_color_override("icon_hover_pressed_color", Color.html("#292929"))
		%Previous.add_theme_color_override("icon_disabled_color", Color.html("#292929"))
		%Next.add_theme_color_override("icon_normal_color", Color.html("#292929"))
		%Next.add_theme_color_override("icon_focus_color", Color.html("#292929"))
		%Next.add_theme_color_override("icon_pressed_color", Color.html("#292929"))
		%Next.add_theme_color_override("icon_hover_color", Color.html("#292929"))
		%Next.add_theme_color_override("icon_hover_pressed_color", Color.html("#292929"))
		%Next.add_theme_color_override("icon_disabled_color", Color.html("#292929"))


func _on_previous_pressed() -> void:
	if current_project <= 0:
		return
	
	current_project -= 1
	
	_adjust_selection()


func _on_next_pressed() -> void:
	if current_project >= projects.size() - 1:
		return
	
	current_project += 1
	
	_adjust_selection()
