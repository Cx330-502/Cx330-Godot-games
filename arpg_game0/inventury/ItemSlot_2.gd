extends TextureRect

const ItemNode=preload("res://inventury/Item.tscn")
var shield_inventury=preload("res://inventury/shield/Shield_Inventury.tres")

func update_item(item):
	if item is Item:
		var item_node=ItemNode.instance()
		item_node.texture=item.texture
		add_child(item_node)
		modulate=Color(1,1,1,1)
	else:
		for current_item in get_children():
			current_item.queue_free()
		modulate=Color(1,1,1,0.5)


func can_drop_data(_position, data):
	return data as Dictionary and data.has("item")


func drop_data(_position, data):
	var my_item_index=get_index()
	var my_item=shield_inventury.items[my_item_index]
	shield_inventury.swap_items(my_item_index,data.item_index)
	shield_inventury.set_item(my_item_index,data.item)
	shield_inventury.drag_data=null
