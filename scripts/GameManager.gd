extends Node

@export var player : CharacterBody2D
@export var MobSpawnerLimit : float = 0.5
@onready var mob_spawner_timer = %MobSpawnerTimer

var gameTime = 0
var minutes := 0
var boss_spawned := false

signal BossTime
signal minute_passed


func _process(delta):
	if boss_spawned == false:
		if player.level >= 2:
			if minutes >= 1:
				start_boss()

func start_boss():
	var Boss = preload("res://scenes/boss.tscn").instantiate()
	Boss.global_position = %BossSpawnPoint.global_position
	$"../mobs".add_child(Boss)
	Boss.add_to_group("Boss")
	$"../MobSpawnerTimer".stop()
	get_tree().call_group("Mobs", "queue_free")
	boss_spawned = true
	Boss.Boss_Died.connect(Boss_died_emitted)

func Boss_died_emitted():
	Spawning.reset()
	pass

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
