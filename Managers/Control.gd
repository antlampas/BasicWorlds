# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Reference

signal Agent_registered
signal Agent_not_registered
signal Agent_doesnt_exist
signal Agent_deregistered

signal Input_registered
signal Input_not_registered
signal Input_doesnt_exist
signal Input_deregistered

var Agents := Dictionary()
var Inputs := Dictionary()

func _init(A:=Dictionary(),I=Dictionary()):
    for Name in A.keys():
        self.Agents[Name] = A[Name]
    for Name in I.keys():
        if Name[0] in self.Agents.keys():
            self.Inputs[Name] = I[Name]
        else:
            emit_signal("Agent_not_registered")
func RegisterAgent(name:String,agent:Reference):
    if name == agent.get_name():
        self.Agents[name] = agent
        emit_signal("Agent_registered")
    else:
        emit_signal("Agent_not_registered")
func DeregisterAgent(name:String):
    if name in self.Agents.keys():
        for key in self.Inputs.keys():
            if key.find(name) >= 0:
                self.Inputs.erase(key)
                emit_signal("Input_deregistered")
        self.Agents.erase(name)
        emit_signal("Agent_deregistered")
    else:
        emit_signal("Agent_doesnt_exist")
func RegisterInput(input:String,agent:String,event:String):
    if agent in self.Agents.keys():
        if not InputMap.has_action(input):
            InputMap.add_action(input)
            var Event = funcref(self.Agent.get(event),event)
            if Event != null:
                self.Inputs[input] = [agent,event]
                emit_signal("Input_registered")
            else:
                emit_signal("Input_not_registered")
        else:
            emit_signal("Input_doesnt_exist")
    else:
        emit_signal("Agent_doesnt_exist")
func DeregisterInput(input:String):
    if input in self.Inputs.keys():
        if InputMap.has_action(input):
            InputMap.erase_action(input)
        if input in Inputs.keys():
            self.Inputs.erase(input)
func _input(event):
    #This is Control Loop in the diagram
    if event.as_text() in self.Inputs.keys():
        (self.Inputs[event])[1].call_func()
