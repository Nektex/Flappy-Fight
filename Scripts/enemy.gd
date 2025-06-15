extends CharacterBody2D

@export var speed: float = 150.0  # Geschwindigkeit 
var anzahlLeben: int = 2 # Trefferanzahl bis queue free

func _process(delta):
	position.x -= speed * delta



	if position.x < -800:  
		queue_free()



func take_damage():
	anzahlLeben -= 1
	if anzahlLeben <= 0:
		queue_free()
