extends Area2D

signal hit()

func _ready() -> void:
    hit.connect(_on_body_entered)

func _on_body_entered(_body : Node2D):
    hit.emit()