extends Area2D

var knockback:Vector2=Vector2.ZERO
var velocity:Vector2=Vector2.ZERO

onready var PlayerDetectionArea=$PlayerDetectionArea
onready var softcollision=$Softcollision
onready var moneyui=get_node("/root/world/CanvasLayer/MoneyUI")


export var max_speed=100
export var accleration=300
export var friction=200



func _physics_process(delta):
	if PlayerDetectionArea.can_see_player():
		var player=PlayerDetectionArea.player
		if player!=null:
			var direction:Vector2=(player.global_position-global_position)
			if direction.length()<7:
				moneyui.set_money(1)
				call_deferred("queue_free")
			direction=direction.normalized()
			velocity=velocity.move_toward(max_speed*direction,accleration*delta)
	else:
		velocity=velocity.move_toward(Vector2.ZERO,accleration*delta)
	if softcollision.is_colliding():
		velocity+=softcollision.get_push_vector()*delta*400
	global_position+=velocity*delta
