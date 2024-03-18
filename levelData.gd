extends Node
var random = RandomNumberGenerator.new()
var randomized = false
var runs = 0
var enemiesList = {
	1: ["res://Enemies/Diff1/enemy_1.tscn", "res://Enemies/Diff1/enemy_2.tscn"]
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
	var temp = randi() % enemiesList.size()
	return enemiesList[temp]
