extends Area2D

var screensize = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	pass

func picked():
	$CollisionShape2D.set_deferred("disabled", true)
	var tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "scale", scale * 2, 0.3)
	tw.tween_property(self, "modulate:a", 0.0, 0.3)
	await tw.finished
	queue_free()

func _on_timer_timeout():
	queue_free()
