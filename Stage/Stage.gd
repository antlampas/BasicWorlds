# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Node2D

signal Object_exists
signal Character_exists
signal Player_exists
signal AI_exists

var Position   : Vector2
var Size       : Vector2
var Objects    : Dictionary
var Characters : Dictionary
var Players    : Dictionary
var AIs        : Dictionary
var Envi       : Env

func GetTree() -> Node:
    return get_node_or_null(get_path())
func GetObjects() -> Array:
    return self.Objects.keys()
func GetCharacters() -> Array:
    return self.Characters.keys()
func GetPlayers() -> Array:
    return self.Players.keys()
func GetAIs() -> Array:
    return self.AIs.keys()
func GetName() -> String:
    return self.name
func GetSize() -> Vector2:
    return self.Size
func GetPosition() -> Vector2:
    return self.Position
func GetEnvironment() -> Dictionary:
    return Dictionary() #TODO: implement Environment first
func SetName(name:String):
    self.name = name
func SetSize(size:Vector2):
    self.Size = size
func SetPosition(position:Vector2):
    self.Position = position
func SetEnvironment(environment:Dictionary):
    return Dictionary() #TODO: implement Environment first
func AddObject(object:Node):
    if not object.name in self.Objects.keys():
        self.Objects[object.name] = object
    else:
        emit_signal("Object_exists")
func AddCharacter(character:Node):
    if not character.GetName() in self.Characters.keys():
        self.Characters[character.GetName()] = character
    else:
        emit_signal("Character_exists")
func AddPlayer(player:Node):
    if not player.GetName() in self.Players.keys():
        self.Players[player.GetName()] = player
    else:
        emit_signal("Player_exists")
func AddAI(ai:Node):
    if not ai.GetName() in self.AIs.keys():
        self.AIs[ai.GetName()] = ai
    else:
        emit_signal("AI_exists")
