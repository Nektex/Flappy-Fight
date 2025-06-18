extends Node2D


@export var enemy_scene: PackedScene = preload("res://Scenes/enemy.tscn") 
@export var start_interval: float = 4.0   
@export var min_interval: float = 0.5     
@export var difficulty_rise_rate: float = 0.05  

@onready var main_game = get_tree().current_scene  


var spawn_timer: float = 0.0
var elapsed_time: float = 0.0

func _process(delta):
	if not main_game.game_running:
		return
	
	elapsed_time += delta
	spawn_timer += delta


	var current_interval = max(start_interval - elapsed_time * difficulty_rise_rate, min_interval)

	if spawn_timer >= current_interval:
		spawn_timer = 0.0
		spawn_enemy()


func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(800, randi() % 400 + 25)  
	enemy.add_to_group("enemies")
	get_tree().current_scene.add_child(enemy)
