class_name ThemeButton
extends Button


const SUN := preload("res://scenes/theme_button/sun.svg")

const MOON := preload("res://scenes/theme_button/moon.svg")

@export var is_light_theme: bool = true:
	set(l):
		is_light_theme = l
		EventBus.theme_changed.emit(is_light_theme)


func _ready() -> void:
	EventBus.theme_changed.connect(_on_theme_changed)


func _on_pressed() -> void:
	is_light_theme = not is_light_theme


func _on_mouse_entered() -> void:
	%AnimationPlayer.play("GROW")


func _on_mouse_exited() -> void:
	%AnimationPlayer.play("RESET")


func _on_theme_changed(light_theme: bool) -> void:
	if light_theme:
		icon = SUN
		RenderingServer.set_default_clear_color(Color.WHITE)
		add_theme_color_override("icon_normal_color", Color.WHITE)
		add_theme_color_override("icon_focus_color", Color.WHITE)
		add_theme_color_override("icon_pressed_color", Color.WHITE)
		add_theme_color_override("icon_hover_color", Color.WHITE)
		add_theme_color_override("icon_hover_pressed_color", Color.WHITE)
		add_theme_color_override("icon_disabled_color", Color.WHITE)
	else:
		icon = MOON
		RenderingServer.set_default_clear_color(Color.html("#292929"))
		add_theme_color_override("icon_normal_color", Color.html("#292929"))
		add_theme_color_override("icon_focus_color", Color.html("#292929"))
		add_theme_color_override("icon_pressed_color", Color.html("#292929"))
		add_theme_color_override("icon_hover_color", Color.html("#292929"))
		add_theme_color_override("icon_hover_pressed_color", Color.html("#292929"))
		add_theme_color_override("icon_disabled_color", Color.html("#292929"))
