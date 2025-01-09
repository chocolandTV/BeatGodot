extends Node
class_name Audio_Manager

signal play_hit_sound()
signal play_random_sound()
signal play_godot_damaged()

func play_hit():
    play_hit_sound.emit()

func play_random():
    play_random_sound.emit()

func play_godot_damage():
    play_godot_damaged.emit()
