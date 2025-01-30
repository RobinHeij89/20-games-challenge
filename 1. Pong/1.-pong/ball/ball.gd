class_name Ball
extends RigidBody2D

const INITIAL_VEL = Vector2(-300,20)
var current_vel
var viewport
signal ball_destroyed
signal cpu_point
signal player_point

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
		var extra = Vector2(random_x*10, random_y*10)
		var collider = collision.get_collider()
		var new_velo = Vector2.ZERO
		if collider is StaticBody2D and collider is not CPUPad:
			new_velo.x = current_vel.x + extra.x
			new_velo.y = -(current_vel.y + extra.y)
			current_vel = new_velo
		else:
			if current_vel.x > 0 :
				new_velo.x = -(current_vel.x + extra.x)
			else:
				new_velo.x = -(current_vel.x - extra.x)
			new_velo.y = current_vel.y + extra.y
			current_vel = new_velo
	detect_point()

func detect_point():
	if self.position.x < 0:
		ball_destroyed.emit()
		cpu_point.emit()
		self.queue_free()
	if self.position.x > viewport.size.x:
		ball_destroyed.emit()
		player_point.emit()
		self.queue_free()

func set_custom_position():
	self.position = viewport.size/2
