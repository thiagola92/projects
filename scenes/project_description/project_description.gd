@tool
extends Container


const DESCRIPTION_MIN_X: int = 600

@export var project: Project:
	set(p):
		project = p
		
		if project:
			_refresh.call_deferred()
			project.changed.connect(_refresh)


func _ready() -> void:
	get_window().size_changed.connect(_on_window_size_changed)


func _refresh() -> void:
	%Title.text = project.title
	%Description.text = project.description
	%Github.url = project.github_url
	%Itchio.url = project.itchio_url
	%Youtube.url = project.youtube_url
	%Pypi.url = project.pypi_url
	%Github.visible = not project.github_url.is_empty()
	%Itchio.visible = not project.itchio_url.is_empty()
	%Youtube.visible = not project.youtube_url.is_empty()
	%Pypi.visible = not project.pypi_url.is_empty()


func _on_description_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))


func _on_window_size_changed() -> void:
	%Description.custom_minimum_size.x = min(get_window().size.x - 64, DESCRIPTION_MIN_X)
