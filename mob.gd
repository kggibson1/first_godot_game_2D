extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# randomly choose mob animation
	var mob_types = Array(get_node('AnimatedSprite2D').sprite_frames.get_animation_names()) # create array with all the mob animation types (walk, swim & fly)
	$AnimatedSprite2D.animation = mob_types.pick_random() # pick random animation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
