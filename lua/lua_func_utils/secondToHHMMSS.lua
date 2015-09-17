function pkgObj.secondToHHMMSS(time)
    local hour = boy.number2Int(time / 3600)
    local m = time - hour*3600
    m = boy.number2Int(m/60)
    local seconds = time - hour*3600 - m * 60
    local hStr = tostring(hour)
    if hour < 10 then hStr = "0"..hStr end
    local mStr = tostring(m)
    if m < 10 then mStr = "0"..mStr end
    local sStr = tostring(seconds)
    if seconds < 10 then sStr = "0"..sStr end
    return hStr ..":"..mStr..":"..sStr
end