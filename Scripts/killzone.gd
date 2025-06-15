extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: CharacterBody2D): 
	print ("Du bist gestorben!")
	body.queue_free()
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
