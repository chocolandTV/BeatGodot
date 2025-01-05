extends CanvasLayer

func _ready() -> void:
    offset = get_node("/root/GlobalData").player.global_position
    offset.x = get_node("/root/GlobalData").player.global_position.x * 2