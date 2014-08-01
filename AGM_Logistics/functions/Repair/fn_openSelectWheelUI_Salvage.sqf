// by commy2

private ["_vehicle", "_wheels", "_listIDC", "_count", "_index", "_wheel", "_name", "_picture"];

_vehicle = _this select 0;
//_wheels = _this select 1;

_wheels = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "AGM_Wheels");

_wheels = [_wheels, {AGM_Interaction_Target getHitPointDamage _this < 1}] call AGM_Core_fnc_filter;
_count = count _wheels;

_listIDC = [localize "STR_AGM_Repair_SelectWheelMenu_Salvage", localize "STR_AGM_Repair_SelectWheel_Salvage", "_vehicle = AGM_Interaction_Target; _wheel = lbData [8866, lbCurSel 8866]; closeDialog 0; [_vehicle, _wheel] call AGM_Repair_fnc_removeWheel;"] call AGM_Interaction_fnc_openSelectMenu;

for "_index" from 0 to (_count - 1) do {
	_wheel = _wheels select _index;
	//_name = [_wheel] call AGM_Repair_fnc_getHitPointName;
	_name = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "AGM_WheelsLocalized") select (getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "AGM_Wheels") find _wheel);
	_picture = "";

	if (_vehicle getHitPointDamage _wheel < 1) then {
		_index = lbAdd [_listIDC, _name];
		lbSetData [_listIDC, _index, _wheel];
		lbSetPicture [_listIDC, _index, _picture];
	};
};

lbSetCurSel [_listIDC, 0];
