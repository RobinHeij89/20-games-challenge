class_name CPUPad
extends StaticBody2D

@export var ball: Ball
const SPEED = 80
var viewport

func _ready():
	viewport = get_viewport_rect()


func _physics_process(delta: float) -> void:
	if ball:
		var destination = Vector2(global_position.x, ball.global_position.y)
		destination.y = min(destination.y, viewport.size.y-30)
		destination.y = max(destination.y, 30)
		position = position.move_toward(destination, delta * SPEED)
