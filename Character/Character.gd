# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Node2D

signal Non_existent_Feature

var Experience : int
var Level      : int
var Size       : Vector2
var Features   : Dictionary
var Player     : bool

func _init(name:=String("Character"),experience:=0,level:=1,size:=Vector2(),features:=Dictionary(),player:=false):
    self.name       = name
    self.Experience = experience
    self.Level      = level
    self.Size       = size
    self.Features   = features
    self.Player     = player
func GetName() -> String:
    return self.name
func GetPosition() -> Vector2:
    return self.position
func GetSize() -> Vector2:
    return self.Size
func GetLevel() -> int:
    return self.Level
func GetExperience() -> int:
    return self.Experience
func GetFeature(Name:String) -> Resource:
    if Name in self.Features.keys():
        return self.Features[Name]
    else:
        emit_signal("Non_existent_Feature")
        return null
func GetTree() -> Node:
    return self
func IsPlayer() -> bool:
    return Player
func AddExperience(Points:int):
    self.Experience += Points
func ListFeatures(Filter:=String()) -> Array:
    if Filter.empty():
        return self.Features.keys()
    else:
        return self.Apply_Filter(Filter,self.Features.keys())
func SetLevel(L:int):
    self.Level = L
func SetName(Name:String):
    self.name = Name
func SetSize(S:Vector2):
    self.Size = S

#Service functions
func Apply_Filter(Filter:String,Names:Array) -> Array:
    var re = RegEx.new()
    var results := Array()
    re.compile(Filter)
    for Name in Names:
        var result = re.search(Name)
        if result: results.append(result.to_string())
    return results
