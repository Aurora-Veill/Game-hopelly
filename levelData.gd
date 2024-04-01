extends Node
var random = RandomNumberGenerator.new()
var randomized = false
var runs = 0
var enemiesList = {
	1: ["res://Enemies/Diff1/enemy_1.tscn", "res://Enemies/Diff1/enemy_2.tscn", "res://Enemies/Diff1/enemy_3.tscn"]
}
var levelList = {
	0: "res://level_3.tscn",
#	1: "res://level_4.tscn"
}
func incrementRuns():
	runs += 1
func randomizeSeed():
	if !randomized:
		random.randomize()
		randomized = true
func getRanEnem(diff):
	var temp = randi() % enemiesList[diff].size()
	return enemiesList[diff][temp]
func getRanLevel():
	var temp = randi() % levelList.size()
	return levelList[temp]
