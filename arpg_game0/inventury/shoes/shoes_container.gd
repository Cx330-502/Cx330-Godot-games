extends GridContainer

var shoes_inventury=preload("res://inventury/shoes/Shoes_Inventury.tres")
signal equipment_changed

func _ready():
	shoes_inventury.connect("items_changed",self,"on_item_changed")
	for item_index in shoes_inventury.items.size():
		update_slot(item_index)


func update_slot(item_index):
	var slot=get_child(item_index)
	var item=shoes_inventury.items[item_index]
	slot.update_item(item)
	emit_signal("equipment_changed")

func on_item_changed(indexes):
	for item_index in indexes:
		update_slot(item_index)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			if shoes_inventury.drag_data is Dictionary:
				shoes_inventury.set_item(shoes_inventury.drag_data.item_index,shoes_inventury.drag_data.item)
