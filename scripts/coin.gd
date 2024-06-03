extends Area2D
var amount = 1
signal coin_taken(amount)

func _on_body_entered(body):
	if body.has_method("coin_picked_up"):
		body.coin_picked_up()
		coin_taken.emit(amount)
	queue_free()
