extends Area2D

var knockback:Vector2=Vector2.ZERO
var velocity:Vector2=Vector2.ZERO

export var type:int=0

onready var PlayerDetectionArea=$PlayerDetectionArea
onready var softcollision=$Softcollision
var sword1=preload("res://inventury/weapons/sword_1.tres")
var sword2=preload("res://inventury/weapons/sword_2.tres")
var sword3=preload("res://inventury/weapons/sword_3.tres")
var sword4=preload("res://inventury/weapons/sword_4.tres")
var shield1=preload("res://inventury/shield/shield_1.tres")
var shield2=preload("res://inventury/shield/shield_2.tres")
var shield3=preload("res://inventury/shield/shield_3.tres")
var shoes1=preload("res://inventury/shoes/shoes_1.tres")
var shoes2=preload("res://inventury/shoes/shoes_2.tres")
var shoes3=preload("res://inventury/shoes/shoes_3.tres")
var weapon_inventury=preload("res://inventury/weapons/Weapon_Inventury.tres")
var shield_inventury=preload("res://inventury/shield/Shield_Inventury.tres")
var shoes_inventury=preload("res://inventury/shoes/Shoes_Inventury.tres")
onready var label=get_node("/root/world/CanvasLayer/Label")
export var max_speed=100
export var accleration=300
export var friction=200
var item0


func _physics_process(delta):
	if PlayerDetectionArea.can_see_player():
		var player=PlayerDetectionArea.player
		if player!=null:
			var direction:Vector2=(player.global_position-global_position)
			if direction.length()<7:
				match type:
					1:
						item0=sword1
						weapon_inventury.creat_item(item0)
					2:
						item0=sword2
						weapon_inventury.creat_item(item0)
					3:
						item0=sword3
						weapon_inventury.creat_item(item0)
					4:
						item0=sword4
						weapon_inventury.creat_item(item0)
					5:
						item0=shield1
						shield_inventury.creat_item(item0)
					6:
						item0=shield2
						shield_inventury.creat_item(item0)
					7:
						item0=shield3
						shield_inventury.creat_item(item0)
					8:
						item0=shoes1
						shoes_inventury.creat_item(item0)
					9:
						item0=shoes2
						shoes_inventury.creat_item(item0)
					10:
						item0=shoes3
						shoes_inventury.creat_item(item0)
				label.show_label("装备已放入背包",1.5)
				call_deferred("queue_free")
			direction=direction.normalized()
			velocity=velocity.move_toward(max_speed*direction,accleration*delta)
	else:
		velocity=velocity.move_toward(Vector2.ZERO,accleration*delta)
	if softcollision.is_colliding():
		velocity+=softcollision.get_push_vector()*delta*400
	global_position+=velocity*delta

func disable():
	$CollisionShape2D.disabled=true
	$PlayerDetectionArea/CollisionShape2D.disabled=true
	$Softcollision/CollisionShape2D.disabled=true
	visible=false


func able():
	$CollisionShape2D.disabled=false
	$PlayerDetectionArea/CollisionShape2D.disabled=false
	$Softcollision/CollisionShape2D.disabled=false
	visible=true
