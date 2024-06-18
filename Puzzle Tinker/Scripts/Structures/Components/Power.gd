extends Node2D

signal send_power

func receive_power():
	send_power.emit()
