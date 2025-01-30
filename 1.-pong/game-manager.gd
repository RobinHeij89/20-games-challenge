class_name GameManager
extends Node2D

var cpu_points: int = 0
var player_points: int = 0
@onready var background = %Background
@onready var score_player = %ScorePlayer
@onready var score_cpu = %ScoreCPU
@onready var ball = %Ball
@onready var pad_player = %PlayerPad
@onready var pad_cpu = %CPUPad

var ball_scene = preload("res://ball/ball.tscn")

func _ready() -> void:
	ball.ball_destroyed.connect(spawn_new_ball)
	ball.player_point.connect(add_point_to_player)
	ball.cpu_point.connect(add_point_to_cpu)

func spawn_new_ball():
	var instance = ball_scene.instantiate()
	instance.ball_destroyed.connect(spawn_new_ball)
	instance.player_point.connect(add_point_to_player)
	instance.cpu_point.connect(add_point_to_cpu)
	add_child(instance)
	pad_cpu.ball = instance

func add_point_to_player():
	player_points = player_points + 1
	score_player.text = "[center]"+str(player_points)+"[/center]"

func add_point_to_cpu():
	cpu_points = cpu_points + 1
	score_cpu.text = "[center]"+str(cpu_points)+"[/center]"
