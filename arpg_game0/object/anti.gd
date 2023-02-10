extends Area2D

var knockback:Vector2=Vector2.ZERO
var velocity:Vector2=Vector2.ZERO

onready var PlayerDetectionArea=$PlayerDetectionArea
onready var softcollision=$Softcollision
onready var player0=get_node("/root/world/YSort/player")
onready var label=get_node("/root/world/CanvasLayer/Label")

export var max_speed=100
export var accleration=300
export var friction=200



func _physics_process(delta):
	if PlayerDetectionArea.can_see_player():
		var player0=PlayerDetectionArea.player
		if player0!=null:
			var direction:Vector2=(player0.global_position-global_position)
			if direction.length()<7:
				player0.anti+=1
				label.show_label("您已获得抗性宝珠",1.5)
				call_deferred("queue_free")
			direction=direction.normalized()
			velocity=velocity.move_toward(max_speed*direction,accleration*delta)
	else:
		velocity=velocity.move_toward(Vector2.ZERO,accleration*delta)
	if softcollision.is_colliding():
		velocity+=softcollision.get_push_vector()*delta*400
	global_position+=velocity*delta

