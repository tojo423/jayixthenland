local player = game.Players.LocalPlayer;

local mouse = player:GetMouse();

local char = player.CharacterAdded:wait();

local playerGui = player:WaitForChild("PlayerGui");
local jailPromptDiagName = "JailPromptDialog";
local jailPromptDiag = playerGui:WaitForChild(jailPromptDiagName);

mouse.Move:Connect(function()	
	local cuffs = char:FindFirstChild("Cuffs");
	local targetChar = getPlayerChar(mouse.Target);
	
	jailPromptDiag.Enabled = cuffs and targetChar;
end);

--
getPlayerChar = function(part)
	if not part then return nil end;
	
	local model = part:FindFirstAncestorOfClass("Model");
	if not model then 
		return nil 
	end;
	
	if (model.PrimaryPart ~= "HumanoidRootPart") then 
		return nil 
	end;
	
	return model;
end
