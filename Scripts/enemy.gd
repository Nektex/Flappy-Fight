extends CharacterBody2D

@export var speed: float = 150.0  # Geschwindigkeit 
var treffer: int = 0 # Leben mäßig

func _process(delta):
	position.x -= speed * delta

	if position.x < -800:  
		queue_free()

func on_hit() -> bool:
	treffer += 1
	if treffer >=2:
		queue_free()
		return true
	return false
	

	treffer += 1
	if treffer >= 2:
		queue_free()  # Gegner zerstören
		return true   # Rückmeldung: Gegner wurde zerstört
	return false  # Gegner lebt noch
