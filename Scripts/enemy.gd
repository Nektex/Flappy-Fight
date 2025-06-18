extends CharacterBody2D

@export var speed: float = 150.0  
var treffer: int = 0 

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
	
