local Class = require("parley/util/class.lua")
local BaseClass = Class.BaseClass
local ClassLib = Class.ClassLib

local class_name = "ParleyAsset"
local Asset = (ClassLib and ClassLib.GetClassByName and ClassLib.GetClassByName(class_name)) or nil
if not Asset then
    Asset = BaseClass.Inherit(class_name)
end

function Asset:Constructor(opts)
    opts = opts or {}
    self.id = opts.id
    self.file = opts.file
    self.labels = {}
    self.order = {}
end

function Asset:EnsureLabel(label)
    if not self.labels[label] then
        self.labels[label] = { steps = {} }
        self.order[#self.order + 1] = label
    end
    return self.labels[label]
end

function Asset:AddStep(label, step)
    local node = self:EnsureLabel(label)
    node.steps[#node.steps + 1] = step
end

function Asset.New(opts)
    return Asset(opts)
end

return Asset