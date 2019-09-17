--[[ name:		SV_JailPlayer.lua
	 desc:		responsible for the jail procedure
	 type:		server
	 author:	Tayab Jamil
	 date: 		17/08/2019
	 notes:
		-place this script under the ServerScript service
	]]

game.ReplicatedStorage.jailFunc.OnServerInvoke = function(player, targetChar)
	if not targetChar then
		return;
	end
	
	-- do player animation
	-- disable player controls
	-- teleport player
end
