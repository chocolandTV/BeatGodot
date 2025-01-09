extends AudioStreamPlayer
class_name Audio_Executer


@onready var _raven_hit_sound_player : AudioStreamPlayer  =$Raven_Hit_Sound
@onready var _raven_random_player : AudioStreamPlayer  =$Raven_Random_Sound
@onready var _godot_damaged_sound : AudioStreamPlayer = $Godot_damage
var _audio_manager : Audio_Manager
func _ready() -> void:
    _audio_manager = get_node("/root/Audio")
    _audio_manager.play_hit_sound.connect(_play_hit_sound)
    _audio_manager.play_random_sound.connect(_play_random_sound)
    _audio_manager.play_godot_damaged.connect(_play_godot_damage)

func _play_hit_sound():
    _raven_hit_sound_player.play()

func _play_random_sound():
   _raven_random_player.play()
func _play_godot_damage():
    _godot_damaged_sound.play()