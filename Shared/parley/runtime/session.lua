local Class = require("parley/util/class.lua")
local BaseClass = Class.BaseClass
local ClassLib = Class.ClassLib

local class_name = "ParleySession"
local Session = (ClassLib and ClassLib.GetClassByName and ClassLib.GetClassByName(class_name)) or nil
if not Session then
    Session = BaseClass.Inherit(class_name)
end

function Session:Constructor(id, player, asset, opts)
    local entry = "start"
    if opts and opts.entry then
        entry = opts.entry
    end
    self.id = id
    self.player = player
    self.asset = asset
    self.label = entry
    self.index = 1
    self.waiting_choices = nil
    self.opts = opts or {}
end

function Session.New(id, player, asset, opts)
    return Session(id, player, asset, opts)
end

return Session