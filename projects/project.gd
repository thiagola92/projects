@tool
class_name Project
extends Resource


@export var title: String:
	set(t):
		title = t
		changed.emit()

@export_multiline var description: String:
	set(d):
		description = d
		changed.emit()

@export var github_url: String:
	set(u):
		github_url = u
		changed.emit()

@export var itchio_url: String:
	set(u):
		itchio_url = u
		changed.emit()

@export var pypi_url: String:
	set(u):
		pypi_url = u
		changed.emit()

@export var youtube_url: String:
	set(u):
		youtube_url = u
		changed.emit()
