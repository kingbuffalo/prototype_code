function pkgObj.mysqlTimeStr2UnixTime(str)
    local os = require "os"
    local y,month,d,h,m,s = str:match("(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)");
    local tonumber = tonumber
    y = tonumber(y)
    month = tonumber(month)
    d = tonumber(d)
    h = tonumber(h)
    m = tonumber(m)
    s = tonumber(s)
    local timeParam = { year = y,month = month,day=d, hour=h,min=m,sec=s }
    return os.time(timeParam)
end