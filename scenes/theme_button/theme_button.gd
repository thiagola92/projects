extends Button


@export var light_theme: bool = true:
	set(l):
		light_theme = l
		
		if light_theme:
			RenderingServer.set_default_clear_color(Color.WHITE)
		else:
			RenderingServer.set_default_clear_color(Color.html("#292929"))


func _on_pressed() -> void:
	light_theme = not light_theme
