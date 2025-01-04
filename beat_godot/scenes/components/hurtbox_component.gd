extends Area2D
class_name Hurtbox_Component

@export var health_component : Health_Component
var floating_text_scene = preload ("res://scenes/components/floating_text.tscn")

func _ready() -> void:
    area_entered.connect(on_area_entered)

func on_area_entered(other_area : Area2D):
    if health_component == null:
        return
    if not other_area is Hitbox_Component:
        return
    var hitbox_component = other_area as Hitbox_Component
    health_component.damage(hitbox_component.damage, hitbox_component.damage_type)
    var floating_text = floating_text_scene.instantiate() as Node2D
    get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
    floating_text.global_position = global_position + (Vector2.UP * 16)
    floating_text.start(str(hitbox_component.damage))