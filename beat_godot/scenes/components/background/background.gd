extends ParallaxBackground
@export var speed : float = 500.0

func _ready() -> void:
    print (" Start Paralax_Background")

func _process(delta: float) -> void:
    scroll_base_offset.x -= speed * delta