extends Area2D # links to the Player (renamed from player2D)

# set node variables
@export var speed = 400 # How fast the player will move (pixels/sec). @export allows the variable to be set in the inspector
var screen_size # Size of the game window.


## Called when the node enters the scene tree for the first time, essentially init
func _ready():
	screen_size = get_viewport_rect().size # find size of screen window? - not getting why 
	#hide() # hide player when game starts


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
		velocity.y -= 1 # minus as y increases downwards
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
		
	# normalise velocity vector, avoids faster movement in the diagonal if both x and y direction pressed
	# at the same time. Also check if player is moving (is velocity non zero)
	if velocity.length() > 0: # player is moving
		velocity = velocity.normalized() * speed # speed is previously defined
		$AnimatedSprite2D.play() # if player is moving, sprite is animated, equivalent to get_node("AnimatedSprite2D").play()
	
	## In GDScript, $ returns the node at the relative path from the current node, or returns null if 
	## the node is not found. Since AnimatedSprite2D is a child of the current node, we can use $AnimatedSprite2D.
	## this script is attached to the Player so any of the nodes under Player in the scene can be accessed.
	else: # player is not moving
		$AnimatedSprite2D.stop() # stop animation, changing a comment for test
		
	# update players position
	position += velocity * delta # delta is the frame length
	position = position.clamp(Vector2.ZERO, screen_size) # prevent character from leaving the screen, Vector2 = (0, 0) in top left of screen, screen size is the bottom right coords of the screen
	
	# edit the player animation based on walking direction
	if velocity.x != 0: # if the player is moving horizontally
		$AnimatedSprite2D.animation = "right" # tells the AnimatedSprite2D node to play the animation named "walk"
		#get_node("AnimatedSprite2D").play().animation = "walk" # same as above line but long hand
		$AnimatedSprite2D.flip_v = false # reset vertical flip as may have been set true in previous frame
		$AnimatedSprite2D.flip_h = velocity.x < 0 # if the player is moving left, flip the walk animation
	
	# check if player is moving vertically
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = 'up' # play up animation from animations
		$AnimatedSprite2D.flip_v = velocity.y > 0 # flip animation if player going down
		
	# prevent player from flipping upwards if going diagonally down
	if velocity.y != 0:
		$AnimatedSprite2D.flip_v = velocity.y > 0 # flip player vertically if moving downwards
	
