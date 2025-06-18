extends Node

var game_running : bool
var game_over : bool
var scroll
var score
const Scroll_Speed : int = 4
var screen_size : Vector2i
var ground_height : int
var velocity


@onready var score_label = $CanvasLayer/Score
func _ready():
	screen_size = get_window().size
	new_game()
	

func update_score_label():
	if score_label:
		score_label.text = "Score: %d" % score
	

	
func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$Ship.reset()
	update_score_label()
	
	
	
	
	
func _Tastenabfrage(delta):
	pass


func start_game():
	game_running = true
	$Ship.flying = true
	$Ship.ship()




	

func _process(delta):
	_Tastenabfrage(delta)
	if game_running:
			scroll += Scroll_Speed
			
			if scroll >= screen_size.x:
				scroll = 0
			
			$ground.position.x = -scroll
			
			


func check_top():
	if $Ship.position.y < 0:
		$Ship.falling = true
		stop_game()
		
func stop_game():
	$Ship.flying = false
	game_running = false
	game_over = true
	
	
	
func shit_hit():
	pass
