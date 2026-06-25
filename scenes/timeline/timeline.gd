@tool
extends ScrollContainer


signal dir_selected(directory: String)

const PROJECTS_DIR := "res://projects"

const YearButtonScene := preload("res://scenes/timeline/year_button/year_button.tscn")

const YearLinkScene := preload("res://scenes/timeline/year_link/year_link.tscn")

const SCROLL_CHECK = 10

@export var margins: int = 64:
	set(m):
		margins = m
		%MarginContainer.add_theme_constant_override("margin_left", margins)
		%MarginContainer.add_theme_constant_override("margin_right", margins)

var _is_dragging: bool = false

var _scroll_target: int = 0


func _ready() -> void:
	_clear()
	_fill()


func _process(_delta: float) -> void:
	_move_to_target()


func _clear() -> void:
	for c in %Years.get_children():
		c.queue_free()


func _fill() -> void:
	var dir := DirAccess.open(PROJECTS_DIR)
	
	assert(dir != null)
	
	var dirs := dir.get_directories()
	
	dirs.reverse()
	
	for dirname in dirs:
		var d := PROJECTS_DIR.path_join(dirname)
		var b := YearButtonScene.instantiate() as YearButton
		b.text = dirname
		b.pressed.connect(_on_year_button_pressed.bind(b, d))
		%Years.add_child(b)
		
		if dirname != dirs[-1]:
			var l := YearLinkScene.instantiate() as YearLink
			%Years.add_child(l)


func _move_to_target() -> void:
	if scroll_horizontal == _scroll_target:
		return
	
	if abs(scroll_horizontal - _scroll_target) < 2:
		scroll_horizontal = _scroll_target
		return
	
	scroll_horizontal = int(lerp(scroll_horizontal, _scroll_target, 0.1))
	

func _on_gui_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if event is InputEventMouseMotion:
			_is_dragging = _is_dragging or abs(event.relative.x) > SCROLL_CHECK
			scroll_horizontal -= event.relative.x
			_scroll_target = scroll_horizontal
	else:
		_is_dragging = false


func _on_year_button_pressed(button: YearButton, directory: String) -> void:
	# Ignore this button press because it's just the user dragging.
	if _is_dragging:
		_is_dragging = false
		return
	
	_scroll_target = int(button.position.x)
	
	dir_selected.emit(directory)
