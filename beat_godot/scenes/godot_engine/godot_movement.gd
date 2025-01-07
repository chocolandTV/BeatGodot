extends Sprite2D
class_name enemy_godot_movement
var player : Player
var speed : float =  500
func _ready() -> void:
    player  = get_node("/root/GlobalData").player

func _process(delta: float) -> void:
    global_position.y = move_toward(global_position.y, player.global_position.y, speed * delta)

func increase_difficult_speed():
    speed += 5