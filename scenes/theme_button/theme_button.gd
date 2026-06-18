extends Button


const SUN := preload("res://scenes/theme_button/sun.svg")

const MOON := preload("res://scenes/theme_button/moon.svg")


@export var light_theme: bool = true:
	set(l):
		light_theme = l
		
		if light_theme:
			RenderingServer.set_default_clear_color(Color.WHITE)
			icon = SUN
		else:
			RenderingServer.set_default_clear_color(Color.html("#292929"))
			icon = MOON


func _on_pressed() -> void:
	light_theme = not light_theme


func _on_mouse_entered() -> void:
	%AnimationPlayer.play("GROW")


func _on_mouse_exited() -> void:
	%AnimationPlayer.play("RESET")
