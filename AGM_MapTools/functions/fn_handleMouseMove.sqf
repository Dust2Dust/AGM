// by CAA-Picard

private ["_control", "_pos"];

_control = _this select 0;
_pos = [_this select 1, _this select 2];

AGM_MapTools_mousePos = _control ctrlMapScreenToWorld _pos;

// Translation
if (AGM_MapTools_dragging) exitWith {
  AGM_MapTools_pos set [0, (AGM_MapTools_startPos select 0) + (AGM_MapTools_mousePos select 0) - (AGM_MapTools_startDragPos select 0)];
  AGM_MapTools_pos set [1, (AGM_MapTools_startPos select 1) + (AGM_MapTools_mousePos select 1) - (AGM_MapTools_startDragPos select 1)];
  // Update the size and rotation
  
  [] call AGM_MapTools_fnc_updateMapToolMarkers;
  true
};

// Rotation
if (AGM_MapTools_rotating) exitWith {
  // Get new angle
  _angle =  (180 + ((AGM_MapTools_mousePos select 0) - (AGM_MapTools_startPos select 0)) atan2 ((AGM_MapTools_mousePos select 1) - (AGM_MapTools_startPos select 1)) mod 360);
  AGM_MapTools_angle = AGM_MapTools_startAngle + _angle - AGM_MapTools_startDragAngle;

  hint format ["  AGM_MapTools_angle= %1", AGM_MapTools_angle];
  [] call AGM_MapTools_fnc_updateMapToolMarkers;
  true
};

false
