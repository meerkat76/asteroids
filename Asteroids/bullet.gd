extends CharacterBody2D

@export var direction: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = $VelocityComponent.move_in_direction(delta, direction)
	global_rotation = velocity.angle()
	move_and_slide()
	


func _on_hit_box_component_hitbox_entered(shape):
	if shape.type_name != "ship":
		queue_free()
