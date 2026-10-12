class_name Dialogue_Contents

static var dialogues = parse_dialogue_file()

static func parse_dialogue_file() -> Dictionary:
	var file = FileAccess.open("res://assets//Dialogues.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	var result = {}
	for entry in data["dialogues"]:
		result[entry["id"]] = [entry["name"], entry["dialogue"]]
	return result
