extends Area2D

@onready var timer = $Timer

func _physics_process(delta):
	var enemy_in_range2 = get_overlapping_bodies()
	if enemy_in_range2.size() > 0 :
		var target_enemy2 = enemy_in_range2.front()
		look_at(target_enemy2.global_position)


func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	shoot()


func _on_player_level_up():
	timer.wait_time = timer.wait_time /2
	if timer.wait_time <= 0.05:
		timer.wait_time == 0.05
