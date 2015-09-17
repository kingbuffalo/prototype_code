function getTodayLeftSecond()
    local ti = getCurrentTime()
    local os=os
    local t_date = os.date("*t",ti)
    local tomorrowTi = {
        year=t_date.year,month=t_date.month,day=t_date.day,
        hour=23,min=59,sec=59 }
    local t_ti = os.time(tomorrowTi)
    return t_ti - ti
end