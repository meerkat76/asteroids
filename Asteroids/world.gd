extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func new_game():
	var asteroid_scene = load("res://asteroid.tscn")
	var ui = get_tree().root.get_node("World").find_child("UI")
	var nodes = get_children()
	
	for n in $Asteroids.get_children():
		if n is Asteroid:
			n.queue_free()
			
	for a in range(3):
		var asteroid = asteroid_scene.instantiate()
		asteroid.position = Vector2(randf_range(10, get_viewport().size.x), randf_range(10, get_viewport().size.y))
		$Asteroids.add_child(asteroid)
	
	get_tree().root.get_node("World").find_child("Ship").health.health = 5
	ui.score = 0
	ui.add_score(0)
	ui.update_hp(5)
