local pkgObj = {}
local function push(list,value)
    local node = {next=nil,value=value}
    if list.head == nil then
        list.head = node
        list.tail = node
    else
        list.tail.next = node
        list.tail = node
    end
    list.len = list.len + 1
end

local function pop(list)
    local ret=nil
    if list.head ~= nil then
        ret = list.head.value
        list.head= list.head.next
        list.len = list.len -1
    end
    return ret
end

function pkgObj.create()
    local list = {push=push,pop=pop,len=0}
    return list
end

return pkgObj