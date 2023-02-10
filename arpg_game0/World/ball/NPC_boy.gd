extends KinematicBody2D

enum {
	play,
	stay
}
onready var football_gate=get_node("/root/world/YSort/football_field/football_gate")
onready var football=get_node("/root/world/YSort/football_field/football")
onready var boy_position=get_node("/root/world/YSort/football_field/Boy_position")
onready var animatedsprite=$AnimatedSprite
onready var sprite2=$Sprite2
export var max_speed:int=95
export var accleration=500
signal first_dialogic_over
signal over
var velocity:Vector2=Vector2.ZERO
var state=stay
var player_in:bool=false

func _ready():
	state=stay
	global_position=boy_position.global_position
	animatedsprite.animation="run_down"
	animatedsprite.playing=false
	animatedsprite.frame=0

func _physics_process(delta):
	if state==play:
		var direction=global_position.direction_to(football.global_position)
		velocity=velocity.move_toward(direction*max_speed,accleration*delta)
		if velocity.x>0:
			animatedsprite.animation="run_right"
		elif velocity.x<0:
			animatedsprite.animation="run_left"
		elif velocity.y>0:
			animatedsprite.animation="run_down"
		elif velocity.y<0:
			animatedsprite.animation="run_up"
		velocity=move_and_slide(velocity)
		animatedsprite.playing=true
	else:
		animatedsprite.playing=false
		animatedsprite.frame=0

func _input(event):
	if player_in and get_tree().paused==false:
		if event.is_action_pressed("interact") and sprite2.visible==true:
			var dialogic=Dialogic.start("小孩_初遇")
			dialogic.connect('dialogic_signal',self,"footballgame_start")
			get_parent().add_child(dialogic)
			get_tree().paused=true
#			if state==stay:
#				state=play
				
	pass


func footballgame_start(value):
	if value=="小孩_初遇":
		emit_signal("first_dialogic_over")
	elif value=="小孩_初遇_play":
		state=play
		get_parent().competition_in=true
		get_parent()._on_Timer_timeout()
		sprite2.visible=false
		get_tree().paused=false
	elif value=="小孩_初遇_not_play":
		get_tree().paused=false



func _on_hitball_area_body_entered(body):
	if body==get_node("/root/world/YSort/football_field/football"):
		var impulse:Vector2=Vector2.RIGHT
		var direction:Vector2=global_position.direction_to(football_gate.global_position)
		var rotation=impulse.angle_to(direction)
		rotation+=rand_range(-25,25)
		impulse*=300
		impulse=impulse.rotated(rotation)
		body.apply_central_impulse(impulse)
		body.apply_torque_impulse (body.rotation_impulse)
	pass # Replace with function body.


func _on_Label_Footballgame_over():
	global_position=boy_position.global_position
	state=stay


func _on_detect_player_area_body_entered(body):
	if body==get_node("/root/world/YSort/player") and get_parent().competition_in==false :
		sprite2.visible=true
		player_in=true



func _on_detect_player_area_body_exited(body):
	if body==get_node("/root/world/YSort/player") and get_parent().competition_in==false:
		player_in=false
		sprite2.visible=false


func _on_AcceptDialog_confirmed():
	var dialogic=Dialogic.start("小孩_初遇_play")
	dialogic.connect('dialogic_signal',self,"footballgame_start")
	add_child(dialogic)
	get_tree().paused=true


func _on_AcceptDialog_custom_action(action):
	var dialogic=Dialogic.start("小孩_初遇_not_play")
	dialogic.connect('dialogic_signal',self,"footballgame_start")
	emit_signal("over")
	add_child(dialogic)
	get_tree().paused=true
