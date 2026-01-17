local Log = {}

function Log.Info(msg)
    print("[Parley] " .. msg)
end

function Log.Warn(msg)
    print("[Parley] WARNING: " .. msg)
end

function Log.Error(msg)
    print("[Parley] ERROR: " .. msg)
end

return Log

