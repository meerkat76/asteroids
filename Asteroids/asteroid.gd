extends CharacterBody2D
class_name Asteroid

@export var direction: Vector2 = Vector2(-1, 1)
var ui

# Called when the node enters the scene tree for the first time.
func _ready():
	ui = get_tree().root.get_node("World").find_child("UI")
	print(ui)
	$HitBoxComponent.connect("damage_taken", take_damage)
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	velocity = $VelocityComponent.move_in_direction(delta, direction)

	position.x = wrapf(position.x, 0, get_viewport().size.x)
	position.y = wrapf(position.y, 0, get_viewport().size.y)
	
	move_and_slide()

func take_damage(dmg):
	if dmg.type_name == "bullet":
		$HealthComponent.take_damage(dmg.damage)


func _on_health_component_death():
	
	ui.add_score(10)  
	
	for i in range(2):
		var asteroid_duplicate = duplicate()
		#asteroid_duplicate.direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
		asteroid_duplicate.scale /= 2.0
		get_tree().root.get_node("World").find_child("Asteroids").call_deferred("add_child", asteroid_duplicate)
		
	queue_free()
		
