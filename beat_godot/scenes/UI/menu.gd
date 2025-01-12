extends Control
class_name Menu

var _game_manager: Game_Manager
var _audio_manager: Audio_Manager
@onready var credit_panel: MarginContainer = $Credits
@onready var button_start: Button = $MarginContainer/VBoxContainer/Button_Start
@onready var button_resume: Button = $MarginContainer/VBoxContainer/Button_Resume
@onready var button_restart: Button = $MarginContainer/VBoxContainer/Button_Restart
@onready var button_version: Button = $MarginContainer/VBoxContainer/Button_version
@onready var menu_spawn_timer : Timer = $Raven_Spawner/Timer
@onready var particle : CPUParticles2D =$MarginContainer/VBoxContainer/Button_version/CPUParticles2D
@export var is_game_menu : bool = false
var is_credits_visible: bool = false
var _secret_raven_counter : int  =0
func _ready() -> void:
    get_node("/root/GlobalData").SET_MENU(self)
    _audio_manager = get_node("/root/Audio")
    button_start.pressed.connect(on_button_pressed_start)
    button_restart.pressed.connect(on_button_pressed_restart)
    button_resume.pressed.connect(on_button_pressed_resume)
    button_version.pressed.connect(on_button_pressed_version)
    _game_manager = get_node("/root/GameManager")
    _game_manager.player_menu = self
    visible  = is_game_menu
    
func game_paused():
    menu_spawn_timer .start()
    visible = true
func on_button_pressed_version():
    _audio_manager.play_random()

func on_button_pressed_start():
    get_tree().change_scene_to_file("res://scenes/_game/game.tscn")

func on_button_pressed_resume():
    button_start.visible = false
    button_restart.visible = true
    button_resume.visible = true
    menu_spawn_timer .stop()
    _game_manager.resume_game()
    visible  = false


func on_button_pressed_restart():
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/_game/game.tscn")

func on_button_pressed_quit():
    _game_manager.quit_game()

func on_button_pressed_credits():
    is_credits_visible = !is_credits_visible
    credit_panel.visible = is_credits_visible

func update_game_over():
    button_resume.visible = false
func increase_menu_raven_counter():
    _secret_raven_counter +=1
    if _secret_raven_counter >= 10 :
        update_raven_counter()

func update_raven_counter():
    if(_secret_raven_counter >= 100):
        button_version.text = "Minigame: "+ str( _secret_raven_counter) + "/ 1000"
        if(_secret_raven_counter >= 1000):
            button_version.text = "You have to much time, gratzzzzz"
            particle.emitting = true
    else:
        button_version.text = "Ravens: "+ str( _secret_raven_counter)
