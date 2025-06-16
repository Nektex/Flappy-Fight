extends CharacterBody2D

@export var speed: float = 150.0  # Geschwindigkeit 




func _process(delta):
	position.x -= speed * delta

	if position.x < -800:  
		queue_free()
