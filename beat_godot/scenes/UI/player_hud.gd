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

@export var godot_engine_chat : LineEdit
#### GODOT ENGINE ANIMATION 
@onready var godot_animation_player : AnimationPlayer = $Godot_Engine_talk/AnimationPlayer
@onready var godot_animation_sprite : AnimatedSprite2D = $Godot_Engine_talk/TextureRect/AnimatedSprite2D
@onready var godot_win : CanvasLayer =$Win_Panel
###### PLAYER CLICKED ON LIFE ICONS
var player_metagame_life : int = 9
var is_life_container_highlighted : bool  = false


func _ready() -> void:
    get_node("/root/GlobalData").SET_PLAYERHUD(self)
    update_player_life(3)
    update_player_score(0)

    life_icon_01.mouse_entered.connect(on_life_container_entered)
    life_icon_02.mouse_entered.connect(on_life_container_entered)
    life_icon_03.mouse_entered.connect(on_life_container_entered)

    life_icon_01.mouse_exited.connect(on_life_container_exited)
    life_icon_02.mouse_exited.connect(on_life_container_exited)
    life_icon_03.mouse_exited.connect(on_life_container_exited)

### update all thingi

func godot_anim_play_dificult():
    godot_animation_player.play("score10")
    godot_animation_sprite.play("angry")

func godot_anim_play_endgame():
    godot_animation_player.play("metagame")
    godot_animation_sprite.play("terrified")

func godot_anim_play_damaged():
    godot_animation_player.play("metagame")
    godot_animation_sprite.play("redgodot")

func update_player_score(game_score : int):
    player_score_label.text = str(game_score)

############## ENDGAME
func update_metagame(value : int):
    if value >=1:
        godot_engine_Part_01.visible = true
        godot_engine_Part_02.visible = false
        godot_engine_Part_03.visible = false
    if value >=2:
        godot_engine_Part_01.visible = true
        godot_engine_Part_02.visible = true
        godot_engine_Part_03.visible = false
    if value >=3 :
        godot_engine_Part_01.visible = true
        godot_engine_Part_02.visible = true
        godot_engine_Part_03.visible = true
        get_tree().paused = true
        godot_win.visible  = true

########## END 
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

func on_life_container_entered():
    is_life_container_highlighted = true
func on_life_container_exited():
    is_life_container_highlighted = false

func on_text_changed(_newstring: String):
    ##set random animation and text 
    print("random text")

func _input(event: InputEvent) -> void:
        if event.is_action_pressed("left_click") and  is_life_container_highlighted:
            player_metagame_life -=1
            print(player_metagame_life)
            if player_metagame_life == 6:
                update_player_life(2)
                godot_animation_player.play("item10")
            if player_metagame_life ==3:
                update_player_life(1)
                godot_animation_player.play("item10")
            if player_metagame_life <= 0:
                update_player_life(-1)
                godot_animation_player.play("item10")
                get_node("/root/GlobalData").game_manager.player_metagame_progress()


            