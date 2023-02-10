extends AcceptDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_button("No!",true,"no_pressed")


func _on_NPC_boy_first_dialogic_over():
	popup_centered()
	pass # Replace with function body.


func _on_NPC_boy_over():
	hide()
	pass # Replace with function body.
