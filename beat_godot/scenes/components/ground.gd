extends Area2D

signal hit()

func _on_body_entered(_area):
    hit.emit()
