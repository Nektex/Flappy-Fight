extends Node

var game_running : bool
var game_over : bool
var scroll
var score
const Scroll_Speed : int = 4
var screen_size : Vector2i
var ground_height : int

# Called when the enters the scene tree for the first time.

func _ready():
	screen_size = get_window().size
	new_game()
	
func new_game():
	# reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$Ship.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Ship.flying:
						$Ship.ship()
						check_top()

func start_game():
	game_running = true
	$Ship.flying = true
	$Ship.ship()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
			scroll += Scroll_Speed
			# reset scroll
			if scroll >= screen_size.x:
				scroll = 0
			# move ground node
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
