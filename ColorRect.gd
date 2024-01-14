extends ColorRect

@export var dialogPath = ""
@export var textSpeed : float = 0.05

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
	
func _process(_delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)
	
func getDialog() -> Array:
	var f = FileAccess.open(dialogPath, FileAccess.READ)
	print("f ",f)
	assert(f.FileAccess.file_exists(dialogPath),"File path does not exist")
	
	f.open(dialogPath, f.READ)
	print("f2",f)
	var json = f.get_as_text()
	print("json ",json)
	var json_object = JSON.new()
	print("json_object", json_object)
	json_object.parse(json)
	var output = json_object.data
	print("output ", output)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Text.bbcode_text = dialog[phraseNum]["Text"]	
	
	$Text.visible_characters += 1
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		await $Timer.timeout
	
	finished = true
	phraseNum += 1
	return
