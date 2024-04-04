extends Node

var CutSceneCurrent = false

var playerMp = 3

var playerLVL = 1
var player_health = 10
var player_defense = 0
var player_damage = 5
var playerEXP = 0
var playerReqEXP = 10
####################Quest###############################
var quest1Accepted = false

func gainEXP(amount):
	playerEXP += amount
	if playerEXP >= playerReqEXP:
		#Level up
		playerReqEXP = playerReqEXP*1.2
		playerEXP = 0
		playerLVL += 1
	
