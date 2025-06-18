extends CharacterBody2D

const Gravity: int = 1000
const Max_Vel: int = 600
const Ship_Speed: int = -500
var flying: bool = false
var falling: bool = false
const Start_Pos = Vector2(100, 200)
var score

var projectile_path = preload("res://Scenes/projectile.tscn")

@onready var parent = get_parent()

func _ready():
	reset()

func reset():
	falling = false
	flying = false
	position = Start_Pos
	set_rotation(0)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Schießen"):
		fire()

	if not parent.game_over and Input.is_action_just_pressed("flying"):
		if not parent.game_running:
			parent.start_game()
		if flying:
			ship()
			parent.check_top()

	if flying or falling:
		velocity.y += Gravity * delta
		if velocity.y > Max_Vel:
			velocity.y = Max_Vel
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()

		# Bewegung durchführen
		move_and_slide()

		# Alle Kollisionen prüfen
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider.is_in_group("enemies") and not parent.game_over:
				parent.game_over = true
				print("Ship zerstört", collider.name)
				call_deferred("reload_scene")
				break
	else:
		$AnimatedSprite2D.stop()

func reload_scene():
	get_tree().reload_current_scene()
		
func ship():
	velocity.y = Ship_Speed
	
func _HitEnemy(delta):
	var num = get_slide_collision_count()
	for i in range(num):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		# Spieler verliert bei Kollision mit Gegner
		if collider and collider.is_in_group("enemies") and not parent.game_over:
			print("Ship getroffen von:", collider.name)
			parent.stop_game()
			break

func fire():
	var projectile = projectile_path.instantiate()
	projectile.look_at(get_global_mouse_position())
	projectile.pos=$Node2D.global_position
	get_parent().add_child(projectile)
	
