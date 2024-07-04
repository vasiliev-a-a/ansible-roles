function priority_to_level(tag, timestamp, record)
    local priority = tonumber(record["priority"]) % 8
    local level
        
    if (priority == 0) then level =  "emerg" end
    if (priority == 1) then level =  "alert" end
    if (priority == 2) then level =  "critical" end
    if (priority == 3) then level =  "error" end
    if (priority == 4) then level =  "warning" end
    if (priority == 5) then level =  "notice" end
    if (priority == 6) then level =  "info" end
    if (priority == 7) then level =  "debug" end

    record["level"]= level
    return 2, timestamp, record
end
