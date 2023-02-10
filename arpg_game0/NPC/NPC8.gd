extends KinematicBody2D

var velocity:Vector2=Vector2.ZERO

signal player_interact

onready var sprite2=$Sprite2
onready var animatedsprite=$AnimatedSprite
onready var wandercontroller=$WanderController
var player_in:bool=false
enum{
	idle,
	wander
}
var state=idle

export var max_speed=25
export var accleration=300
export var friction=200

func _ready():
	animatedsprite.playing=false
	animatedsprite.animation="walk_down"
	animatedsprite.frame=1


func _physics_process(delta):
	match state:
		idle:
			velocity=velocity.move_toward(Vector2.ZERO,friction*delta)
			get_new_state(0)
			animatedsprite.playing=false
			animatedsprite.frame=1
		wander:
			while global_position.distance_to(wandercontroller.target_position)<=5:
				get_new_state(1)
			var direction:Vector2=(wandercontroller.target_position-global_position)
			direction=direction.normalized()
			velocity=velocity.move_toward(max_speed*direction,accleration*delta)
			if velocity.x>0:
				animatedsprite.animation="walk_right"
			elif velocity.x<0:
				animatedsprite.animation="walk_left"
			elif velocity.y>0:
				animatedsprite.animation="walk_down"
			elif velocity.y<0:
				animatedsprite.animation="walk_up"
			velocity=move_and_slide(velocity)
			animatedsprite.playing=true


func get_new_state(op):
	if wandercontroller.timer_lefttime()==0 or op==1:
		state=pick_random_state([idle,wander])
		wandercontroller.start_timer(rand_range(1,3))
		if state==wander:
			return wandercontroller.update_target_position()


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func _on_Area2D_body_entered(body):
	if body==get_node("/root/world/YSort/player"):
		player_in=true
		sprite2.visible=true
	pass # Replace with function body.



func _on_Area2D_body_exited(body):
	if body==get_node("/root/world/YSort/player"):
		player_in=false
		sprite2.visible=false
	pass # Replace with function body.


func _input(event):
	if player_in:
		if event.is_action_pressed("interact"):
			emit_signal("player_interact")

