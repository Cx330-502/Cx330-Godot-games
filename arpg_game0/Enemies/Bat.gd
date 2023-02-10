extends KinematicBody2D

var knockback:Vector2=Vector2.ZERO
var velocity:Vector2=Vector2.ZERO
var position0:Vector2
onready var start_position=global_position
onready var stats=$stats
onready var PlayerDetectionArea=$PlayerDetectionArea
onready var animatedsprite=$AnimatedSprite
onready var softcollision=$Softcollision
onready var wandercontroller=$WanderController
onready var blinkanimationplayer=$BlinkAnimationPlayer
onready var colli1=$CollisionShape2D
onready var colli2=$Hurtboxes/CollisionShape2D
onready var colli3=$PlayerDetectionArea/CollisionShape2D
onready var colli4=$Hitbox/CollisionShape2D
onready var colli5=$Softcollision/CollisionShape2D
onready var rebirth_area=get_node("/root/world/mobs_rebirth_area")
var EnemyDeathEffect=preload("res://Effects/EnemyDeathEffect.tscn")
var Dropmoney=preload("res://object/money.tscn")
export var alive:bool=true
var ahh:bool=true
enum{
	idle,
	wander,
	chase
}
var state=idle

export var max_speed=50
export var accleration=300
export var friction=200

func _ready():
	blinkanimationplayer.play("stop")
	rebirth_area.connect("body_entered",self,"_on_mobs_rebirth_area_body_entered")


func _physics_process(delta):
	if alive:
		knockback=knockback.move_toward(Vector2.ZERO,friction*delta)
		knockback=move_and_slide(knockback)
		match state:
			idle:
				velocity=velocity.move_toward(Vector2.ZERO,friction*delta)
#				get_new_state(0)
				detect_player()
			
#			wander:
#				detect_player()
			chase:
				var player=PlayerDetectionArea.player
				if player!=null:
					var direction:Vector2=(player.global_position-global_position)
					direction=direction.normalized()
					velocity=velocity.move_toward(max_speed*direction,accleration*delta)
				else:
					state=idle
			
		if softcollision.is_colliding():
			velocity+=softcollision.get_push_vector()*delta*400
		animatedsprite.flip_h=velocity.x<0
		velocity=move_and_slide(velocity)

func get_new_state(op):
	if wandercontroller.timer_lefttime()==0 or op==1:
		state=wander
		wandercontroller.start_timer(rand_range(1,3))
		if state==wander:
			return wandercontroller.update_target_position()


func detect_player():
	if PlayerDetectionArea.can_see_player():
		state=chase


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func _on_Hurtboxes_area_entered(area):
	stats.health-=(area.damage+area.extra_damage)
	$Hurtboxes.start_invincibility(0.2)
	blinkanimationplayer.play("start")
#	print("bat")
#	print(stats.health)
	knockback=area.knockback_vector*120
#	print(knockback)


func _on_stats_no_health():
	var enemydeatheffect=EnemyDeathEffect.instance()
	get_parent().add_child(enemydeatheffect)
	enemydeatheffect.global_position=global_position
	var i=stats.drop_money
	var dropmoney
	while i>0:
		i-=1
		dropmoney=Dropmoney.instance()
		get_parent().call_deferred("add_child",dropmoney)
		dropmoney.set_deferred("global_position",global_position)
	if ahh:
		mask_death()
	else:
		queue_free()


func _on_Timer_timeout():
	blinkanimationplayer.play("stop")


func mask_death():
	visible=false
	while velocity!=Vector2.ZERO:
		velocity=Vector2.ZERO
		velocity=move_and_slide(velocity)
	colli1.set_deferred("disabled",true)
	colli2.set_deferred("disabled",true)
	colli3.set_deferred("disabled",true)
	colli4.set_deferred("disabled",true)
	colli5.set_deferred("disabled",true)
	alive=false
	global_position=wandercontroller.start_position



# warning-ignore:unused_argument
func _on_mobs_rebirth_area_body_entered(body):
	if !alive and ahh:
		self.set_deferred("visible",true)
		colli1.set_deferred("disabled",false)
		colli2.set_deferred("disabled",false)
		colli3.set_deferred("disabled",false)
		colli4.set_deferred("disabled",false)
		colli5.set_deferred("disabled",false)
		alive=true
	elif !ahh:
		queue_free()
	global_position=start_position
	stats.health=stats.max_health
	pass # Replace with function body.



