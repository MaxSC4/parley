local BaseClass = _G.BaseClass
local ClassLib = _G.ClassLib

if not BaseClass then
    error("[Parley] ClassLib not available. Ensure the 'classlib' package is loaded via packages_requirements.")
end

return {
    BaseClass = BaseClass,
    ClassLib = ClassLib
}