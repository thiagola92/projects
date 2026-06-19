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
	%Github.url = project.github_url
	%Itchio.url = project.itchio_url
	%Youtube.url = project.youtube_url
	%Github.visible = not project.github_url.is_empty()
	%Itchio.visible = not project.itchio_url.is_empty()
	%Youtube.visible = not project.youtube_url.is_empty()


func _on_description_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
