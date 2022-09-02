# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Reference

var Characters := Dictionary()

func _init(characters:Dictionary):
    var CharactersNames = characters.keys()
    for Name in CharactersNames:
        self.Characters[Name] = characters[Name]
func Register(character:Reference):
    var Name = character.get_name()
    self.Characters[Name] = character
func Deregister(character:String):
    if self.Characters.erase(character):
        pass
    else:
        pass
func List(Filter:=String()) -> Array:
    if Filter.empty():
        return self.Characters.keys()
    else:
        return Apply_Filter(Filter,Characters.keys())
func _process(delta):
    for Name in self.Characters.keys():
        pass

#Service Functions
func Apply_Filter(Filter:String,Names:Array) -> Array:
    var re = RegEx.new()
    var results := Array()
    re.compile(Filter)
    for Name in Names:
        var result = re.search(Name)
        if result: results.append(result.to_string())
    return results
