extends Node
class_name Health_Component
signal died()
signal health_changed()

@export var max_health : int =  3
var is_invincible : bool  = false
var current_health : int = 3
var player_hearth_damage : int = 0

func set_life(value : int):
    max_health = value
    current_health = value

func damage(damage_amount : int):
    if is_invincible:
        return
    current_health -= damage_amount
    health_changed.emit()
    if current_health >0:
        check_death()

    
func check_death():
    if current_health <= 0:
        died.emit()

func damage_player_hearth():
    if player_hearth_damage < 3:
        player_hearth_damage += 1
    if player_hearth_damage ==3:
        ## signal game_mode 2 starts
        is_invincible = true