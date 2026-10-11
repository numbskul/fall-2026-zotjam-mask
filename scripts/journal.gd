extends CanvasLayer
class_name Journal

@onready var item_list: ItemList = $Control/Panel/Entries/ItemList
var entries: Dictionary[String, Array]

func add_entry(id: String) -> void:
	if (entries.get(id) != null):
		return;
	entries[id] = Dialogue_Contents.dialogues[id]
	refresh()

func _ready() -> void:
	item_list.item_activated.connect(_cross_out)
	refresh()

func _cross_out(index: int) -> void:
	var text := item_list.get_item_text(index)
	if "\u0336" in text:
		item_list.set_item_text(index, text.replace("\u0336", ""))
	else:
		var struck := ""
		for c in text:
			struck += c + "\u0336"
		item_list.set_item_text(index, struck)

func _unhandled_input(event: InputEvent) -> void:	
	if event is InputEventKey and event.pressed and event.keycode == KEY_J:
		visible = not visible

func refresh() -> void:
	item_list.clear()
	for e in entries:
		var content = entries[e]
		var text := content[1] as String + "\n —— " + (content[0] as String)
		item_list.add_item(text)
		var idx := item_list.item_count - 1
		item_list.set_item_custom_fg_color(
			idx,
			Color(0.6, 0.6, 0.6)
		)
