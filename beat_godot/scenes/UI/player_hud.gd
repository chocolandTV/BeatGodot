extends Control
class_name Player_HUD

#####################################
@onready var life_texture:TextureRect = $VBoxContainer/Player_Progress_Panel/Life_container/Life_01
@onready var player_score_label : Label =$VBoxContainer/Player_Progress_Panel/Score_Holder/HBoxContainer/player_score

@onready var godot_engine_Part_01: TextureRect =$VBoxContainer/Player_Progress_Panel/Player_Item_Panel/Life_Panel_02/Godot_Part_01
@onready var godot_engine_Part_02: TextureRect =$VBoxContainer/Player_Progress_Panel/Player_Item_Panel/Life_Panel_04/Godot_Part_02
@onready var godot_engine_Part_03: TextureRect=$VBoxContainer/Player_Progress_Panel/Player_Item_Panel/Life_Panel_03/Godot_Part_03

@onready var godot_engine_chat : TextEdit = $MarginContainer/Godot_Engine_talk/TextEdit
#### GODOT ENGINE ANIMATION 
@onready var godot_animation_player : AnimationPlayer = $MarginContainer/Godot_Engine_talk/AnimationPlayer
@onready var godot_animation_sprite : AnimatedSprite2D = $MarginContainer/Godot_Engine_talk/TextureRect/AnimatedSprite2D
@onready var godot_win : MarginContainer =$Win_Panel
## particle health_meta_game
@onready var particle_health_01: CPUParticles2D =$VBoxContainer/Player_Progress_Panel/Life_container/particle_01
@onready var particle_health_02: CPUParticles2D =$VBoxContainer/Player_Progress_Panel/Life_container/particle_02
@onready var particle_health_03: CPUParticles2D =$VBoxContainer/Player_Progress_Panel/Life_container/particle_03
###### PLAYER CLICKED ON LIFE ICONS
## textures 
var _three_life_icon : Texture2D  = preload("res://assets/textures/health_panel_3_hearths.png")
var _two_life_icon : Texture2D  = preload("res://assets/textures/health_panel_2_hearths.png")
var _one_life_icon : Texture2D  = preload("res://assets/textures/health_panel_1_hearths.png")
var _zero_life_icon : Texture2D  = preload("res://assets/textures/health_panel_0_hearths.png")
var _inf_life_icon : Texture2D  = preload("res://assets/textures/health_panel_8_hearths.png")
var player_metagame_life : int = 9
var is_life_container_highlighted : bool  = false
var meta_is_done : bool = false

func _ready() -> void:
    get_node("/root/GlobalData").SET_PLAYERHUD(self)
    update_player_life(3)
    update_player_score(0)
    life_texture.mouse_entered.connect(on_life_container_entered)
    life_texture.mouse_exited.connect(on_life_container_exited)

### update all thingi

func godot_anim_play_dificult():
    ### TEXT TWEEN EPIC NEW FUNCTION
#     func _ready():
    # 	var tween = create_tween()
    # 	tween.tween_method(set_label_text, 0, 10, 1).set_delay(1)

    # func set_label_text(value: int):
    # 	$Label.text = "Counting " + str(value)
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
        godot_win.start_scaling()


########## END 
func update_player_life(value : int):
    if value ==3:
        life_texture. texture = _three_life_icon
    if value ==2:
        life_texture. texture = _two_life_icon
    if value ==1 :
        life_texture. texture = _one_life_icon
    if value == 0:
        life_texture. texture = _zero_life_icon
    if value == -1:
        life_texture. texture = _inf_life_icon

func on_life_container_entered():
    is_life_container_highlighted = true
func on_life_container_exited():
    is_life_container_highlighted = false

func on_text_changed(_newstring: String):
    godot_engine_chat.placeholder_text = _newstring

func _input(event: InputEvent) -> void:
        if event.is_action_pressed("left_click") and  is_life_container_highlighted and !meta_is_done:
            player_metagame_life -=1
            print(player_metagame_life)
            if player_metagame_life == 6:
                update_meta_life(2)
                godot_animation_player.play("item10")
            if player_metagame_life ==3:
                update_meta_life(1)
                godot_animation_player.play("item10")
            if player_metagame_life <= 0:
                update_meta_life(-1)
                godot_animation_player.play("item10")
                ## get metaprogression


func update_meta_life(value : int):
    if value ==2:
        particle_health_03.emitting = true
        
    if value ==1 :
        particle_health_02.emitting = true

    if value == -1:
        particle_health_01.emitting = true
