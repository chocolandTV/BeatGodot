extends Camera2D
@export var smoothLerp =20.0
@export var target = CharacterBody2D

func _ready():
      # set to default
      make_current()

func _process(delta):
      global_position = global_position.lerp(target.global_position, 1.0 -exp(-delta * smoothLerp))
