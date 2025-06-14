extends AnimatedSprite2D

@export var speed: float = 100.0  # Geschwindigkeit in Pixel pro Sekunde

func _process(delta):
	position.x -= speed * delta
