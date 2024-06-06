extends Node2D
var score = 0
var PAUSED = false

@onready var mob_spawner_timer = $MobSpawnerTimer

@onready var game_timer = $GameTimer
var gameTime = 0
var minutes := 0
@export var MobSpawnerLimit : float = 0.5

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

func _on_game_timer_timeout():
	gameTime += 1
	if gameTime == 60:
		mob_spawner_timer.wait_time /= 2
		gameTime = 0
		minutes += 1
		if mob_spawner_timer.wait_time < MobSpawnerLimit:
			mob_spawner_timer.wait_time = MobSpawnerLimit
		var format_string = "il s'est ecouler %s minutes"
		var minute_string = format_string % str(minutes)
		print(minute_string)
		minute_passed.emit()
		#get_tree().call_group("Mobs", "queue_free")
		#get_tree().call_group("Coins", "queue_free")
	print("gameTimer = " + str(gameTime))

func _on_game_manager_boss_time():
	var Boss = preload("res://scenes/boss.tscn").instantiate()
	Boss.global_position = $BossSpawnPoint.global_position
	$mobs.add_child(Boss)
	Boss.add_to_group("Boss")
	$MobSpawnerTimer.stop()
	get_tree().call_group("Mobs", "queue_free")
