--[[ name:		L_JailPlayerPrompt.lua
	 desc:		responsible for jail prompting and input
	 type:		local
	 author:	Tayab Jamil
	 date: 		16/08/2019
	 notes:	
		-place this script under the StarterPlayerScripts service
		-create a ScreenGui under the StarterGui service. this is the jail player prompt GUI
	 	-create a Tool Named 'Cuffs' (the value of 'self.cuffsToolName') in the StarterPack service
	]]

local player = game.Players.LocalPlayer;

local mouse = player:GetMouse();

local char = player.CharacterAdded:wait();

local cuffsToolName = "Cuffs";

local playerGui = player:WaitForChild("PlayerGui");
local jailPromptDiagName = "JailPlayerPromptDialog";
local jailPromptDiag = playerGui:WaitForChild(jailPromptDiagName);

local canJail;
local targetChar;

mouse.Move:Connect(function()	
	local cuffs = char:FindFirstChild(cuffsToolName);
	
	local targetPart = mouse.Target;
	targetChar = getPlayerCharacterFromPart(targetPart);
	
	canJail = cuffs and targetChar;
	
	jailPromptDiag.Enabled = canJail;
end);

mouse.Button1Down:Connect(function()
	if canJail then
		game.ReplicatedStorage.jailFunc:InvokeServer(targetChar);
	end
end);

--[[ gets a player's character from a child part.
	 returns nil if a player character isn't found.
	 ]]
getPlayerCharacterFromPart = function(part)
	if not part then 
		return nil 
	end;
		
	local model = part:FindFirstAncestorOfClass("Model");
	if not model or not model.PrimaryPart then 
		return nil 
	end;
		
	if (model.PrimaryPart ~= "HumanoidRootPart") then 
		return nil 
	end;
		
	return model;
end	
