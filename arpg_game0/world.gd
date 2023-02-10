extends Node2D
var alpha=0
onready var label1=$CanvasLayer/Label2
onready var label2=$CanvasLayer/Label3
onready var label3=$CanvasLayer/Label4
onready var accept=$CanvasLayer/AcceptDialog2
func _ready():
	randomize()
	randomize()
	if $YSort/football_field.visible==false:
		$YSort/football_field.queue_free()
	if $tilemaps/pathTileMap.visible==false:
		$tilemaps/pathTileMap.queue_free()
	if $tilemaps/cliffTileMap.visible==false:
		$tilemaps/cliffTileMap.queue_free()
	if $YSort/"2048".visible==false:
		$YSort/"2048".queue_free()
	var dialogic=Dialogic.start("村长_first_born")
	dialogic.connect('dialogic_signal',self,"dialogic_end")
	add_child(dialogic)
	get_tree().paused=true


func _on_player_health_changed():
	pass # Replace with function body.

func dialogic_end(value):
	if value=="村长_first_born":
		accept.popup_centered()
	if value=="over":
		game_over()


func _on_InventuryUI_popup_hide():
	get_tree().paused=false
	pass # Replace with function body.


func _on_Shop_popup_hide():
	get_tree().paused=false
	pass # Replace with function body.

func game_over():
	$Timer.start()

func _on_Timer_timeout():
	alpha+=0.05
	$CanvasLayer/ColorRect.color=Color(0,0,0,alpha)
	$CanvasLayer/ColorRect.visible=true
	print(alpha)
	if alpha>=1:
		$Timer.stop()
		label1.show()
		label2.show()
		label3.show()
	pass # Replace with function body.


func _on_AcceptDialog2_confirmed():
	get_tree().paused=false
	pass # Replace with function body.
