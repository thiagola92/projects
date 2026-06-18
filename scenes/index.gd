extends VBoxContainer


func _on_profile_pressed() -> void:
	OS.shell_open("https://thiagola92.github.io/")


func _on_timeline_item_rect_changed() -> void:
	%Timeline.margins = %Profile.position.x + 32
