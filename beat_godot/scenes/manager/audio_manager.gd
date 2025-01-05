extends Node
class_name Audio_Manager

signal play_hit_sound()
signal play_random_sound()

func play_hit():
    play_hit_sound.emit()

func play_random():
    play_random_sound.emit()


func _ready() -> void:
     get_node("/root/GlobalData").SET_AUDIO_MANAGER(self)