extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus

func _on_start_button_pressed():
	get_tree().change_scene()

func _on_option_button_pressed():
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit()
