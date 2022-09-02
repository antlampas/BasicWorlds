# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Node

var CurrentStage  : Node = null
var PreviousStage : Node = null
var StagesChain   : Array
var StageLoader   : PackedScene
var Objects       : Dictionary
var Characters    : Dictionary
var Players       : Dictionary
var AIs           : Dictionary

func GetCurrentStageName()  -> String:  return "Implement"
func GetPreviousStageName() -> String:  return "Implement"
func SetCurrentStageName(Name:String):  pass
func SetPreviousStageName(Name:String): pass
func SwitchStage(Stage: String):        pass
