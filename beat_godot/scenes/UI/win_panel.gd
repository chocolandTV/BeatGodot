extends CanvasLayer

func _ready() -> void:
    offset = get_node("/root/GlobalData").player.global_position
