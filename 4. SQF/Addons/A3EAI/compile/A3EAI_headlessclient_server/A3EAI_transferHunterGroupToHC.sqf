#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup","_targetPlayer"];

_unitGroup = _this select 0;
_targetPlayer = _this select 1;

A3EAI_sendHunterGroupHC = [_unitGroup,_targetPlayer];
A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_sendHunterGroupHC";

true
