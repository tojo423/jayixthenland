--[[
	name:		SV_GateLever
	desc:		gate lever behaviour
	type:		server
	author:		Tayab Jamil
	date: 		17/09/19
]]

--settings
local GateOpenedHeight = 2;
local MovementSpeed = 0;

--vars
local _parent = script.Parent;
local _clickDetector = Instance.new("ClickDetector", _parent);
local _leverPart = _parent:FindFirstChild("OV_LeverPart").Value;
local _gate = _parent:FindFirstChild("OV_Gate").Vaue;
local _gatePart = _gate.PrimaryPart;
local _isMoving = false;
local _movDir = 1;
local _isOpen = false;

--callbacks
function _clickDetector_MouseClick()
	if _isMoving then
		return;
	end
	
	_isMoving = true;
	
	local newLeverRot = _leverPart.Rotation;
	newLeverRot.X = newLeverRot.X * -1;
	_leverPart.Rotation = newLeverRot;
	
	local dist = math.abs(_gatePart.Position.Y - GateOpenedHeight);
	local time = dist / MovementSpeed;
	
	for t = 0, time, 0.03 do
		local currPos = _gatePart.Position;
		local delta = MovementSpeed * 0.03 * _movDir;
		local newPos = currPos.Y + delta;
		_gate:MoveTo(newPos);
		wait();
	end
	
	_movDir = _movDir * -1;
	
	_isMoving = false;
end
_clickDetector.MouseClick:Connect(_clickDetector_MouseClick);
