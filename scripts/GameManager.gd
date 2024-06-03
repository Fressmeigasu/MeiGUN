extends Node

@export var player : CharacterBody2D
@export var maingame : Node2D

signal BossTime

func start_boss():
	if player.level >= 2:
		if maingame.minutes >= 1:
			BossTime.emit()


func _on_game_minute_passed():
	start_boss()
