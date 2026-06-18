@tool
extends Container


@export var project: Project:
	set(p):
		project = p
		
		if project:
			_refresh.call_deferred()
			project.changed.connect(_refresh)


func _refresh() -> void:
	%Title.text = project.title
	%Description.text = project.description
	%Github.visible = not project.github_url.is_empty()
	%Itchio.visible = not project.itchio_url.is_empty()
	%Youtube.visible = not project.youtube_url.is_empty()


func _on_description_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))


func _on_github_pressed() -> void:
	if project:
		OS.shell_open(project.github_url)


func _on_itchio_pressed() -> void:
	if project:
		OS.shell_open(project.itchio_url)


func _on_youtube_pressed() -> void:
	if project:
		OS.shell_open(project.youtube_url)
