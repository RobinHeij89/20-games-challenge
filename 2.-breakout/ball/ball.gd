class_name Ball
extends RigidBody2D

const INITIAL_VEL = Vector2(-30,200)
var current_vel
var viewport
signal ball_destroyed
signal player_point

@onready var upStaticBody: StaticBody2D = %UpperWall

func _ready() -> void:
	viewport = get_viewport_rect()
	current_vel = INITIAL_VEL
	set_custom_position()
	pass

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(current_vel * delta)
	if collision:
		var random_x = randi() % 10
		var random_y = randi() % 10 - 5
		var extra = Vector2(random_x, random_y)
		var collider = collision.get_collider()
		var new_velo = Vector2.ZERO
		if collider is StaticBody2D:
			print(upStaticBody)
			if collider == upStaticBody:
				new_velo.x = current_vel.x + extra.x
				new_velo.y = -(current_vel.y + extra.y)
			else:
				new_velo.x = -(current_vel.x + extra.x)
				new_velo.y = current_vel.y + extra.y
		else:
			new_velo.x = current_vel.x + extra.x
			new_velo.y = -(current_vel.y + extra.y)
		current_vel = new_velo
	detect_point()

func detect_point():
	if self.position.y > viewport.size.y:
		ball_destroyed.emit()
		self.queue_free()

func set_custom_position():
	self.position = viewport.size/2
