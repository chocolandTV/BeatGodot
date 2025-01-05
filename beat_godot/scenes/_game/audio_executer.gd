extends AudioStreamPlayer
class_name Audio_Executer


@onready var raven_hit_sound_player : AudioStreamPlayer  =$Raven_Hit_Sound
@onready var raven_random_player : AudioStreamPlayer  =$Raven_Random_Sound

func _ready() -> void:
    get_node("/root/GlobalData").audio_manager.play_hit_sound.connect(play_hit_sound)
    get_node("/root/GlobalData").audio_manager.play_random_sound.connect(play_random_sound)

func play_hit_sound():
    raven_hit_sound_player.play()

func play_random_sound():
    raven_random_player.play()