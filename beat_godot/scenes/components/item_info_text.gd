extends CanvasLayer
@export var info_text : String = ""

func _ready() -> void:
    $Label.text =  info_text