extends Node2D
var score = 0
var PAUSED = false

@onready var mob_spawner_timer = $MobSpawnerTimer

@onready var game_timer = $GameTimer


signal minute_passed

func _ready():
	%GameOver.hide()
	get_tree().paused = false
	spawn_mob()
	spawn_mob()
	game_timer.start()

func _process(delta):
	if PAUSED == false:
		if Input.is_action_pressed("pause"):
			get_tree().paused = true
			PAUSED = true
			$CanvasLayer2/Options_menu.show()
	if PAUSED == true:
		if Input.is_action_pressed("pause"):
			get_tree().paused = false
			PAUSED = false
			$CanvasLayer2/Options_menu.hide()

func spawn_mob():
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	$mobs.add_child(new_mob)
	new_mob.add_to_group("Mobs")

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	%GameOver.show()
	get_tree().paused = true

func _on_button_pressed():
	%GameOver.hide()
	get_tree().paused = false
	Spawning.reset()
	get_tree().reload_current_scene()

func _on_coin_coin_taken(amount):
	score += amount
