extends Area2D
var coin_Value :int = 1


func _ready():
	await get_tree().create_timer(20.0).timeout
	queue_free()
	


func _on_body_entered(body):
	if body.has_method("coin_picked_up"):
		body.coin_picked_up(coin_Value)
	queue_free()

