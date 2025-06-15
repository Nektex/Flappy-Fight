extends CharacterBody2D



const Gravity : int = 1000
const Max_Vel : int = 600
const Ship_Speed : int = -500
var flying : bool = false
var falling : bool = false
const Start_Pos = Vector2(100, 100)
var projectile_path = preload("res://Scenes/projectile.tscn")
# Called when the node enters the scene tree for the first time.

@onready var parent = get_parent()
func _ready():
	reset()


func reset():
	falling = false
	flying = false
	position = Start_Pos
	set_rotation(0)
	
# Called every frame. 'delta' is the elapsed since the previous frame.
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Schießen"):
		fire()
	if not parent.game_over and (Input.is_action_just_pressed("flying")  ):
		if not parent.game_running:
			parent. start_game()
		if flying:
			ship()  # besser wäre: $Ship.flap() oder $Ship.jump()
			parent.check_top()	
		
		
	if flying or falling:
		velocity.y += Gravity * delta
		if velocity.y > Max_Vel:
			velocity.y = Max_Vel
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		var collision = move_and_collide(velocity * delta)
		if collision:
			var collider = collision.get_collider()
			if collider.name == "Enemy":
				print("Ship getroffen!")
				get_tree().reload_current_scene()
				parent.game_over = true
	else:
		$AnimatedSprite2D.stop()
		
func ship():
	velocity.y = Ship_Speed

func fire():
	var projectile = projectile_path.instantiate()
	projectile.look_at(get_global_mouse_position())
	projectile.pos=$Node2D.global_position
	get_parent().add_child(projectile)
