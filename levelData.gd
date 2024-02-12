extends Node
var random = RandomNumberGenerator.new()
var randomized = false
var enemiesList = {
	1: ["res://Enemies/Diff1/enemy_1.tscn"]
}
func randomizeSeed():
	if !randomized:
		random.randomize()
		randomized = true
func getRanEnem(diff):
	var temp = randi() % enemiesList[diff].size()
	return enemiesList[diff][temp]
