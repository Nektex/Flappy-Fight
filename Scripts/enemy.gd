extends AnimatedSprite2D


@export var speed: float = 100.0  # Geschwindigkeit 
var hitpoints: int = 2 # Trefferanzahl bis queue free

func _process(delta):
	position.x -= speed * delta

	if position.x < -800:  
		queue_free()
		
