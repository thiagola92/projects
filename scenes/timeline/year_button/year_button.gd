class_name YearButton
extends Button


func _ready() -> void:
	EventBus.theme_changed.connect(_on_theme_changed)


func _on_theme_changed(light_theme: bool) -> void:
	if light_theme:
		add_theme_color_override("font_color", Color.WHITE)
		add_theme_color_override("font_focus_color", Color.WHITE)
		add_theme_color_override("font_pressed_color", Color.WHITE)
		add_theme_color_override("font_hover_color", Color.WHITE)
		add_theme_color_override("font_disabled_color", Color.WHITE)
		add_theme_color_override("font_outline_color", Color.WHITE)
	else:
		add_theme_color_override("font_color", Color.html("#292929"))
		add_theme_color_override("font_focus_color", Color.html("#292929"))
		add_theme_color_override("font_pressed_color", Color.html("#292929"))
		add_theme_color_override("font_hover_color", Color.html("#292929"))
		add_theme_color_override("font_disabled_color", Color.html("#292929"))
		add_theme_color_override("font_outline_color", Color.html("#292929"))
