function pkgObj.createSwallowTouchLayer(bgFn,onTouchEndFunc)
    local node = cc.Layer:create()
    if bgFn ~= nil then
        local bg = cc.Sprite:create(bgFn)
        bg:setPosition(480,320)
        node:addChild(bg,1)
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(function(touch,evt)
        return true
    end,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(function(touch,evt)
        end,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(function(touch,evt)
        if onTouchEndFunc ~= nil then
            onTouchEndFunc()
        end
        end,cc.Handler.EVENT_TOUCH_ENDED)
    local ed = node:getEventDispatcher()
    ed:addEventListenerWithSceneGraphPriority(listener,node)
    return node,listener
end