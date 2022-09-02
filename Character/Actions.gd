# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Reference

signal Nonexistent_Action_Name
signal Invalid_Action_Name

var Actions := Dictionary()

func _init(Act:=Dictionary()):
    var Names = Act.keys()
    for Name in Names:
        if typeof(Name) == TYPE_STRING and self.Name_Validated(Name):
            if typeof(Act[Name]) == TYPE_OBJECT:
                self.Actions[Name] = Act[Name]
            else:
                pass
        else:
            emit_signal("Invalid_Action_Name")
func Get(Name:String) -> Reference:
    if self.Name_Validated(Name):
        if self.Actions.has(Name):
            return self.Actions[Name]
        else:
            emit_signal("Nonexistent_Action_Name")
            return null
    else:
        emit_signal("Invalid_Action_Name")
        return null
func Set(Name:String,Agent:Object,Value:String):
    if self.Name_Validated(Name):
        if self.Actions.has(Name):
            if Agent.has_method(Value):
                self.Actions[Name] = funcref(Agent,Value)
        else:
            emit_signal("Nonexistent_Action_Name")
    else:
        emit_signal("Invalid_Action_Name")
func Add(Name:String):
    if self.Name_Validated(Name):
        if not Name in self.Actions.keys():
            self.Actions[Name] = null
    else:
        emit_signal("Invalid_Action_Name")
func List(Filter:=String()) -> Array:
    if Filter.empty():
        return self.Actions.keys()
    else:
        var result = Apply_Filter(Filter,self.Actions.keys())
        return result

#Service funtions
func Name_Validated(Name:String) -> bool:
    var regex = RegEx.new()
    regex.compile("\\d")
    var result = regex.search(Name)
    if not result:
        return true
    else:
        return false

func Apply_Filter(Filter:String,Names:Array) -> Array:
    var re = RegEx.new()
    var results := Array()
    re.compile(Filter)
    for Name in Names:
        var result = re.search(Name)
        if result: results.append(result.to_string())
    return results
