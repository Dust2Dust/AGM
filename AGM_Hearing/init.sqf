// by commy2 and CAA-Picard
#define StrenghToDeafness 3
#define MaxDeafness 1.1

if (isDedicated) exitWith {};

BWA3_EarRingingPlaying = false;

player addEventHandler ["firedNear", {_this call AGM_Hearing_fnc_firedNearEH}];
player addEventHandler ["explosion", {_this call AGM_Hearing_fnc_explosionEH}];

AGM_CurrentDeafness = 0;
AGM_NewDeafness = 0;

// Spawn volume updating process
[] spawn {
  while {true} do {

    // Check if new noises increase deafness
    if (AGM_NewDeafness * StrenghToDeafness > AGM_CurrentDeafness) then {
      AGM_CurrentDeafness = AGM_NewDeafness * StrenghToDeafness;

      if (AGM_CurrentDeafness > MaxDeafness) then {
        AGM_CurrentDeafness = MaxDeafness;
      };
    };
    AGM_NewDeafness = 0;

    // Recover rate is slower if deafness is severe
    _recoverRate = 0.01;
    if (AGM_CurrentDeafness > 0.7) then {
      _recoverRate = 0.005;
      if (AGM_CurrentDeafness > 0.9) then {
        _recoverRate = 0.002;
      };
    };

    // Deafness recovers with time
    AGM_CurrentDeafness = AGM_CurrentDeafness - _recoverRate;
    if (AGM_CurrentDeafness < 0) then {
        AGM_CurrentDeafness = 0
    };

    // Compute volume
    _clampedDeafness = (1 - AGM_CurrentDeafness);
    if (_clampedDeafness < 0) then {
      _clampedDeafness = 0
    };
    _volume = _clampedDeafness * _clampedDeafness;
    0.1 fadeSound _volume;
    0.1 fadeSpeech _volume;

    //hintSilent format ["AGM_CurrentDeafness, _Volume = %1, %2", AGM_CurrentDeafness, _volume];

    sleep 0.1;
  };
};
