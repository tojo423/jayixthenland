--[[ name:		SV_JailPlayer.lua
	 desc:		responsible for the jail procedure
	 type:		server
	 author:	Tayab Jamil
	 date: 		17/08/2019
	 notes:
		-place this script under the ServerScript service
	]]

local jailAnim;
local jailDelay_s = 3;
local jailPos = CFrame.new(0, 0, 0);

game.ReplicatedStorage.jailFunc.OnServerInvoke = function(player, targetChar)
	local humanoid = targetChar:FindFirstChildOfClass("Humanoid");
	
	local anim = humanoid:FindFirstChildOfClass("Animator");
	local animTrack = anim:LoadAnimation(jailAnim);
	animTrack:Play();
	
	local targetPlayer = game.Players:GetPlayerFromCharacter(targetChar);
	local playerMod = require(targetPlayer.PlayerScripts:WaitForChild("PlayerModule"));
	local ctrls = playerMod:GetControls();
	ctrls:Disable();

	wait(jailDelay_s);
	humanoid.Torso.CFrame = jailPos;
	ctrls:Enable();
end
