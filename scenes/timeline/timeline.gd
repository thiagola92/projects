@tool
extends ScrollContainer


const YearButtonScene := preload("res://scenes/timeline/year_button/year_button.tscn")

const YearLinkScene := preload("res://scenes/timeline/year_link/year_link.tscn")

const SCROLL_CHECK = 10

@export var margins: int = 64:
	set(m):
		margins = m
		%MarginContainer.add_theme_constant_override("margin_left", margins)
		%MarginContainer.add_theme_constant_override("margin_right", margins)

var _ignore_next_click: bool = false


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
		var b := YearButtonScene.instantiate() as YearButton
		b.text = dirname
		b.pressed.connect(_on_year_button_pressed.bind(b))
		%Years.add_child(b)
		
		if dirname != dirs[-1]:
			var l := YearLinkScene.instantiate() as YearLink
			%Years.add_child(l)


func _on_gui_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if event is InputEventMouseMotion:
			# Disable next button click if the user is scrolling with enthusiasm.
			_ignore_next_click = _ignore_next_click or abs(event.relative.x) > SCROLL_CHECK
			
			scroll_horizontal -= event.relative.x


func _on_year_button_pressed(button: YearButton) -> void:
	# Igore this button press because the user is probably just scrolling.
	if _ignore_next_click:
		_ignore_next_click = false
		return
	
	scroll_horizontal = int(button.position.x)
