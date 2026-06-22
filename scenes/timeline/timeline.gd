@tool
extends ScrollContainer


const YearButton := preload("res://scenes/timeline/year_button/year_button.tscn")

const YearLink := preload("res://scenes/timeline/year_link/year_link.tscn")

@export var margins: int = 64:
	set(m):
		margins = m
		%MarginContainer.add_theme_constant_override("margin_left", margins)
		%MarginContainer.add_theme_constant_override("margin_right", margins)


func _ready() -> void:
	_clear()
	_fill()


func _clear() -> void:
	for c in %Years.get_children():
		c.queue_free()


func _fill() -> void:
	var dir := DirAccess.open("res://projects")
	
	assert(dir != null)
	
	var dirs := dir.get_directories()
	
	dirs.reverse()
	
	for dirname in dirs:
		var b := YearButton.instantiate()
		b.text = dirname
		%Years.add_child(b)
		
		if dirname != dirs[-1]:
			var l := YearLink.instantiate()
			%Years.add_child(l)


func _on_gui_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if event is InputEventMouseMotion:
			scroll_horizontal -= event.relative.x
