extends Node3D

const pause_screen = preload("res://Menus/menu.tscn")
const PORT = 9999
const Player = preload("res://Player.tscn")
var enet_peer = ENetMultiplayerPeer.new()

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		var pause_menu = pause_screen.instantiate()
		add_child(pause_menu)
		


func _on_host_pressed():
	$Multiplayer_Menu.hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	add_player(multiplayer.get_unique_id())
	
	upnp_setup()
	
func _on_join_pressed():
	$Multiplayer_Menu.hide()
	enet_peer.create_client($Multiplayer_Menu/VBoxContainer/Address_Line.text, PORT)
	multiplayer.multiplayer_peer = enet_peer
	
func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	
func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()
	
func upnp_setup():
	var upnp = UPNP.new()
	
	var discover_result = upnp.discover()
	assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, "UPNP Discover Failed Error %s" % discover_result)
	assert(upnp.get_gateway() and upnp.get_gateway().is_valid_gateway(), "UPNP Invalid Gateway")
	
	var map_result = upnp.add_port_mapping(PORT)
	assert(map_result  == UPNP.UPNP_RESULT_SUCCESS, "UPNP Port Mapping Failed! Error %s" % map_result)
	
	print("Success! Join Address: %s", upnp.query_external_address())


func _on_single_player_pressed():
	$Multiplayer_Menu.hide()
	var player = Player.instantiate()
	add_child(player)
	
