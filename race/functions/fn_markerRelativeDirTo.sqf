private "_dir";
_dir = [ markerPos ( _this select 0 ), _this select 1 ] call BIS_fnc_dirTo;
_dir = _dir - ( markerDir ( _this select 0 ) );

if ( _dir < 0 ) then { _dir = _dir + 360 };
if ( _dir > 360 ) then { _dir = _dir - 360 };

_dir