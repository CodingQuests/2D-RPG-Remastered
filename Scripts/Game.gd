extends Node


var playerHP = 5
var playerMp = 3

var playerLVL = 1

var playerEXP = 0
var playerReqEXP = 10

func gainEXP(amount):
	playerEXP += amount
	if playerEXP >= playerReqEXP:
		#Level up
		playerReqEXP = playerReqEXP*1.2
		playerEXP = 0
		playerLVL += 1
	
