extends Area2D


func _physics_process(delta):
	var enemy_in_range = get_overlapping_bodies()
	if enemy_in_range.size() > 0 :
		var target_enemy = enemy_in_range.back()
		look_at(target_enemy.global_position)


func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShotShootingPoint.global_position
	new_bullet.global_rotation = %ShotShootingPoint.global_rotation
	%ShotShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	shoot()
