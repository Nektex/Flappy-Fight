extends AnimatedSprite2D


@export var speed: float = 150.0  # Geschwindigkeit 
var hitpoints: int = 2 # Trefferanzahl bis queue free

func _process(delta):
	position.x -= speed * delta

	if position.x < -100:  
		queue_free()
		
func _on_body_entered(body):
	if body.name == "Projectile":
		hitpoints -= 1
		body.queue_free()  # Projektil verschwindet
		if hitpoints <= 0:
			queue_free()
