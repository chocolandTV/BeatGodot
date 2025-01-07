extends AudioStreamPlayer
class_name Audio_Executer


@onready var _raven_hit_sound_player : AudioStreamPlayer  =$Raven_Hit_Sound
@onready var _raven_random_player : AudioStreamPlayer  =$Raven_Random_Sound
@onready var _godot_damaged_sound : AudioStreamPlayer = $Godot_damage

func _ready() -> void:
    get_node("/root/GlobalData").audio_manager.play_hit_sound.connect(_play_hit_sound)
    get_node("/root/GlobalData").audio_manager.play_random_sound.connect(_play_random_sound)
    get_node("/root/GlobalData").audio_manager.play_godot_damaged.connect(_play_godot_damage)

func _play_hit_sound():
    _raven_hit_sound_player.play()

func _play_random_sound():
   _raven_random_player.play()
func _play_godot_damage():
    _godot_damaged_sound.play()