extends Node2D

var player : Player
var speed : float =  500
func _ready() -> void:
    player  = get_node("/root/GlobalData").player
    print("" , player)

func _process(delta: float) -> void:
    global_position.y = move_toward(global_position.y, player.global_position.y, speed * delta)