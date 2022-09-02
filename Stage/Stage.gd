# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Node2D

var Position   : Vector2
var Size       : Vector2
var Objects    : Dictionary
var Characters : Dictionary
var Players    : Dictionary
var AIs        : Dictionary
var Envi       : Env

func GetTree() -> Node:
    return null
func GetObjects() -> Dictionary:
    return Dictionary()
func GetCharacters() -> Dictionary:
    return Dictionary()
func GetPlayers() -> Dictionary:
    return Dictionary()
func GetAIs() -> Dictionary:
    return Dictionary()
func GetName() -> String:
    return ""
func GetSize() -> Vector2:
    return Vector2()
func GetPosition() -> Vector2:
    return Vector2()
func GetEnvironment() -> Dictionary:
    return Dictionary()
func SetName(name:String):
    return ""
func SetSize(size:Vector2):
    return Vector2()
func SetPosition(position:Vector2):
    return Vector2()
func SetEnvironment(environment:Dictionary):
    return Dictionary()
func AddObject(object:Node):
    return null
func AddCharacter(Character:Node):
    return null
func AddPlayer(player:Node):
    return null
func AddAI(AI:Node):
    return null
