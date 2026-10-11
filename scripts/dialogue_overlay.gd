extends Control

@onready var mad_talk_runtime: Node = $MadTalkRuntime

signal dialog_finished(sheet_name : Variant, sequence_id : Variant)

func start(dialog_id : String) -> void:
	mad_talk_runtime.start_dialog(dialog_id)

func continue_dialog() -> void:
	mad_talk_runtime.dialog_acknowledge()

func abort() -> void:
	mad_talk_runtime.dialog_abort()

func _on_mad_talk_runtime_dialog_finished(sheet_name: Variant, sequence_id: Variant) -> void:
	emit_signal("dialog_finished", sheet_name, sequence_id)
