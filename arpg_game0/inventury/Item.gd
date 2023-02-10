extends TextureRect

var weapon_inventury=preload("res://inventury/weapons/Weapon_Inventury.tres")
var shield_inventury=preload("res://inventury/shield/Shield_Inventury.tres")
var shoes_inventury=preload("res://inventury/shoes/Shoes_Inventury.tres")
onready var tabcontainer=get_node("/root/world/CanvasLayer/InventuryUI/TabContainer")
# warning-ignore:unused_argument
func get_drag_data(position):
	var item_index=get_parent().get_index()
	var name0=tabcontainer.get_current_tab_control().name
	if name0=="weapon_container":
		var item=weapon_inventury.remove_item(item_index)
		if item is Item:
			var data={}
			data.item=item
			data.item_index=item_index
			var drag_preview=TextureRect.new()
			drag_preview.texture=texture
			set_drag_preview(drag_preview)
			weapon_inventury.drag_data=data
			return data
	elif name0=="shield_container":
		var item=shield_inventury.remove_item(item_index)
		if item is Item:
			var data={}
			data.item=item
			data.item_index=item_index
			var drag_preview=TextureRect.new()
			drag_preview.texture=texture
			set_drag_preview(drag_preview)
			shield_inventury.drag_data=data
			return data
	elif name0=="shoes_container":
		var item=shoes_inventury.remove_item(item_index)
		if item is Item:
			var data={}
			data.item=item
			data.item_index=item_index
			var drag_preview=TextureRect.new()
			drag_preview.texture=texture
			set_drag_preview(drag_preview)
			shoes_inventury.drag_data=data
			return data
