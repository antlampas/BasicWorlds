# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Reference

signal Nonexistent_Statistics_Name
signal Invalid_Statistics_Name

var Statistics : Dictionary

func _init(S:=Dictionary()):
    var Names = S.keys()
    for Name in Names:
        if typeof(Name) == TYPE_STRING and self.Name_Validated(Name):
            if typeof(S[Name]) == TYPE_INT:
                self.Statistics[Name] = S[Name] 
func Get(Name:String) -> int:
    if self.Name_Validated(Name):
        if Name in self.Statistics.keys():
            return self.Statistics[Name]
        else:
            emit_signal("Nonexistent_Statistics_Name")
            return -1
    else:
        emit_signal("Invalid_Statistics_Name")
        return -1
func Set(Name:String,Value:int):
    if self.Name_Validated(Name):
        if Name in self.Statistics.keys():
            self.Statistics[Name] = Value
        else:
            emit_signal("Nonexistent_Statistics_Name")
    else:
        emit_signal("Invalid_Statistics_Name")
func Add(Name:String):
    if self.Name_Validated(Name):
        if not Name in self.Statistics.keys():
            self.Statistics[Name] = -1
    else:
        emit_signal("Invalid_Statistics_Name")
func List(Filter:=String()) -> Array:
    if Filter.empty():
        return self.Statistics.keys()
    else:
        var result = Apply_Filter(Filter,self.Statistics.keys())
        return result

#Service functions
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
