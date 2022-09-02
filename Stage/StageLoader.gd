# Created on: 01  jul 2022
# Author: Francesco Antonetti Lamorgese Passeri
# Version: 1.0
# License: CC-BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

extends Node

var LoadingPercentage := float(0.0)
var LoadingText       := String("Loading...")
var Loader            = null
var stage             = null
var Loading           = bool(false)

func _init():
    set_process(false)

func SetStage(Stage: String) -> Node2D:
    stage = null
    if Stage != "":
        self.Loader = ResourceLoader.load_interactive(Stage)
        self.Loading = true
        set_process(true)
        while self.Loading:
            pass
    return stage

func _process(delta):
    var err = Loader.poll()
    if err == ERR_FILE_EOF:
        self.stage = self.Loader.get_resource()
        self.Loader = null
        set_process(false)
        self.Loading = false
    elif err == OK:
        var progress = (float(Loader.get_stage())/float(Loader.get_stage_count()))*100
        self.LoadingPercentage = progress
    else:
        Loader = null
        self.Loading = false
