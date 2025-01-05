extends CanvasLayer
class_name Player_HUD
## turn off if player attack his life and destroyed
@export var life_holder : HBoxContainer
@export var life_label : Label
#####################################
@export var life_icon_01:TextureRect 
@export var life_icon_02 : TextureRect
@export var life_icon_03 : TextureRect

@export var player_score_label : Label

@export var godot_engine_Part_01: TextureRect
@export var godot_engine_Part_02: TextureRect
@export var godot_engine_Part_03: TextureRect

@export var godot_engine_chat : TextEdit
#### GODOT ENGINE ANIMATION 
@onready var godot_animation_player : AnimationPlayer = $Godot_Engine_talk/AnimationPlayer
@onready var godot_animation_sprite : AnimatedSprite2D = $Godot_Engine_talk/TextureRect/AnimatedSprite2D
###### PLAYER CLICKED ON LIFE ICONS
var player_progress_life_01 : int = 0
var player_progress_life_02: int = 0
var player_progress_life_03 : int = 0

func _ready() -> void:
    get_node("/root/GlobalData").SET_PLAYERHUD(self)
    update_player_life(3)
### update all thingi

func godot_anim_play_dificult():
    godot_animation_player.play("score10")
    godot_animation_sprite.play("angry")

func update_player_score(game_score : int):
    player_score_label.text = str(game_score)

func update_player_life(value : int):
    if value ==3:
        life_icon_01.visible = true
        life_icon_02.visible = true
        life_icon_03.visible = true
    if value ==2:
        life_icon_01.visible = true
        life_icon_02.visible = true
        life_icon_03.visible = false
    if value ==1 :
        life_icon_01.visible = true
        life_icon_02.visible = false
        life_icon_03.visible = false
    if value == 0:
        life_icon_01.visible = false
        life_icon_02.visible = false
        life_icon_03.visible = false
    if value == -1:
        #new icon
        life_holder.visible = false
        life_label.text = "8"
        life_label.rotation_degrees = 90.0
        life_label.add_theme_font_size_override("font_size",40)
