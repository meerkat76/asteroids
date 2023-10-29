@tool
extends Node2D

@export var velocity: Vector2 = Vector2.ZERO
@export var current_velocity: float = 0.0
@export var max_velocity: float = 10.0
@export var acceleration: float = 0.5
@export var decceleration: float = 1.0
@export var direction: Vector2 = Vector2(0.0, -1.0)

var steering_velocity: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_in_direction(delta, dir:Vector2):
	velocity = dir * max_velocity * delta
	return velocity
	
func accelerate_max_velocity(delta, steering_dir=0.0):
	
	steering_velocity = Vector2(max_velocity, 0) * acceleration
	var final_steering_velocity = Vector2(steering_velocity.x, 0).rotated(steering_dir)
	velocity += final_steering_velocity * delta
	velocity = Vector2(clamp(velocity.x, -max_velocity, max_velocity), clamp(velocity.y, -max_velocity, max_velocity))
	
	return velocity
		
