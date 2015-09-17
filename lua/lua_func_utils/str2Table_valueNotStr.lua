local lookuptable = { [":"] = "=",["["] = "{",["]"] = "}",["\""]="",["("]="[",[")"]="]",}
local function replaceIntKey(s1)
    return "("..s1.."):"
end

function str2Table(retStr)
    local contentStr = retStr
    local bHasStr = false
    local string=string
    local tonumber = tonumber
    contentStr = string.gsub(contentStr,"\"(%d+)\":",replaceIntKey)
    contentStr = string.gsub(contentStr,"[\":%[%]%(%)]",lookuptable)
    local tempTable = { "do local _=",contentStr," return _ end" }
    contentStr =  table.concat(tempTable,"\n")
    local serpent= require("src/utils/serpent")
    local ok,jsonObj= serpent.load(contentStr)
    if ok ~= true then
        print(ok)
    end
    assert(ok,ok)
    return jsonObj
end