extends Node

@export var mob_scene: PackedScene # allows us to choose the mob scene we want to instance
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game() # Replace with function body.
	#_on_mob_timer_timeout() # test spawning a new mob immeditatley


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## when the player is hit, game over sequence initiated
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

## start the start timer on a new game
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout():
	#print("Spawning mob!")
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf() # returns random float between zero and one

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

## restart score timer for new round and how long mobs will be spawning for
func _on_score_timer_timeout():
	#print("Score timer triggered.")
	$MobTimer.start()
	$ScoreTimer.start()


## if player successfully dodges all of the mobs during the timeframe, 
## a score of one is added to total player score
func _on_start_timer_timeout():
	score += 1
	$ScoreTimer.start()
	$MobTimer.start()
