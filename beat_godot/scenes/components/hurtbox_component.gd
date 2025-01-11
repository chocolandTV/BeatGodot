extends Area2D
class_name Hurtbox_Component

@export var health_component : Health_Component

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(_other_area : Area2D):
	if health_component == null:
		return
	health_component.damage(1)

