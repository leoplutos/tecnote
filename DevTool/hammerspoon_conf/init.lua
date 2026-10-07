--------------------------------------------------
-- Hammerspoon 配置
--------------------------------------------------

--------------------------------------------------
-- 1. 鼠标按键配置
--------------------------------------------------

local eventtap = hs.eventtap
local timer = hs.timer
local spaces = hs.spaces

local types = eventtap.event.types
local props = eventtap.event.properties

-- 单击等待定时器
local singleClickTimer = nil

-- 使用 macOS 系统的双击间隔
local doubleClickInterval = eventtap.doubleClickInterval()

-- 使用全局变量保存鼠标监听器，避免被 Lua 垃圾回收
mouseTap = eventtap.new({
    types.otherMouseDown
}, function(event)

    -- 获取鼠标按钮编号
    local button = event:getProperty(
        props.mouseEventButtonNumber
    )

    --------------------------------------------------
    -- 鼠标中键：Button 2
    --
    -- 单击 → Mission Control（显示所有窗口）
    -- 双击 → App Exposé（显示当前应用的所有窗口）
    --------------------------------------------------

    if button == 2 then

        local clickCount = event:getProperty(
            props.mouseEventClickState
        )

        -- 双击
        if clickCount == 2 then

            -- 取消第一次点击等待触发的单击操作
            if singleClickTimer then
                singleClickTimer:stop()
                singleClickTimer = nil
            end

            spaces.toggleAppExpose()

            return true
        end

        -- 单击
        if clickCount == 1 then

            -- 清理可能残留的定时器
            if singleClickTimer then
                singleClickTimer:stop()
                singleClickTimer = nil
            end

            -- 等待系统双击间隔。
            -- 如果没有第二次点击，则执行 Mission Control。
            singleClickTimer = timer.doAfter(
                doubleClickInterval,
                function()
                    spaces.toggleMissionControl()
                    singleClickTimer = nil
                end
            )

            return true
        end
    end

    --------------------------------------------------
    -- 鼠标侧键 1
    --
    -- Hammerspoon Button 3
    -- → Mission Control
    --------------------------------------------------

    if button == 3 then
        spaces.toggleMissionControl()
        return true
    end

    --------------------------------------------------
    -- 鼠标侧键 2
    --
    -- Hammerspoon Button 4
    -- → App Exposé
    --------------------------------------------------

    if button == 4 then
        spaces.toggleAppExpose()
        return true
    end

    -- 其他鼠标按钮不拦截
    return false
end)

-- 启动鼠标事件监听
mouseTap:start()


--------------------------------------------------
-- 2. Leader 快捷键模式
--
-- Shift + Space
--
-- 按下 Shift + Space 后进入快捷键模式，
-- 再按一个字母执行对应操作。
--------------------------------------------------

launcher = hs.hotkey.modal.new(
    {"shift"},
    "space"
)


--------------------------------------------------
-- Shift + Space → V
-- 打开 / 切换到 VS Code
--------------------------------------------------

launcher:bind({}, "v", function()
    launcher:exit()
    hs.application.launchOrFocus("Visual Studio Code")
end)


--------------------------------------------------
-- Shift + Space → F
-- 打开 / 切换到 Finder
--------------------------------------------------

launcher:bind({}, "f", function()
    launcher:exit()
    hs.application.launchOrFocus("Finder")
end)


--------------------------------------------------
-- Shift + Space → G
-- 打开 / 切换到 Ghostty
--------------------------------------------------

launcher:bind({}, "g", function()
    launcher:exit()
    hs.application.launchOrFocus("Ghostty")
end)


--------------------------------------------------
-- Shift + Space → C
-- 打开 / 切换到 Claude Code
--------------------------------------------------

launcher:bind({}, "c", function()
    launcher:exit()
    hs.application.launchOrFocus("Claude")
end)


--------------------------------------------------
-- Shift + Space → Esc
-- 取消 Leader 快捷键模式
--------------------------------------------------

launcher:bind({}, "escape", function()
    launcher:exit()
end)


--------------------------------------------------
-- 进入 Leader 模式时显示操作提示
--------------------------------------------------

function launcher:entered()
    hs.alert.show(
        "V  VS Code\n" ..
        "F  Finder\n" ..
        "G  Ghostty\n" ..
        "C  Claude"
    )
end


--------------------------------------------------
-- 配置加载完成提示
--------------------------------------------------

hs.alert.show("Hammerspoon 配置已加载")
