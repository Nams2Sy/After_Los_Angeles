Config = {}
Config.Framework = "esx" -- old-qb / esx / new-qb
Config.UserImageType = "discord" -- / discord / steam
Config.Database = "oxmysql" -- /mysql-async / ghmattimysql
Config.AreaDistance = 100.0
Config.NewESX = true
Config.UseCommand = true -- true / false (if you want to use command to open report ui)
Config.UseKey = true -- true / false (if you want to use key to open report ui) (IMPORTANT ! If you make it false, your previously joined players will still work. You can prevent this to some extent by changing the command name.)

Config.Open = {command = "adminreport", key = "H", text = "Open Report UI"}
Config.UserOpen = {command = "report"}

Config.MaxReportCountOfType = {
  ["Player"] = 2,
  ["Bugs"] = 2,
  ["Other"] = 2,
}

Config.GetPermissions = function()
  if Config.Framework == "esx" then
    return  {
       "superadmin",
       "admin",
       "mod",
    }
  else
    return  {
       "god",
       "admin",
    }
  end
end

Config.Language = {
    ["claimed"] = {
        ['true'] = "Claimed",
        ['false'] = "Claim Report"
      },
      ["status"] = {
        ["text"] = "Status",
        ["true"] = "Closed",
        ["false"] = "Pending"
      },
      ["onlineadmins"] = "Online Admins",
      ["createreport"] = "CREATE REPORT",
      ["createyourreport"] = "CREATE YOUR REPORT",
      ["createreportdesc"] = "Please fill the blanks and choose a report category. Admins will be reply soon!",
      ["Bugs"] = "Bugs",
      ["Player"] = "Player",
      ["Other"] = "Other",
      ["reporttitle"] = "Report title...",
      ["createdat"] = "Created",
      ["admin"] = "Admin",
      ["zoomfoto"] = "Click to zoom the footage.",
      ["textuser"] = "Type your situation ih here",
      ["myreports"] = "My Reports",
      ["searchmyreports"] = "Search by title...",
      ["claimedreports"] = "Claimed Reports",
      ["allreports"] = "All Reports",
      ["searchinrep"]= "Search in reports...",
      ["title"] = "Title",
      ["createdby"] = "Created By",
      ["type"] = "Type",
      ["date"] = "Date",
      ["discord"] = "Discord ID",
      ["steam"] = "Steam ID",
      ["license"] = "License ID",
      ["adminsendmessage"] = "Type here to send message...",
      ["adminreport"] = "Admins In This Report",
      ["areaplayers"] = "Player In This Area",
      ["actions"] = "Actions",
      ["goto"] = "Go To",
      ["bring"] = "Bring",
      ["freeze"] = "Freeze",
      ["addplayer"] = "Add Player",
      ["closereport"] = "Close Report",
      ["reportsubmition"] = "REPORT SUBMITION",
      ["reports"] = "REPORTS",
      ["closerepr"] = "Are You Sure To Close This Report",
      ["yes"] = "YES",
      ["no"] = "NO",
      ["add"] = "ADD",
      ["cancel"] = "CANCEL",
      ["createdreport"] = "New report has been created please check!",
      ["createdreportuser"] = "You created new report!",
      ["cannotcreate"] = "You can not create any more of this type report please wait for other reports to be solved",
      ["newmessage"] = "You have new messages from "
}

Config.SendNotification = function(message, isError, part, source)
  if part == nil then part = "client" end
  if part == "client" then
      if Config.Framework == "new-qb" or  Config.Framework == "old-qb" then
          local p = nil
          if isError then p = "error" else p = "success" end
          TriggerEvent("QBCore:Notify",message, p)
      else
          TriggerEvent("esx:showNotification", message)
      end
  elseif part == "server" then
      if Config.Framework == "new-qb" or  Config.Framework == "old-qb" then
          local p = nil
          if isError then p = "error" else p = "success" end
          TriggerClientEvent('QBCore:Notify', source, message, p)
      else
          TriggerClientEvent("esx:showNotification",source, message)
      end
  end
end