extends CharacterBody2D
var pos:Vector2
var rota: float
var dir: float
var speed = 1000

func _ready():
	global_position=pos
	global_rotation=rota

func _physics_process(delta):
	velocity=Vector2(speed,0).rotated(dir)
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("enemies"):
			if collider.has_method("on_hit"):
				collider.on_hit()
			queue_free()  # Projektil verschwindet nach dem Treffer
			break
