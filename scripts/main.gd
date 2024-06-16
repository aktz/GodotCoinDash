extends Node2D

@export var coin_scene : PackedScene
@export var playtime = 30

var level = 1
var score = 0
var time_left = 0
var screensize = Vector2.ZERO
var playing = false


func _ready():
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()


func _process(delta):
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		time_left += 5
		seed_coins()


func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start()
	$Player.show()
	$Timer.start()
	seed_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)


func seed_coins():
	for i in level + 5:
		var coin = coin_scene.instantiate()
		add_child(coin)
		coin.screensize = screensize
		coin.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))


func _on_timer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left == 0:
		game_over()


func game_over():
	playing = false
	$Timer.stop()
	get_tree().call_group("coins", "queue_free")
	$HUD.show_game_over()
	$Player.die()


func _on_hud_start_game():
	new_game()


func _on_player_pick():
	score += 1
	$HUD.update_score(score)
