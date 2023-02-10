extends RigidBody2D

export var speed_max:int
export var speed_min:int

var mob_state=["swim","walk","fly"]

func _ready():
	$AnimatedSprite.animation=mob_state[randi()%mob_state.size()]
	$AnimatedSprite.play()



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
