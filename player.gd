extends Area2D # links to the Player (renamed from player2D)

# set node variables
@export var speed = 400 # How fast the player will move (pixels/sec). @export allows the variable to be set in the inspector
var screen_size # Size of the game window.


## Called when the node enters the scene tree for the first time, essentially init
func _ready():
	screen_size = get_viewport_rect().size # find size of screen window? - not getting why 


## Called every frame. 'delta' is the elapsed time since the previous frame. Used to update elements of the game
## We need to check for input - is the player pressing a key - 4 direction inputs to check for this game, up
## down, left and right.
## Move player ina given direction
## Play the appropriate animation
func _process(delta: float):
	
	# set velocity of player
	var velocity = Vector2.ZERO
	
	# adjust velocity of player based on user inputs, can access input map by Input.is_action_pressed
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1	
	if Input.is_action_pressed('move_up'):
		velocity.y += 1
	if Input.is_action_pressed('move_down'):
		velocity.y -= 1
		
	# normalise velocity vector, avoids faster movement in the diagonal if both x and y direction pressed
	# at the same time. Also check if player is moving (is velocity non zero)
	if velocity.length() > 0: # player is moving
		velocity = velocity.normalized() * speed # speed is previously defined
		$AnimatedSprite2D.play()
	else: # player is not moving
		$AnimatedSprite2D.stop() # stop animation, changing a comment for test
	
		
	
