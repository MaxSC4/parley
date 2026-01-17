local UIAdapterDefault = {}

function UIAdapterDefault.Create()
    local webui = WebUI("ParleyUI", "file://parley/Client/ui/parleyui/index.html", WidgetVisibility.Hidden, false)
    webui:SetVisibility(WidgetVisibility.Hidden)

    local current_session_id = nil
    local was_mouse_enabled = false

    local function enable_ui_input()
        if Input and Input.IsMouseEnabled and Input.SetMouseEnabled then
            was_mouse_enabled = Input.IsMouseEnabled()
            Input.SetMouseEnabled(true)
        end
    end

    local function restore_input()
        if Input and Input.SetMouseEnabled then
            Input.SetMouseEnabled(false)
        end
        if Input and Input.SetInputMode and InputMode then
            Input.SetInputMode(InputMode.GameOnly)
        end
    end

    webui:Subscribe("Parley:choose", function(choice_id)
        if current_session_id then
            Events.CallRemote("Parley:choose", current_session_id, choice_id)
        end
    end)

    webui:Subscribe("Parley:next", function()
        if current_session_id then
            Events.CallRemote("Parley:next", current_session_id)
        end
    end)

    webui:Subscribe("Parley:close", function()
        if current_session_id then
            Events.CallRemote("Parley:close", current_session_id)
        end
    end)

    return {
        show_line = function(session_id, speaker, text, meta)
            current_session_id = session_id
            webui:SetVisibility(WidgetVisibility.Visible)
            enable_ui_input()
            webui:CallEvent("Parley:show_line", speaker, text, meta or {})
        end,
        show_choices = function(session_id, choices)
            current_session_id = session_id
            webui:SetVisibility(WidgetVisibility.Visible)
            enable_ui_input()
            webui:CallEvent("Parley:show_choices", choices)
        end,
        hide = function(session_id)
            current_session_id = session_id
            webui:CallEvent("Parley:hide")
            webui:SetVisibility(WidgetVisibility.Hidden)
            restore_input()
        end
    }
end

return UIAdapterDefault

