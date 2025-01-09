extends ParallaxLayer
@export var speed : float = 500.0


func _process(delta: float) -> void:
    motion_offset.x -= speed * delta