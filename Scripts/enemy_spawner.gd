extends Node2D


@export var enemy_scene: PackedScene = preload("res://Scenes/enemy.tscn") # Enemy Scene laedn
@export var start_interval: float = 4.0   # Startzeit zwischen Spawns
@export var min_interval: float = 0.5     # minimale Spawnrate
@export var difficulty_rise_rate: float = 0.05  # alle X Sekunden wird es schwerer

var spawn_timer: float = 0.0
var elapsed_time: float = 0.0

func _process(delta):
	elapsed_time += delta
	spawn_timer += delta

	# aktuellen Intervall berechnen
	var current_interval = max(start_interval - elapsed_time * difficulty_rise_rate, min_interval)

	if spawn_timer >= current_interval:
		spawn_timer = 0.0
		spawn_enemy()


func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(800, randi() % 400 + 25)  # x=800 (rechter Bildschirmrand), y zufällig
	get_tree().current_scene.add_child(enemy)
