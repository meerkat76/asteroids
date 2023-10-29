extends Control

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_hp(hp):
	$CanvasLayer/HBoxContainer2/HP.text = str(hp)

func show_new_game():
	$CanvasLayer/GameOver.visible = true
	
func add_score(amt):
	score += amt
	$CanvasLayer/HBoxContainer/Score.text = str(score)
	
func _on_button_pressed():
	get_tree().root.get_node("World").new_game()
	$CanvasLayer/GameOver.visible = false
