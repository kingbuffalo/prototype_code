local zeroMt = {
    __index=function(t,k)
        return 0;
    end
}
function pkgObj.setZeroDefaultMember(value)
    if value==nil then value={} end
    setmetatable(value,zeroMt)
    return value
end