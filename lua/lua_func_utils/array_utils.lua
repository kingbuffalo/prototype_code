function pkgObj.searchArrIdx(arr,arrObj)
    for i,v in ipairs(arr) do
        if v == arrObj then
            return i;
        end
    end
    return -1
end


function pkgObj.removeArrIdx(arr,idx)
    if idx ~= -1 then
        local removeObj = arr[idx]
        table.remove(arr,idx)
        return removeObj
    end
    return nil
end

function pkgObj.addUnitToArr(arr,element)
    for _,v in ipairs(arr) do
        if v==element then
          return 
        end
    end
    arr[#arr+1]=element
end
function pkgObj.searchArrIdxByTag(arr,tag,value)
    for i,v in ipairs(arr) do
        if v[tag] == value then return i end
    end
    return -1
end
function pkgObj.searchArrIdxByFunc(arr,func)
    if arr == nil then return -1 end
    for i,v in ipairs(arr) do
        if func(i,v)==true then return i end
    end
    return -1
end
function pkgObj.removeArrObjByTag(arr,tag,value)
    local idx = pkgObj.searchArrIdxByTag(arr,tag,value)
    return pkgObj.removeArrIdx(arr,idx)
end
function pkgObj.removeArrObj(arr,arrObj)
    local idx = pkgObj.searchArrIdx(arr,arrObj)
    return pkgObj.removeArrIdx(arr,idx)
end
function pkgObj.forEachArrFunc(arr,func)
    for key, var in ipairs(arr) do
    	func(key,var)
    end
end
function pkgObj.getFilterArr(arr,filterFunc)
    local retArr = {}
    for key, var in ipairs(arr) do
        if filterFunc(var) then
            retArr[#retArr+1] = var
        end
    end
    return retArr
end
function pkgObj.copyElementToAnotherArr(arr)
    local ret = {}
    for i,v in ipairs(arr) do
        ret[i]=v
    end
    return ret
end
function pkgObj.unSortArr(arr)
    local len = #arr
    if len > 2 then
        for i=2,len-1 do
            local swapIdx = boy.number2Int(math.random(1,i+0.9))
            arr[i+1],arr[swapIdx] = arr[swapIdx],arr[i+1]
        end
    end
end