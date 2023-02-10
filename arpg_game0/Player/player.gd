extends KinematicBody2D

var velocity:Vector2=Vector2.ZERO
var speed0
export var max_speed:int
export var accleration:int
enum {
	move,
	attack,
	roll
}
onready var animationtree=$AnimationTree
onready var animationtree_state=animationtree.get("parameters/playback")
onready var swordhitbox=$HitboxPivot/SwordHitbox
onready var blinkanimationplayer=$BlinkAnimationPlayer
onready var moneyui=get_node("/root/world/CanvasLayer/MoneyUI")
var alive:bool=true
onready var colli1=$CollisionShape2D
onready var colli2=$HitboxPivot/SwordHitbox/CollisionShape2D
onready var colli3=$Hurtboxes/CollisionShape2D
onready var player_rebirth_place=get_node("/root/world/player_rebirth_place")
onready var popup=$death/Popup
onready var timer=$Timer
onready var treasure_timer=$Treasure_timer
onready var popup2=$Lost_money_collected/Popup
onready var inventury=get_node("/root/world/CanvasLayer/InventuryUI")
var Lost_money=preload("res://object/Lost_money.tscn")
signal health_changed
var state=move
var speed_level=0
export var quick:bool=false
export var quick_attack:bool=false
export var anti:int=0
func _ready():
	max_speed=100
	accleration=500
	$AnimationTree.active=true
# warning-ignore:return_value_discarded
	Playerstats.connect("no_health",self,"mask_death")
	blinkanimationplayer.play("stop")
	state=move


func _physics_process(delta):
	if alive:
		match state:
			move:
				state_move(delta)
			attack:
				state_attack(delta)
			roll:
				state_roll(delta)

func _unhandled_input(event):
	if event.is_action_pressed("inventury"):
		inventury.popup()
		get_tree().paused=true

func state_move(delta):
	var input_vector:Vector2=Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x+=1
	if Input.is_action_pressed("ui_left"):
		input_vector.x-=1
	if Input.is_action_pressed("ui_up"):
		input_vector.y-=1
	if Input.is_action_pressed("ui_down"):
		input_vector.y+=1
	input_vector=input_vector.normalized()
	
	if input_vector!=Vector2.ZERO:
		animationtree.set("parameters/run/blend_position",input_vector)
		animationtree.set("parameters/idle/blend_position",input_vector)
		animationtree.set("parameters/roll/blend_position",input_vector)
		animationtree.set("parameters/roll_quick/blend_position",input_vector)
		animationtree_state.travel("run")
	else:
		animationtree_state.travel("idle")
	
	velocity=velocity.move_toward(input_vector*(max_speed+speed_level*15),delta*accleration)
	velocity=move_and_slide(velocity)
	
	input_vector=Vector2.ZERO
	if Input.is_action_pressed("attack_right"):
		input_vector.x+=1
	if Input.is_action_pressed("attack_left"):
		input_vector.x-=1
	if Input.is_action_pressed("attack_up"):
		input_vector.y-=1
	if Input.is_action_pressed("attack_down"):
		input_vector.y+=1
	input_vector=input_vector.normalized()
	
	if input_vector!=Vector2.ZERO:
		animationtree.set("parameters/attack/blend_position",input_vector)
		animationtree.set("parameters/attack_quick/blend_position",input_vector)
		swordhitbox.knockback_vector=input_vector
#		print(input_vector)
		state=attack
	if Input.is_action_pressed("roll"):
#		print("wuhu")
		state=roll
	
# warning-ignore:unused_argument
func state_attack(delta):
	velocity=Vector2.ZERO
#	print("wuhu")
	if !quick_attack:
		animationtree_state.travel("attack")
	else:
		animationtree_state.travel("attack_quick")
#	print($AnimationPlayer.current_animation)
#	print("enheng")
	pass
	

# warning-ignore:unused_argument
func state_roll(delta):
	velocity=animationtree.get("parameters/roll/blend_position")
	velocity=velocity.normalized()*(125+speed_level*15)
	velocity=move_and_slide(velocity)
#	print(velocity)
	$Hurtboxes.set_deferred("monitoring",false)
	if !quick:
		animationtree_state.travel("roll")
	else:
		animationtree_state.travel("roll_quick")
	velocity*=0.6
	pass


func attack_animation_finished():
#	print("aha")
	var temp:Vector2
	temp=animationtree.get("parameters/attack/blend_position")
	animationtree.set("parameters/run/blend_position",temp)
	animationtree.set("parameters/idle/blend_position",temp)
	animationtree_state.travel("idle")
	state=move

func roll_animation_finished():
	$Hurtboxes.set_deferred("monitoring",true)
	animationtree_state.travel("idle")
	state=move


func _on_SwordHitbox_body_entered(body):
	if body==get_node("/root/world/YSort/football_field/football"):
		var impulse:Vector2=Vector2.RIGHT
		impulse*=500
		impulse=impulse.rotated($HitboxPivot.rotation)
		body.apply_central_impulse(impulse)
		body.apply_torque_impulse (body.rotation_impulse)
	pass # Replace with function body.


func _on_Hurtboxes_area_entered(area):
	if Playerstats.shield>=(area.damage+area.extra_damage-anti) :
		Playerstats.shield-=(area.damage+area.extra_damage-anti)
	else:
		Playerstats.shield=0
		Playerstats.health-=(area.damage+area.extra_damage-Playerstats.shield-anti)
	$AudioStreamPlayer2.play()
	emit_signal("health_changed")
	$Hurtboxes.start_invincibility(0.5)
	blinkanimationplayer.play("start")
	pass # Replace with function body.


func _on_Timer_timeout():
	blinkanimationplayer.play("stop")
	pass # Replace with function body.

func mask_death():
	visible=false
	alive=false
	while velocity!=Vector2.ZERO:
		velocity=Vector2.ZERO
		velocity=move_and_slide(velocity)
	colli1.set_deferred("disabled",true)
	colli2.set_deferred("disabled",true)
	colli3.set_deferred("disabled",true)
	animationtree.set("parameters/idle/blend_position",Vector2.LEFT)
	animationtree_state.travel("idle")
	var lost_money=Lost_money.instance()
	get_parent().call_deferred("add_child",lost_money)
	lost_money.set_deferred("global_position",global_position)
	lost_money.money=moneyui.money/2
	lost_money.connect("money_collect",self,"lost_money_collected")
	moneyui.set_money(-moneyui.money/2)
	popup.popup_centered()
	timer.start()
	pass


func _on_Timer_timeout_2():
	popup.visible=false
	global_position=player_rebirth_place.global_position
	visible=true
	alive=true
	Playerstats.health=Playerstats.max_health
	emit_signal("health_changed")
	colli1.set_deferred("disabled",false)
	colli3.set_deferred("disabled",false)
	var dialogic=Dialogic.start("村长_rebirth")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	get_parent().add_child(dialogic)
	get_tree().paused=true


func dialogic_end(value):
	if value=="村长_rebirth":
		get_tree().paused=false


func lost_money_collected():
	treasure_timer.start()
	popup2.popup_centered()
	pass


func _on_Treasure_timer_timeout_3():
	popup2.visible=false
	pass # Replace with function body.


func _on_Timer2_timeout():
	state=move
	$Timer2.stop()
	animationtree_state.travel("idle")
	pass # Replace with function body.
