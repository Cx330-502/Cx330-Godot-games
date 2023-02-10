extends Area2D

export var speed:int
var screensize
signal hit

func _ready():
	 pass

func start_game(pos):
	position=pos
	show()


func _process(delta):
	var vel=Vector2()
	screensize=get_viewport_rect().size
	
	if Input.is_action_pressed("ui_up"):
		vel.y-=1
	if Input.is_action_pressed("ui_w"):
		vel.y-=1
	if Input.is_action_pressed("ui_right"):
		vel.x+=1
	if Input.is_action_pressed("ui_d"):
		vel.x+=1
	if Input.is_action_pressed("ui_left"):
		vel.x-=1
	if Input.is_action_pressed("ui_a"):
		vel.x-=1
	if Input.is_action_pressed("ui_down"):
		vel.y+=1
	if Input.is_action_pressed("ui_s"):
		vel.y+=1
	
	if vel.length()>0:
		vel=vel.normalized()*speed
		$AnimatedSprite.play()
	else: $AnimatedSprite.stop()
	position+=vel*delta
	position.x=clamp(position.x,0,screensize.x)
	position.y=clamp(position.y,0,screensize.y)
	$AnimatedSprite.rotate(0.01)
	get_node("/root/main/Sprite").position=screensize/2
#	if vel.x!=0: 
#		$AnimatedSprite.animation="right"
#		$AnimatedSprite.flip_v= false	
#		$AnimatedSprite.flip_h= vel.x<0
#	elif vel.y!=0:
#		$AnimatedSprite.animation="up"
#		$AnimatedSprite.flip_v= vel.y>0
#		$AnimatedSprite.flip_h= false
	
	


func _on_player_body_entered(body):
	set_deferred("monitoring",false)
	hide()
	emit_signal("hit")
