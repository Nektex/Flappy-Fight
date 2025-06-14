extends CharacterBody2D

const Gravity : int = 1000
const Max_Vel : int = 600
const Ship_Speed : int = -500
var flying : bool = false
var falling : bool = false
const Start_Pos = Vector2(100, 100)
var projectile_path = preload("res://Scenes/projectile.tscn")
# Called when the node enters the scene tree for the first time.
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
	if flying or falling:
		velocity.y += Gravity * delta
		# terminal velocity
		if velocity.y > Max_Vel:
			velocity.y = Max_Vel
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()
		
func ship():
	velocity.y = Ship_Speed

func fire():
	var projectile = projectile_path.instantiate()
	projectile.look_at(get_global_mouse_position())
	projectile.pos=$Node2D.global_position
	get_parent().add_child(projectile)
