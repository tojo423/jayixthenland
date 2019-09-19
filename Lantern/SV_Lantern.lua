--[[
	name:		SV_Lantern
	desc:		lantern behaviour
	type:		server
	author:		Tayab Jamil
	date: 		16/09/19
]]

--settings
local LightBrightness = 0.5;
local LightRange = 24;
local FlickerEnabled = true;
local LightRangeDeviation = 5;

--vars
local _tool = script.Parent;
local _particles = _tool.Flame.ParticleEmitter

local _light = _tool.Glass.PointLight
_light.Brightness = 0;
_light.Range = LightRange;

local _isEquipped = false;
local _isActivated = false;

local _lightRangeMin = LightRange - LightRangeDeviation;
local _lightRangeMax = LightRange + LightRangeDeviation;

--callbacks
function _tool_Equipped()
	_isEquipped = true;
	if _isActivated then
		wait(0.1);
		_particles.Enabled = true;
		IncreaseLightRoutine();
	end
end
_tool.Equipped:Connect(_tool_Equipped);

function _tool_Unequipped()
	_isEquipped = false;
	_light.Brightness = 0;
	_particles.Enabled = false;
end
_tool.Unequipped:Connect(_tool_Unequipped);

function _tool_Activated()
	_isActivated = not _isActivated;
	
	_particles.Enabled = _isActivated;
	
	if (_isActivated) then
		IncreaseLightRoutine();
	else
		_light.Brightness = 0;
	end
end
_tool.Activated:Connect(_tool_Activated);

--methods
function IncreaseLightRoutine()
	repeat
		_light.Brightness = _light.Brightness + 0.05;
		wait();
	until not _isActivated or _light.Brightness >= LightBrightness;
	
	if FlickerEnabled and _isActivated then
		spawn(FlickerRoutine);
	end
end

function FlickerRoutine()
	repeat
		_light.Range = math.random(_lightRangeMin, _lightRangeMax);
		wait(0.1);
	until not _isActivated or not _isEquipped; 
end
