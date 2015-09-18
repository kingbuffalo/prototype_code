local mgr = {}
local tblu = require "src/utils/tblUtils"

local notfoundMt = {
    __index=function(t,k)
        print("tblLan not found:" .. k)
    end
}

function mgr._init()
    local arr = tblu.getAllTblVO("tblLan")
    mgr._data = {}
    for _,v in ipairs(arr)do
        mgr._data[v.fldStrKey] = v
    end
    setmetatable(mgr._data,notfoundMt)
end

function mgr.getTblLanVO(fldStrKey)
    if mgr._data == nil then
        mgr._init()
    end
    return mgr._data[fldStrKey]
end

function mgr.get(fldStrKey)
    return mgr.getTblLanVO(fldStrKey)
end

function mgr.gsubValueInStr(str,...)
    local args = {...}
    local string=string
    for i,v in ipairs(args) do
        str = string.gsub(str,"%(v"..i.."%)",v)
    end
    return str
end
function mgr.gsubValueInStrByArgs(str,args)
    local string=string
    for i,v in ipairs(args) do
        str = string.gsub(str,"%(v"..i.."%)",v)
    end
    return str
end

function mgr.showCmdCode(cmd,code,cmdRet)
    local key = cmd.."_"..code
    local tblLanVO = mgr.getTblLanVO(key)
    local str
    local tipArgs = cmdRet.tipArgs
    local tblEtcConst = require("src/eagleGame/tblEtcConst")
    if tblLanVO ~= nil then
        if tblLanVO.fldShowType == tblEtcConst.CMD_LAN_SHOW_TYPE_STR then
            str = tblLanVO.fldLan
        elseif tblLanVO.fldShowType == tblEtcConst.CMD_LAN_SHOW_TYPE_SUB_STR then
            str = mgr.gsubValueInStrByArgs(tblLanVO.fldLan,tipArgs)
        elseif tblLanVO.fldShowType == tblEtcConst.CMD_LAN_SHOW_TYPE_SUB_STR_ITEM then
            local itemNameArr = {}
            local tblItemsMgr = require("src/eagleGame/tblMgrs/tblItemsMgr")
            for i,v in ipairs(tipArgs) do
                local tblItemsVO = tblItemsMgr.getItemsVO_itemId(v)
                itemNameArr[i] = tblItemsVO.fldName
            end
            str = mgr.gsubValueInStrByArgs(tblLanVO.fldLan,itemNameArr)
        elseif tblLanVO.fldShowType > 100 then
            local showTypeStr = tostring(tblLanVO.fldShowType)
            local tblItemsMgr = require("src/eagleGame/tblMgrs/tblItemsMgr")
            local string = string
            local tonumber = tonumber
            local strLen = string.len(showTypeStr)
            local strArr = {}
            for i=1,strLen-1 do
                local eachDigStr = string.sub(showTypeStr,i,i)
                local eachDigInt = tonumber(eachDigStr)
                if eachDigInt == tblEtcConst.CMD_LAN_SHOW_TYPE_SUB_STR then
                    strArr[i] = tipArgs[i]
                elseif eachDigInt == tblEtcConst.CMD_LAN_SHOW_TYPE_SUB_STR_ITEM then
                    local tblItemsVO = tblItemsMgr.getItemsVO_itemId(tipArgs[i])
                    strArr[i] = tblItemsVO.fldName
                end
            end
            str = mgr.gsubValueInStrByArgs(tblLanVO.fldLan,strArr)
        end
    end
	if str ~= nil then
        local utilsFunc = require("src/utils/utilsFunc")
        utilsFunc.showTouchMsg(str)
    end
end

return mgr