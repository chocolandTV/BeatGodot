extends Node
class_name Health_Component
@export var max_health : int =  3
var is_invincible : bool  = false
var current_health : int = 3
var player_hearth_damage : int = 0

func damage(damage_amount : int):
    if is_invincible:
        return
    current_health -= damage_amount
    if current_health >0:
        check_death()

    
func check_death():
    if current_health <= 0:
        ## game over 
        return
func damage_player_hearth():
    if player_hearth_damage < 3:
        player_hearth_damage += 1
    if player_hearth_damage ==3:
        ## signal game_mode 2 starts
        is_invincible = true