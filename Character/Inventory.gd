# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Reference

signal Nonexistent_Item_Name
signal Invalid_Item_Name
signal Invalid_Volume
signal Invalid_Weight
signal Limits_Exceeded
signal Not_Enough_In_Inventory

var Items         := Dictionary()
var MaximumWeight := int(0)
var MaximumVolume := int(0)
var ItemsWeight   := int(0)
var ItemsVolume   := int(0)

func _init(I:=Dictionary(),MW:=int(1),MV:=int(1)):
    self.MaximumVolume = MV
    self.MaximumWeight = MW
    var Names = I.keys()
    for Name in Names:
        if typeof(Name) == TYPE_STRING and self.Name_Validated(Name):
            self.Items[Name] = I[Name]
            self.ItemsWeight += I[Name][0].GetWeight()
            self.ItemsVolume += I[Name][0].GetVolume()
        else:
            emit_signal("Invalid_Emotion_Name")
func Get(Name:=String()):
    if self.Items.has(Name):
        var Item = Items[Name]
        print(Item[0])
        return Item[0]
    else:
        return null
func Add(Name:=String(),Item:=Reference,Quantity:=int(1)):
    if (self.ItemsWeight + (Item.GetWeight()*Quantity) < self.MaximumWeight) and (self.ItemsVolume + (Item.GetVolume()*Quantity) < self.MaximumVolume):
        if (Name in self.Items.keys()):
            self.Items[Name][1] += Quantity
        else:
            self.Items[Name] = [Item,Quantity]
    else:
        emit_signal("Limits_Exceeded")
func Remove(Name:=String(),Quantity:=int(1)):
    if Name in self.Items.keys():
        if self.Items[Name][1] - Quantity == 0:
            self.ItemsVolume -= self.Items[Name][0].GetVolume()*Quantity
            self.ItemsWeight -= self.Items[Name][0].GetWeight()*Quantity
            self.Items.erase(Name)
        elif self.Items[Name][1] - Quantity < 0:
            emit_signal("Not_Enough_In_Inventory")
        else:
            self.ItemsVolume -= self.Items[Name][0].GetVolume()*Quantity
            self.ItemsWeight -= self.Items[Name][0].GetWeight()*Quantity
            self.Items[Name][1] -= Quantity
func List(Filter:=String()):
    if Filter.empty():
        return self.Items.keys()
    else:
        var result = Apply_Filter(Filter,self.Items.keys())
        return result
func GetMaximumWeight()->int:
    return MaximumWeight
func GetMaximumVolume()->int:
    return MaximumVolume
func SetMaximumVolume(Volume:int):
    if Volume > 0:
        self.MaximumVolume = Volume
    else:
        emit_signal("Invalid_Volume")
func SetMaximumWeight(Weight:int):
    if Weight > 0:
        self.MaximumWeight = Weight
    else:
        emit_signal("Invalid_Weight")

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
