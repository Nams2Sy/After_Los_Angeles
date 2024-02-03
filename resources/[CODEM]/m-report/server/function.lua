function UpdateSql()
    for k,v in pairs(HSN.UserData) do
        local result = ExecuteSql("SELECT * FROM m_reports WHERE identifier = '"..k.."'")
        if result[1] == nil then
            local jsonEncoded = json.encode(v.MyReports):gsub("'", "''")
            ExecuteSql("INSERT INTO m_reports (identifier, data) VALUES ('"..k.."', '"..jsonEncoded.."')")
        else
            local jsonEncoded = json.encode(v.MyReports):gsub("'", "''")
            ExecuteSql("UPDATE m_reports SET data ='"..jsonEncoded.."' WHERE identifier = '"..k.."'")
        end
    end
    reportsdata = HSN.Reports
    for k,v in pairs(reportsdata) do
        local result = ExecuteSql("SELECT * FROM allreports WHERE id = '"..k.."'")
        if result[1] == nil then
            local userprofile = ""
            for i,j in pairs(v.ReporterData) do
                if i == "UserProfile" then
                    userprofile = j
                    v.ReporterData[i] = nil
                end
            end
            local jsonEncoded = json.encode(v):gsub("'", "''")
            ExecuteSql("INSERT INTO allreports (id, data, profilephoto) VALUES ('"..k.."', '"..jsonEncoded.."', '"..userprofile.."')")
            v.ReporterData["UserProfile"] = userprofile
        else
            local userprofile = ""
            for i,j in pairs(v.ReporterData) do
                if i == "UserProfile" then
                    userprofile = j
                    v.ReporterData[i] = nil
                end
            end
            local jsonEncoded = json.encode(v):gsub("'", "''")
            ExecuteSql("UPDATE allreports SET data ='"..jsonEncoded.."' WHERE id = '"..k.."'")
            v.ReporterData["UserProfile"] = userprofile
        end
    end
end