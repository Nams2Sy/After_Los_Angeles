
if Config.GithubVersionCheck then
  
Citizen.CreateThread(function()
	local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
	if not CurrentVersion then
		print('^1ataRevals Version Check Failed!^7')
	end

	function VersionCheckHTTPRequest()
		PerformHttpRequest('https://raw.githubusercontent.com/atarevals/versions/master/'..Config.GithubName..'.json', VersionCheck, 'GET')
	end

	function VersionCheck(err, response, headers)
		Citizen.Wait(10000)
		if err == 200 then
			local Data = json.decode(response)
          
			if CurrentVersion ~= Data.version then		
				print(' ^3||^8 Your ' ..Data.script.. ' is outdated!')
                print(' ^3||^5 We suggest you update the script now ')
                print(' ^3||^1 You can download the new version from Discord ')
                print(' ^3||^1 or re-download the script from https://keymaster.fivem.net and enjoy.')
				print(' ^3||^8 New version: ^2' .. Data.version .. '^7')
				print(' ^3||^8 Your version: ^1' .. CurrentVersion .. '^7')
				print(' ^3||^4 Store : ^0https://ata.tebex.io')
				print(' ^3||^4 Discord : ^0'..Data.DiscordLink..'')
			else
				print( label )			
				print(' ^3||^3 Script : ^8'..Data.script..' ^2is up date ^6ENJOY.')
			end
		else
			print( label )			
			print('  ||    ^1There was an error getting the latest version information, if the issue persists contact !! AtaRevals#1538 on Discord.\n^0  ||\n  \\\\\n')
		end
		
		SetTimeout(60000000, VersionCheckHTTPRequest)
	end

	VersionCheckHTTPRequest()
end)


end