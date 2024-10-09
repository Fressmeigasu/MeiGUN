extends Node

@export var GunTimer : Timer
@export var MobSpawner : Timer
@export var player : CharacterBody2D
@export var GunSpeed : float
@export var MobSpawnerSpeed : float
@export var MaxHealthLimit : int


func _process(_delta):
	#GunSpeed = GunTimer.wait_time
	MobSpawnerSpeed = MobSpawner.wait_time
	MaxHealthLimit = player.max_health
