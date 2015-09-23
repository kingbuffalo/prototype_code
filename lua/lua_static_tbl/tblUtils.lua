local pkgObj = {}
local serpent = require "src/utils/serpent"
local utilsFunc = require "src/utils/utilsFunc"
local t = 0
local cacheCountMax = 16
pkgObj.mtCahche = { }

local allMt = {
    __index=function(t,k)
        local mtKey = t.mt
        if mtKey ~= nil then
            local idx = mtKey[k]
            if idx ~= nil then
                if idx > 0 and idx <= #t then
                    return t[idx]
                end
            end
        end
        if not(k=="prev" and t.tbl == "tblJJCRankGift") then
            print(t.tbl.."fldNameNotFound:",k)
            assert(false)
        end
    end,
}

local function getMt(tblName)
    local mt = pkgObj.mtCahche[tblName]
    return mt
end

local function wrapVO(allTblVO,idx) 
    local tblVO = allTblVO.data[idx]
    tblVO.tbl = allTblVO.tbl
    tblVO.mt = getMt(allTblVO.tbl)
    setmetatable(tblVO,allMt)
    return tblVO
end

local function getTableFormFile(fn)
    t = t+1
    print("read tbl file->" .. t .. " : "..fn)
    local updcfg = require "src/utils/utilsProDifCfg"
    local tblPath = updcfg.res.tblPath
    local fileName = tblPath..fn..".tbl"
    local fp = assert(io.open(fileName,"r"))
    local allStr = fp:read("*all")
    fp:close()
    local ok,allTblVO = serpent.load(allStr)
    allTblVO.tbl = fn
    if pkgObj.mtCahche[fn] == nil then
        local mt = {}
        for i,v in ipairs(allTblVO.fldNames) do
            mt[v] = i
        end
        pkgObj.mtCahche[fn] = mt
    end
    if ok then
        return allTblVO
    end
    local msg = fn.." load error"
    print(msg)
    return nil
end

function pkgObj.getAllTblVO(fn)
    local dataCfg = pkgObj.getTableVO(fn)
    local ret={}
    local head = dataCfg.fldNames
    local setmetatable = setmetatable
    for i,v in ipairs(dataCfg.data)do
        v.tbl = fn
        v.mt= getMt(fn)
        setmetatable(v,allMt)
        ret[i] = v
    end
    return ret
end


---[[ need cache or not
--使用一个link style 式的 list
--在获取的同时，会将当前的至为第一位
--并删除过长的
--]]
function pkgObj.getTableVO(fn)
    if pkgObj.cacheTbl == nil then
        pkgObj.cacheTbl = {head=nil}
    end
    local iterator = pkgObj.cacheTbl.head
    local iteratorPrev = iterator
    local allTblVO = nil
    while iterator ~= nil do
        if iterator.name == fn then
            if iteratorPrev ~= iterator then
                iteratorPrev.nextTbl = iterator.nextTbl
                iterator.nextTbl = pkgObj.cacheTbl.head
                pkgObj.cacheTbl.head = iterator
            end
            allTblVO = iterator.allVO
            break
        end
        iteratorPrev = iterator
        iterator = iterator.nextTbl
    end
    if allTblVO == nil then
        allTblVO=getTableFormFile(fn)
        local headObj = {
            nextTbl = pkgObj.cacheTbl.head,
            name = fn,
            allVO = allTblVO,
        }
        pkgObj.cacheTbl.head = headObj

        local cacheTbl = pkgObj.cacheTbl.head
        local cacheCount = 0
        while cacheTbl ~= nil do
            cacheCount = cacheCount + 1
            if cacheCount > cacheCountMax then
                cacheTbl.nextTbl = nil
                break
            end
            cacheTbl = cacheTbl.nextTbl
        end
    end
    return allTblVO
end

local function cmpFunc3(allTblVO,mid,keyIdx,key2Idx,key3Idx,v1,v2,v3)
    local arr = allTblVO.data
    local tblVO = arr[mid]
    if tblVO[keyIdx] > v1 then
        return 1
    elseif tblVO[keyIdx] < v1 then
        return -1
    else
        if tblVO[key2Idx] > v2 then
            return 1
        elseif tblVO[key2Idx] < v2 then
            return -1
        else
            if tblVO[key3Idx] > v3 then
                return 1
            elseif tblVO[key3Idx] < v3 then
                return -1
            else
                return 0
            end
        end
    end
end

local function binarySearchOne3(allTblVO,ba,v1,v2,v3,boy)
    local low=1
    local height=allTblVO.len
    local mid = boy.number2Int((low+height)*0.5)
    local keyFldName = allTblVO.keyFlds[1]
    local keyFldName2 = allTblVO.keyFlds[2]
    local keyFldName3 = allTblVO.keyFlds[3]
--    local keyIdx = utilsFunc.searchArrIdx(allTblVO.fldNames,keyFldName)
--    local keyIdx2 = utilsFunc.searchArrIdx(allTblVO.fldNames,keyFldName2)
--    local keyIdx3 = utilsFunc.searchArrIdx(allTblVO.fldNames,keyFldName3)
    local keyIdx,keyIdx2,keyIdx3 = 1,2,3
    while low<=height do
        local cmpValue = cmpFunc3(allTblVO,mid,keyIdx,keyIdx2,keyIdx3,v1,v2,v3)
        if cmpValue == -1 then
            low = mid+1
        elseif cmpValue == 1 then
            height= mid-1
        else
            if ba then
                local midLow = mid-1
                while cmpFunc3(allTblVO,mid,keyIdx,keyIdx2,keyIdx3,v1,v2,v3) == 0 do
                    midLow = midLow-1
                end
                midLow = midLow+1

                local heightMid=mid+1
                while cmpFunc3(allTblVO,mid,keyIdx,keyIdx2,keyIdx3,v1,v2,v3) == 0 do
                    heightMid = heightMid+1
                end
                heightMid = heightMid-1

                return midLow,heightMid
            else
                return mid,mid
            end
        end
        mid = boy.number2Int((low+height)*0.5)
    end
    return -1
end

local function query3(allTblVO,ba,k1,v1,k2,v2,k3,v3)
    local ret={}
    local keyFlds = allTblVO.keyFlds
    if #keyFlds == 3 and keyFlds[1] == k1 and keyFlds[2] == k2 and keyFlds[3] == k3  then
        local idx,lastIdx = binarySearchOne3(allTblVO,ba,v1,v2,v3,boy)
        if idx > 0 then
            if ba then
                while idx<=lastIdx do
                    ret[#ret+1] = wrapVO(allTblVO,idx)
                    idx=idx+1
                end
                return ret
            else
                return wrapVO(allTblVO,idx)
            end
        else
            return nil
        end
    else
        local arr = allTblVO.data
        local k1Idx = utilsFunc.searchArrIdx(allTblVO.fldNames,k1)
        local k2Idx = utilsFunc.searchArrIdx(allTblVO.fldNames,k2)
        local k3Idx = utilsFunc.searchArrIdx(allTblVO.fldNames,k3)
        for i,v in ipairs(arr) do
            if v[k1Idx] == v1 and v[k2Idx]==v2 and v[k3Idx]==v3 then
                if ba==false or ba == nil then
                    return wrapVO(allTblVO,i)
                else
                    ret[#ret+1]=wrapVO(allTblVO,i)
                end
            end
        end
        if not ba then
            return nil
        end
        return ret
    end
end

local function cmpFunc2(allTblVO,mid,keyIdx,key2Idx,v1,v2)
    local arr = allTblVO.data
    local tblVO = arr[mid]
    if tblVO[keyIdx] > v1 then
        return 1
    elseif tblVO[keyIdx] < v1 then
        return -1
    else
        if tblVO[key2Idx] > v2 then
            return 1
        elseif tblVO[key2Idx] < v2 then
            return -1
        else
            return 0
        end
    end
end

local function binarySearchOne2(allTblVO,ba,v1,v2,boy)
    local low=1
    local height=allTblVO.len
    local mid = boy.number2Int((low+height)*0.5)
    local keyFldName = allTblVO.keyFlds[1]
    local keyFldName2 = allTblVO.keyFlds[2]
    local keyIdx = utilsFunc.searchArrIdx(allTblVO.fldNames,keyFldName)
    local keyIdx2 = utilsFunc.searchArrIdx(allTblVO.fldNames,keyFldName2)
    while low<=height do
        local cmpValue = cmpFunc2(allTblVO,mid,keyIdx,keyIdx2,v1,v2)
        if cmpValue == -1 then
            low = mid+1
        elseif cmpValue == 1 then
            height= mid-1
        else
            if ba then
                local midLow = mid-1
                while cmpFunc2(allTblVO,midLow,keyIdx,keyIdx2,v1,v2) == 0 do
                    midLow = midLow-1
                end
                midLow = midLow+1

                local heightMid=mid+1
                while cmpFunc2(allTblVO,heightMid,keyIdx,keyIdx2,v1,v2) == 0 do
                    heightMid = heightMid+1
                end
                heightMid = heightMid-1
                
                return midLow,heightMid
            else
                return mid,mid
            end
        end
        mid = boy.number2Int((low+height)*0.5)
    end
    return -1
end

local function query2(allTblVO,ba,k1,v1,k2,v2)
    local ret={}
    local keyFlds = allTblVO.keyFlds
    if #keyFlds == 2 and keyFlds[1] == k2 and keyFlds[2] == k1 then
        assert(false,"reserve it")
    end
    if #keyFlds == 2 and keyFlds[1] == k1 and keyFlds[2] == k2 then
        local idx,lastIdx = binarySearchOne2(allTblVO,ba,v1,v2,boy)
        if idx > 0 then
            if ba then
                while idx<=lastIdx do
                    ret[#ret+1] = wrapVO(allTblVO,idx)
                    idx=idx+1
                end
                return ret
            else
                return wrapVO(allTblVO,idx)
            end
        else
            return nil
        end
    else
        local arr = allTblVO.data
        local k1Idx = utilsFunc.searchArrIdx(allTblVO.fldNames,k1)
        local k2Idx = utilsFunc.searchArrIdx(allTblVO.fldNames,k2)
        for i,v in ipairs(arr) do
            if v[k1Idx] == v1 and v[k2Idx]==v2 then
                if ba==false or ba == nil then
                    return wrapVO(allTblVO,i)
                else
                    ret[#ret+1]=wrapVO(allTblVO,i)
                end
            end
        end
        if not ba then
            return nil
        end
        return ret
    end
end

local function cmpFunc1(allTblVO,mid,keyIdx,v1)
    local arr = allTblVO.data
    local tblVO = arr[mid]
    if tblVO == nil then return -1 end
    if tblVO[keyIdx] > v1 then
        return 1
    elseif tblVO[keyIdx] < v1 then
        return -1
    else
        return 0
    end
end

local function binarySearchOne1(allTblVO,ba,v1,boy)
    local low=1
    local height=allTblVO.len
    local len = height
    local mid = boy.number2Int((low+height)*0.5)
    local keyFldName = allTblVO.keyFlds[1]
    local keyIdx = utilsFunc.searchArrIdx(allTblVO.fldNames,keyFldName)
    while low<=height do
        local cmpValue = cmpFunc1(allTblVO,mid,keyIdx,v1)
        if cmpValue == -1 then
            low = mid+1
        elseif cmpValue == 1 then
            height= mid-1
        else
            if ba then
                local midLow = mid-1
                
                while cmpFunc1(allTblVO,midLow,keyIdx,v1) == 0 do
                    midLow = midLow-1
                end
                midLow = midLow+1
                
                local heightMid=mid+1
                while cmpFunc1(allTblVO,heightMid,keyIdx,v1) == 0  do
                    heightMid = heightMid+1
                end
                heightMid = heightMid-1
                return midLow,heightMid
            else
                return mid,mid
            end
        end
        mid = boy.number2Int((low+height)*0.5)
    end
    return -1
end
local function queryByNotAkey2(allTblVO,ba,k1,v1,k2,v2)
    local ret={}
    local idx1 = utilsFunc.searchArrIdx(allTblVO.fldNames,k1)
    local idx2 = utilsFunc.searchArrIdx(allTblVO.fldNames,k2)
    assert(idx1>0,"k1 idx not found:"..k1)
    assert(idx2>0,"k2 idx not found:"..k2)
    print(idx1,idx2,k1,v1,k2,v2)
    if (ba == true) then
        local ret={}
        for i,v in ipairs(allTblVO.data) do
            if v[idx1] == v1 and v[idx2] == v2  then
                ret[#ret+1] = wrapVO(allTblVO,i)
            end
        end
        return ret
    else
        for i,v in ipairs(allTblVO.data) do
            if v[idx1] == v1 and v[idx2] == v2  then
                print("find it")
                return wrapVO(allTblVO,i)
            end
        end
    end
end

local function queryByNotAkey1(allTblVO,ba,k1,v1)
    local ret={}
    local idx = utilsFunc.searchArrIdx(allTblVO.fldNames,k1)
    assert(idx>0,"k1 idx not found:"..k1)
    if (ba == true) then
        local ret={}
        for i,v in ipairs(allTblVO.data) do
            if v[idx] == v1 then
                ret[#ret+1] = wrapVO(allTblVO,i)
            end
        end
        return ret
    else
        for i,v in ipairs(allTblVO.data) do
            if v[idx] == v1 then
                return wrapVO(allTblVO,i)
            end
        end
    end
end

local function query1(allTblVO,ba,k1,v1)
    local ret={}
    local keyFlds = allTblVO.keyFlds
    if #keyFlds >= 1 and keyFlds[1] == k1 then
        local idx,lastIdx = binarySearchOne1(allTblVO,ba,v1,boy)
        if idx > 0 then
            if ba then
                while idx<=lastIdx do
                    ret[#ret+1] = wrapVO(allTblVO,idx)
                    idx=idx+1
                end
                return ret
            else
                return wrapVO(allTblVO,idx)
            end
        else
            if ba then return ret end
            return nil
        end
    else
        local arr = allTblVO.data
        local k1Idx = utilsFunc.searchArrIdx(allTblVO.fldNames,k1)
        for i,v in ipairs(arr) do
            if v[k1Idx] == v1 then
                if ba==false or ba == nil then
                    return wrapVO(allTblVO,i)
                else
                    ret[#ret+1]=wrapVO(allTblVO,i)
                end
            end
        end
        return ret
    end
    
end

local function query(allTblVO,ba,k1,v1,k2,v2,k3,v3)
    if allTblVO == nil then
        return nil
    end
    if allTblVO.len == 0 then
        return nil
    end
    if k2 == nil and k3 == nil then
        return query1(allTblVO,ba,k1,v1)
    end
    if k2~=nil and k3 == nil then
        return query2(allTblVO,ba,k1,v1,k2,v2)
    end
    return query3(allTblVO,ba,k1,v1,k2,v2,k3,v3)
end


--]]

--[[
queryObj
    fn   filename 没有.csv
    ba   beArray
    k1 k2 k3  为key

    下面选一
    v1 v2 v3 为 value
    v1Arr v2Arr v3Arr valueArr
--]]

local function sendErrMsg(queryObj,ba)
    local msg = queryObj.fn .. " not found " .. " k1 = "..queryObj.k1..";v1 = "..queryObj.v1
    if queryObj.k2 ~= nil then
        msg = msg.." k2 = "..queryObj.k2..";v2 = "..queryObj.v2
        if queryObj.k3 ~= nil then
            msg = msg.." k3 = "..queryObj.k3..";v3 = "..queryObj.v3
        end
    end
    if ba then
        msg = "arr len = 0 "..msg
    else
        msg = "searchTbl no found--> " ..msg
    end
    local updcfg = require "src/utils/utilsProDifCfg"
    local cfg= updcfg.debugConfig
    if cfg.traceSdbType == 1 then
      print(msg)
    elseif cfg.traceSdbType == 2 then
      print(msg)
    elseif cfg.traceSdbType == 3 then
      print(msg)
    end
    pkgObj.lastMsg = msg
end

function pkgObj.getLastMsg()
    local msg = pkgObj.lastMsg or ""
    return msg
end

function pkgObj.queryLinkStyle(queryObj)
    assert(queryObj.fn)
    local allTblVO = pkgObj.getTableVO(queryObj.fn)
    local k1 = assert(queryObj.k1)
    local v1 = assert(queryObj.v1)
    local nextTag =assert(queryObj.nt)
    local nextTagStopV = assert(queryObj.ntsv)
    local retVal = {}
    local oneVO = nil
    repeat
        oneVO = query1(allTblVO,false,k1,v1)
        if oneVO then 
            retVal[#retVal+1]=oneVO 
            v1 = oneVO[nextTag]
        end
    until oneVO == nil or oneVO[nextTag] == nextTagStopV
    if #retVal == 0 then
        sendErrMsg(queryObj,true)
    end
    return retVal
end

function pkgObj.query(queryObj)
    assert(queryObj.fn)
    local allTblVO = pkgObj.getTableVO(queryObj.fn)
    local k1 = assert(queryObj.k1)
    local k2 = queryObj.k2
    local k3 = queryObj.k3
    local retVal = nil
    if queryObj.v1 ~= nil then
        local v1 = queryObj.v1
        local v2= queryObj.v2
        local v3= queryObj.v3
        retVal = query(allTblVO,queryObj.ba,k1,v1,k2,v2,k3,v3)
    else
        assert(queryObj.v1Arr,queryObj.fn.." v1 or v1Arr is nil")
        retVal = {}
        for i,v in ipairs(queryObj.v1Arr) do
            local v1 = v
            local v2 = nil
            if queryObj.v2Arr ~= nil then
                v2 = queryObj.v2Arr[i]
            end
            local v3 = nil
            if queryObj.v3Arr ~= nil then
                v3 = queryObj.v3Arr[i]
            end
            local everyTbl = query(allTblVO,false,k1,v1,k2,v2,k3,v3)
            retVal[#retVal+1]=everyTbl
        end
    end
    if retVal == nil then
        sendErrMsg(queryObj)
    else
        if queryObj.ba then
            if #retVal == 0 then
                sendErrMsg(queryObj,true)
            end
        end
    end
    return retVal
end

local function queryByNotAkey(allTblVO,ba,k1,v1,k2,v2,k3,v3)
    if allTblVO == nil then
        return nil
    end
    if allTblVO.len == 0 then
        return nil
    end
    if k2 == nil and k3 == nil then
        return queryByNotAkey1(allTblVO,ba,k1,v1)
    end
    if k2~=nil and k3 == nil then
        return queryByNotAkey2(allTblVO,ba,k1,v1,k2,v2)
    end
    return queryByNotAkey3(allTblVO,ba,k1,v1,k2,v2,k3,v3)
end

function pkgObj.queryByNotKey(queryObj)
    local allTblVO = pkgObj.getTableVO(queryObj.fn)
    local k1 = assert(queryObj.k1)
    local k2 = queryObj.k2
    local k3 = queryObj.k3
    local retVal = nil
    if queryObj.v1 ~= nil then
        local v1 = queryObj.v1
        local v2= queryObj.v2
        local v3= queryObj.v3
        retVal = queryByNotAkey(allTblVO,queryObj.ba,k1,v1,k2,v2,k3,v3)
    else
        assert(false,"un finish")
        assert(queryObj.v1Arr,queryObj.fn.." v1Arr not found")
        retVal = {}
        for i,v in ipairs(queryObj.v1Arr) do
            local v1 = v
            local v2 = nil
            if queryObj.v2Arr ~= nil then
                v2 = queryObj.v2Arr[i]
            end
            local v3 = nil
            if queryObj.v3Arr ~= nil then
                v3 = queryObj.v3Arr[i]
            end
            local everyTbl = query(allTblVO,false,k1,v1,k2,v2,k3,v3)
            retVal[#retVal+1]=everyTbl
        end
    end
    if retVal == nil then
        sendErrMsg(queryObj)
    else
        if queryObj.ba then
            if #retVal == 0 then
                sendErrMsg(queryObj,true)
            end
        end
    end
    return retVal
end

return pkgObj
