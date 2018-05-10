-- Copyright (C) 2018  The Dota IMBA Development Team
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Editors:
--     Earth Salamander #42

-- Battlepass

-- to add soon:
-- Maelstrom (particles/econ/events/ti8/maelstorm_ti8.vpcf)
-- Mjollnir shield (particles/econ/events/ti8/mjollnir_shield_ti8.vpcf)
-- Phase Boots (particles/econ/events/ti8/phase_boots_ti8.vpcf)

if Imbattlepass == nil then Imbattlepass = class({}) end
local next_reward = false
local next_reward_shown = false
if IsInToolsMode() and next_reward == true then
	next_reward_shown = true
end

IMBATTLEPASS_LEVEL_REWARD = {}
IMBATTLEPASS_LEVEL_REWARD[4]	= "fountain"
IMBATTLEPASS_LEVEL_REWARD[9]	= "blink"
IMBATTLEPASS_LEVEL_REWARD[13]	= "fountain2"
IMBATTLEPASS_LEVEL_REWARD[16]	= "force_staff"
IMBATTLEPASS_LEVEL_REWARD[18]	= "blink2"
IMBATTLEPASS_LEVEL_REWARD[22]	= "fountain3"
IMBATTLEPASS_LEVEL_REWARD[26]	= "bottle"
IMBATTLEPASS_LEVEL_REWARD[27]	= "blink3"
IMBATTLEPASS_LEVEL_REWARD[31]	= "fountain4"
IMBATTLEPASS_LEVEL_REWARD[32]	= "force_staff2"
IMBATTLEPASS_LEVEL_REWARD[35]	= "mekansm"
IMBATTLEPASS_LEVEL_REWARD[36]	= "blink4"
IMBATTLEPASS_LEVEL_REWARD[40]	= "fountain5"
IMBATTLEPASS_LEVEL_REWARD[44]	= "radiance"
IMBATTLEPASS_LEVEL_REWARD[45]	= "blink5"
IMBATTLEPASS_LEVEL_REWARD[48]	= "force_staff3"
IMBATTLEPASS_LEVEL_REWARD[49]	= "fountain6"
IMBATTLEPASS_LEVEL_REWARD[50]	= "bottle2"
IMBATTLEPASS_LEVEL_REWARD[54]	= "blink6"
IMBATTLEPASS_LEVEL_REWARD[58]	= "fountain7"
IMBATTLEPASS_LEVEL_REWARD[60]	= "sheepstick"
IMBATTLEPASS_LEVEL_REWARD[63]	= "blink7"
IMBATTLEPASS_LEVEL_REWARD[64]	= "force_staff4"
if next_reward_shown then
	IMBATTLEPASS_LEVEL_REWARD[65]	= "juggernaut_arcana"
end
IMBATTLEPASS_LEVEL_REWARD[67]	= "fountain8"
IMBATTLEPASS_LEVEL_REWARD[70]	= "mekansm2"
IMBATTLEPASS_LEVEL_REWARD[72]	= "blink8"
IMBATTLEPASS_LEVEL_REWARD[74]	= "bottle3"
IMBATTLEPASS_LEVEL_REWARD[76]	= "fountain9"
IMBATTLEPASS_LEVEL_REWARD[80]	= "pudge_arcana"
IMBATTLEPASS_LEVEL_REWARD[81]	= "blink9"
IMBATTLEPASS_LEVEL_REWARD[85]	= "fountain10"
IMBATTLEPASS_LEVEL_REWARD[88]	= "radiance2"
IMBATTLEPASS_LEVEL_REWARD[90]	= "blink10"
IMBATTLEPASS_LEVEL_REWARD[94]	= "fountain11"
if next_reward_shown then
	IMBATTLEPASS_LEVEL_REWARD[95]	= "juggernaut_arcana2"
end
IMBATTLEPASS_LEVEL_REWARD[98]	= "bottle4"
if next_reward_shown then
	IMBATTLEPASS_LEVEL_REWARD[99]	= "blink11"
end
IMBATTLEPASS_LEVEL_REWARD[100]	= "shiva"
if next_reward_shown then
	IMBATTLEPASS_LEVEL_REWARD[101]	= "vengefulspirit_immortal"
end
IMBATTLEPASS_LEVEL_REWARD[103]	= "fountain12"
IMBATTLEPASS_LEVEL_REWARD[105]	= "pudge_arcana2" -- mekansm3, needs new design
if next_reward_shown then
	IMBATTLEPASS_LEVEL_REWARD[108]	= "blink12"
end
IMBATTLEPASS_LEVEL_REWARD[112]	= "fountain13"
IMBATTLEPASS_LEVEL_REWARD[120]	= "sheepstick2"
IMBATTLEPASS_LEVEL_REWARD[121]	= "fountain14"
IMBATTLEPASS_LEVEL_REWARD[130]	= "fountain15"
if next_reward_shown then
	IMBATTLEPASS_LEVEL_REWARD[132]	= "radiance3"
	IMBATTLEPASS_LEVEL_REWARD[139]	= "fountain16"
	IMBATTLEPASS_LEVEL_REWARD[148]	= "fountain17"
end
IMBATTLEPASS_LEVEL_REWARD[150]	= "shiva2"
if next_reward_shown then
	IMBATTLEPASS_LEVEL_REWARD[157]	= "fountain18"
	IMBATTLEPASS_LEVEL_REWARD[200]	= "shiva3"
end

CustomNetTables:SetTableValue("game_options", "battlepass", {battlepass = IMBATTLEPASS_LEVEL_REWARD})

function Imbattlepass:Init()
	IMBATTLEPASS_FOUNTAIN = {}
	IMBATTLEPASS_BLINK = {}
	IMBATTLEPASS_FORCE_STAFF = {}
	IMBATTLEPASS_BOTTLE = {}
	IMBATTLEPASS_MEKANSM = {}
	IMBATTLEPASS_RADIANCE = {}
	IMBATTLEPASS_SHEEPSTICK = {}
	IMBATTLEPASS_SHIVA = {}
	IMBATTLEPASS_PUDGE = {}
	IMBATTLEPASS_JUGGERNAUT = {}
	IMBATTLEPASS_ANCIENT_APPARITION = {}
	IMBATTLEPASS_VENGEFULSPIRIT = {}

	for k, v in pairs(IMBATTLEPASS_LEVEL_REWARD) do
		if string.find(v, "fountain") then
			IMBATTLEPASS_FOUNTAIN[v] = k
		elseif string.find(v, "blink") then
			IMBATTLEPASS_BLINK[v] = k
		elseif string.find(v, "force_staff") then
			IMBATTLEPASS_FORCE_STAFF[v] = k
		elseif string.find(v, "bottle") then
			IMBATTLEPASS_BOTTLE[v] = k
		elseif string.find(v, "mekansm") then
			IMBATTLEPASS_MEKANSM[v] = k
		elseif string.find(v, "radiance") then
			IMBATTLEPASS_RADIANCE[v] = k
		elseif string.find(v, "sheepstick") then
			IMBATTLEPASS_SHEEPSTICK[v] = k
		elseif string.find(v, "shiva") then
			IMBATTLEPASS_SHIVA[v] = k
		elseif string.find(v, "pudge") then
			IMBATTLEPASS_PUDGE[v] = k
		elseif string.find(v, "juggernaut") then
			IMBATTLEPASS_JUGGERNAUT[v] = k
		elseif string.find(v, "ancient_apparition") then
			IMBATTLEPASS_ANCIENT_APPARITION[v] = k
		elseif string.find(v, "vengefulspirit") then
			IMBATTLEPASS_VENGEFULSPIRIT[v] = k
		end
	end

	Imbattlepass:BattlepassCheckArcana()
end

function Imbattlepass:AddItemEffects(hero)
	Imbattlepass:GetBlinkEffect(hero)
	Imbattlepass:GetForceStaffEffect(hero)
	Imbattlepass:GetRadianceEffect(hero)
	Imbattlepass:GetSheepstickEffect(hero)
	Imbattlepass:GetShivaEffect(hero)
	Imbattlepass:GetMekansmEffect(hero)
	Imbattlepass:GetFountainEffect(hero)
	Imbattlepass:GetBottleEffect(hero)
	Imbattlepass:GetHeroEffect(hero)
end

function Imbattlepass:GetRewardUnlocked(ID)
	if CustomNetTables:GetTableValue("player_table", tostring(ID)) then
		return CustomNetTables:GetTableValue("player_table", tostring(ID)).Lvl
	end

	return 1
end

function Imbattlepass:GetBlinkEffect(hero)
	local effect = "particles/items_fx/blink_dagger_start.vpcf"
	local effect2 = "particles/items_fx/blink_dagger_end.vpcf"
	local icon = 0

--	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink12"] then
--		effect = "particles/econ/events/ti8/blink_dagger_ti8_start_lvl2.vpcf"
--		effect2 = "particles/econ/events/ti8/blink_dagger_ti8_end_lvl2.vpcf"
--		icon = 12
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink11"] then
--		effect = "particles/econ/events/ti8/blink_dagger_ti8_start.vpcf"
--		effect2 = "particles/econ/events/ti8/blink_dagger_ti8_end.vpcf"
--		icon = 11
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink10"] then
	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink10"] then
		effect = "particles/econ/events/ti5/blink_dagger_start_lvl2_ti5.vpcf"
		effect2 = "particles/econ/events/ti5/blink_dagger_end_lvl2_ti5.vpcf"
		icon = 10
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink9"] then
		effect = "particles/econ/events/ti5/blink_dagger_start_ti5.vpcf"
		effect2 = "particles/econ/events/ti5/blink_dagger_end_ti5.vpcf"
		icon = 9
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink8"] then
		effect = "particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf"
		effect2 = "particles/econ/events/ti6/blink_dagger_end_ti6_lvl2.vpcf"
		icon = 8
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink7"] then
		effect = "particles/econ/events/ti6/blink_dagger_start_ti6.vpcf"
		effect2 = "particles/econ/events/ti6/blink_dagger_end_ti6.vpcf"
		icon = 7
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink6"] then
		effect = "particles/econ/events/ti4/blink_dagger_start_ti4.vpcf"
		effect = "particles/econ/events/ti4/blink_dagger_end_ti4.vpcf"
		icon = 6	
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink5"] then
		effect = "particles/econ/events/winter_major_2017/blink_dagger_start_wm07.vpcf"
		effect2 = "particles/econ/events/winter_major_2017/blink_dagger_end_wm07.vpcf"
		icon = 5
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink4"] then
		effect = "particles/econ/events/ti7/blink_dagger_start_ti7_lvl2.vpcf"
		effect2 = "particles/econ/events/ti7/blink_dagger_end_ti7_lvl2.vpcf"
		icon = 4
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink3"] then
		effect = "particles/econ/events/ti7/blink_dagger_start_ti7.vpcf"
		effect2 = "particles/econ/events/ti7/blink_dagger_end_ti7.vpcf"
		icon = 3
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink2"] then
		effect = "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf"
		effect2 = "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_end_nexon_hero_cp_2014.vpcf"
		icon = 2
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BLINK["blink"] then
		effect = "particles/econ/events/fall_major_2016/blink_dagger_start_fm06.vpcf"
		effect2 = "particles/econ/events/fall_major_2016/blink_dagger_end_fm06.vpcf"
		icon = 1
	end

	hero.blink_effect = effect
	hero.blink_effect_end = effect2
	hero.blink_icon = icon
--	CustomNetTables:SetTableValue("player_battlepass", tostring(hero:GetPlayerID()), {blink_icon = icon})
end

function Imbattlepass:GetForceStaffEffect(hero) -- still not working yet
	local effect = "particles/items_fx/force_staff.vpcf"
	local icon = 0

--	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FORCE_STAFF["force_staff5"] then
--		effect = "particles/econ/events/ti8/force_staff_ti8.vpcf"
--		icon = 5
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FORCE_STAFF["force_staff4"] then
	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FORCE_STAFF["force_staff4"] then
		effect = "particles/econ/events/ti6/force_staff_ti6.vpcf"
		icon = 4
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FORCE_STAFF["force_staff3"] then
		effect = "particles/econ/events/winter_major_2017/force_staff_wm07.vpcf"
		icon = 3
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FORCE_STAFF["force_staff2"] then
		effect = "particles/econ/events/ti7/force_staff_ti7.vpcf"
		icon = 2
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FORCE_STAFF["force_staff"] then
		effect = "particles/econ/events/fall_major_2016/force_staff_fm06.vpcf"
		icon = 1
	end

	hero.force_staff_effect = effect
	hero.force_staff_icon = icon
end

function Imbattlepass:GetRadianceEffect(hero)
	local effect = "particles/items2_fx/radiance_owner.vpcf"
	local effect2 = "particles/items2_fx/radiance.vpcf"
	local icon = 0

--	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_RADIANCE["radiance3"] then
--		effect = "particles/econ/events/ti8/radiance_owner_ti8.vpcf"
--		effect2 = "particles/econ/events/ti8/radiance_ti8.vpcf"
--		icon = 3
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_RADIANCE["radiance2"] then
	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_RADIANCE["radiance2"] then
		effect = "particles/econ/events/ti6/radiance_owner_ti6.vpcf"
		effect2 = "particles/econ/events/ti6/radiance_ti6.vpcf"
		icon = 2
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_RADIANCE["radiance"] then
		effect = "particles/econ/events/ti7/radiance_owner_ti7.vpcf"
		effect2 = "particles/econ/events/ti7/radiance_ti7.vpcf"
		icon = 1
	end

	hero.radiance_effect_owner = effect
	hero.radiance_effect = effect2
	hero.radiance_icon = icon
end

function Imbattlepass:GetSheepstickEffect(hero)
	local effect = "particles/items_fx/item_sheepstick.vpcf"
	local model = "models/props_gameplay/pig.vmdl"
	local icon = 0

	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_SHEEPSTICK["sheepstick2"] then
		effect = "particles/econ/items/shadow_shaman/shadow_shaman_sheepstick/shadowshaman_voodoo_sheepstick.vpcf"
		model = "models/props_gameplay/roquelaire/roquelaire.vmdl"
		icon = 2
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_SHEEPSTICK["sheepstick"] then
		effect = "particles/econ/events/winter_major_2017/item_sheepstick_wm07.vpcf"
		model = "models/props_gameplay/pig_blue.vmdl"
		icon = 1
	end

	hero.sheepstick_effect = effect
	hero.sheepstick_model = model
	hero.sheepstick_icon = icon
end

function Imbattlepass:GetShivaEffect(hero)
	local effect = "particles/items2_fx/shivas_guard_active.vpcf"
	local effect2 = "particles/items2_fx/shivas_guard_impact.vpcf"
	local icon = 0

--	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_SHIVA["shiva3"] then
--		effect = "particles/econ/events/ti8/shivas_guard_ti8_active.vpcf"
--		effect2 = "particles/econ/events/ti8/shivas_guard_ti8_impact.vpcf"
--		icon = 3
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_SHIVA["shiva2"] then
	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_SHIVA["shiva2"] then
		effect = "particles/econ/events/newbloom_2015/shivas_guard_active_nian2015.vpcf"
		effect2 = "particles/econ/events/newbloom_2015/shivas_guard_impact_nian2015.vpcf"
		icon = 2
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_SHIVA["shiva"] then
		effect = "particles/econ/events/ti7/shivas_guard_active_ti7.vpcf"
		effect2 = "particles/econ/events/ti7/shivas_guard_impact_ti7.vpcf"
		icon = 1
	end

	hero.shiva_blast_effect = effect
	hero.shiva_hit_effect = effect2
	hero.shiva_icon = icon
end

function Imbattlepass:GetMekansmEffect(hero)
	local effect = "particles/items2_fx/mekanism.vpcf"
	local effect2 = "particles/items2_fx/mekanism_recipient.vpcf"
	local effect3 = "particles/items3_fx/warmage.vpcf"
	local effect4 = "particles/items3_fx/warmage_recipient.vpcf"
	local effect5 = "particles/items3_fx/warmage_mana_nonhero.vpcf"
	local icon = 0

--	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_MEKANSM["mekansm3"] then
--		effect = "particles/econ/events/ti8/mekanism_ti8.vpcf"
--		effect2 = "particles/econ/events/ti8/mekanism_recipient_ti8.vpcf"
--		effect3 = ""
--		effect4 = ""
--		effect5 = ""
--		icon = 3
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_MEKANSM["mekansm2"] then
	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_MEKANSM["mekansm2"] then
		effect = "particles/econ/events/ti6/mekanism_ti6.vpcf"
		effect2 = "particles/econ/events/ti6/mekanism_recipient_ti6.vpcf"
		effect3 = "particles/items3_fx/warmage2.vpcf"
		effect4 = "particles/items3_fx/warmage2_recipient.vpcf"
		effect5 = "particles/items3_fx/warmage2_mana_nonhero.vpcf"
		icon = 2
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_MEKANSM["mekansm"] then
		effect = "particles/econ/events/ti7/mekanism_ti7.vpcf"
		effect2 = "particles/econ/events/ti7/mekanism_recipient_ti7.vpcf"
		effect3 = "particles/items3_fx/warmage1.vpcf"
		effect4 = "particles/items3_fx/warmage1_recipient.vpcf"
		effect5 = "particles/items3_fx/warmage1_mana_nonhero.vpcf"
		icon = 1
	end

	hero.mekansm_effect = effect
	hero.mekansm_hit_effect = effect2
	hero.guardian_greaves_effect = effect3
	hero.guardian_greaves_hit_effect = effect4
	hero.guardian_greaves_hit_alt_effect = effect5
	hero.mekansm_icon = icon
end

function Imbattlepass:GetFountainEffect(hero)
	local effect = ""

--	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain18"] then
--		effect = "particles/econ/events/ti8/fountain_regen_ti8_lvl3.vpcf"
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain17"] then
--		effect = "particles/econ/events/ti8/fountain_regen_ti8_lvl2.vpcf"
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain16"] then
--		effect = "particles/econ/events/ti8/fountain_regen_ti8.vpcf"
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain15"] then
	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain15"] then
		effect = "particles/econ/events/ti5/radiant_fountain_regen_lvl2_ti5.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain14"] then
		effect = "particles/econ/events/ti5/radiant_fountain_regen_ti5.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain13"] then
		effect = "particles/econ/events/ti6/radiant_fountain_regen_ti6_lvl3.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain12"] then
		effect = "particles/econ/events/ti6/radiant_fountain_regen_ti6_lvl2.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain11"] then
		effect = "particles/econ/events/ti5/radiant_fountain_regen_ti6.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain10"] then
		effect = "particles/econ/events/ti4/radiant_fountain_regen_ti4.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain9"] then
		effect = "particles/econ/events/winter_major_2017/radiant_fountain_regen_wm07_lvl3.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain8"] then
		effect = "particles/econ/events/winter_major_2017/radiant_fountain_regen_wm07_lvl2.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain7"] then
		effect = "particles/econ/events/winter_major_2017/radiant_fountain_regen_wm07_lvl1.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain6"] then
		effect = "particles/econ/events/ti7/fountain_regen_ti7_lvl3.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain5"] then
		effect = "particles/econ/events/ti7/fountain_regen_ti7_lvl2.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain4"] then
		effect = "particles/econ/events/ti7/fountain_regen_ti7.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain3"] then
		effect = "particles/econ/events/fall_major_2016/radiant_fountain_regen_fm06_lvl3.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain2"] then
		effect = "particles/econ/events/fall_major_2016/radiant_fountain_regen_fm06_lvl2.vpcf"
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_FOUNTAIN["fountain"] then
		effect = "particles/econ/events/fall_major_2016/radiant_fountain_regen_fm06_lvl1.vpcf"
	end

	hero.fountain_effect = effect
end

function Imbattlepass:GetBottleEffect(hero)
	local effect = "particles/items_fx/bottle.vpcf"
	local icon = 0

--	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BOTTLE["bottle5"] then
--		effect = "particles/econ/events/ti8/bottle_ti8.vpcf"
--		icon = 5
--	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BOTTLE["bottle4"] then
	if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BOTTLE["bottle4"] then
		effect = "particles/econ/events/ti5/bottle_ti5.vpcf"
		icon = 4
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BOTTLE["bottle3"] then
		effect = "particles/econ/events/ti6/bottle_ti6.vpcf"
		icon = 3
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BOTTLE["bottle2"] then
		effect = "particles/econ/events/ti4/bottle_ti4.vpcf"
		icon = 2
	elseif Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_BOTTLE["bottle"] then
		effect = "particles/econ/events/ti7/bottle_ti7.vpcf"
		icon = 1
	end

	hero.bottle_effect = effect
	hero.bottle_icon = icon
--	CustomNetTables:SetTableValue("player_battlepass", tostring(hero:GetPlayerID()), {bottle_icon = icon})
end

function Imbattlepass:GetHeroEffect(hero)
	if hero:GetUnitName() == "npc_dota_hero_juggernaut" then
		if next_reward == true and Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_JUGGERNAUT["juggernaut_arcana"] then
			Imbattlepass:GetJuggernautArcanaEffect(hero:GetPlayerID(), HasJuggernautArcana(hero:GetPlayerID()))
		end
	elseif hero:GetUnitName() == "npc_dota_hero_pudge" then
		if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_PUDGE["pudge_arcana"] then
			Imbattlepass:GetPudgeArcanaEffect(hero:GetPlayerID(), HasPudgeArcana(hero:GetPlayerID()))
		end
	elseif hero:GetUnitName() == "npc_dota_hero_vengefulspirit" then
		if Imbattlepass:GetRewardUnlocked(hero:GetPlayerID()) >= IMBATTLEPASS_VENGEFULSPIRIT["vengefulspirit_immortal"] then
			Imbattlepass:GetVengefulspiritEffect(hero:GetPlayerID())
		end
	end
end

function Imbattlepass:GetVengefulspiritEffect(ID)
	if PlayerResource:GetSelectedHeroEntity(ID) == nil then
		Timers:CreateTimer(0.1, function()
			Imbattlepass:GetVengefulspiritEffect(ID)
		end)

		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(ID)

	hero.back = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/vengefulspirit/vs_ti8_immortal_shoulder/vs_ti8_immortal_shoulder.vmdl"})
	hero.back:FollowEntity(hero, true)

	hero.magic_missile_effect = "particles/econ/items/vengeful/vs_ti8_immortal_shoulder/vs_ti8_immortal_magic_missle.vpcf"

	local particle = "vs_ti8_immortal_shoulder_ambient"	
	ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, hero.back)
end

function Imbattlepass:GetPudgeArcanaEffect(ID, arcana_type)
	if PlayerResource:GetSelectedHeroEntity(ID) == nil then
		Timers:CreateTimer(0.1, function()
			Imbattlepass:GetPudgeArcanaEffect(ID, arcana_type)
		end)

		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(ID)

	if arcana_type then
		hero:SetModel("models/items/pudge/arcana/pudge_arcana_base.vmdl")
		hero:SetOriginalModel("models/items/pudge/arcana/pudge_arcana_base.vmdl")
		hero:SetMaterialGroup(tostring(arcana_type))
		hero.pudge_arcana = arcana_type

		hero.back = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/pudge/arcana/pudge_arcana_back.vmdl"})
		hero.back:FollowEntity(hero, true)
		hero.back:SetMaterialGroup(tostring(arcana_type))

		local particle = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_red_back_ambient.vpcf"	
		local particle2 = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_red_back_ambient_beam.vpcf"
		if arcana_type == 1 then
			particle = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_back_ambient.vpcf"
			particle2 = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_back_ambient_beam.vpcf"
		end

		ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, hero.back)
		ParticleManager:CreateParticle(particle2, PATTACH_ABSORIGIN_FOLLOW, hero.back)
		ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_arcana/pudge_arcana_ambient_flies.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)

		CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "override_hero_image", {arcana = arcana_type, hero_name = string.gsub(hero:GetUnitName(), "npc_dota_hero_", "")})
	end
end

function HasPudgeArcana(ID)
	if Imbattlepass:GetRewardUnlocked(ID) >= IMBATTLEPASS_PUDGE["pudge_arcana2"] then
		return 1
	elseif Imbattlepass:GetRewardUnlocked(ID) >= IMBATTLEPASS_PUDGE["pudge_arcana"] then
		return 0
	else
		return nil
	end
end

function Imbattlepass:GetJuggernautArcanaEffect(ID, arcana_type)
	local hero = PlayerResource:GetSelectedHeroEntity(ID)

	if hero == nil then
		Timers:CreateTimer(0.1, function()
			Imbattlepass:GetJuggernautArcanaEffect(ID, arcana_type)
		end)

		return
	end

	if arcana_type and next_reward_shown then
		hero:SetModel("models/heroes/juggernaut/juggernaut_arcana.vmdl")
		hero:SetOriginalModel("models/heroes/juggernaut/juggernaut_arcana.vmdl")
		hero:SetMaterialGroup(tostring(arcana_type))
		hero.juggernaut_arcana = arcana_type

		hero.head = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/juggernaut/arcana/juggernaut_arcana_mask.vmdl"})
		hero.head:FollowEntity(hero, true)
		hero.head:SetMaterialGroup(tostring(arcana_type))

		hero.back = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/juggernaut/armor_for_the_favorite_back/armor_for_the_favorite_back.vmdl"})
		hero.back:FollowEntity(hero, true)

		hero.arms = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/juggernaut/armor_for_the_favorite_arms/armor_for_the_favorite_arms.vmdl"})
		hero.arms:FollowEntity(hero, true)

		hero.legs = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/juggernaut/armor_for_the_favorite_legs/armor_for_the_favorite_legs.vmdl"})
		hero.legs:FollowEntity(hero, true)

		hero.weapon = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/items/juggernaut/thousand_faces_katana/thousand_faces_katana.vmdl"})
		hero.weapon:FollowEntity(hero, true)

		hero.blade_fury_effect = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_blade_fury.vpcf"

		local particle = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_ambient.vpcf"	
--		local particle2 = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_red_back_ambient_beam.vpcf"
		if arcana_type == 1 then
			hero.blade_fury_effect = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_blade_fury.vpcf"

			particle = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_ambient.vpcf"
--			particle2 = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_back_ambient_beam.vpcf"
		end

		ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, hero.head)
--		ParticleManager:CreateParticle(particle2, PATTACH_ABSORIGIN_FOLLOW, hero.back)
--		ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_arcana/pudge_arcana_ambient_flies.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)

		CustomGameEventManager:Send_ServerToPlayer(hero:GetPlayerOwner(), "override_hero_image", {arcana = arcana_type, hero_name = string.gsub(hero:GetUnitName(), "npc_dota_hero_", "")})
	end
end

function HasJuggernautArcana(ID)
if next_reward_shown == false then return nil end

	if Imbattlepass:GetRewardUnlocked(ID) >= IMBATTLEPASS_JUGGERNAUT["juggernaut_arcana2"] then
		return 1
	elseif Imbattlepass:GetRewardUnlocked(ID) >= IMBATTLEPASS_JUGGERNAUT["juggernaut_arcana"] then
		return 0
	else
		return nil
	end
end

-- override pick screen and top bar image
function Imbattlepass:BattlepassCheckArcana()
	for i = 0, PlayerResource:GetPlayerCount() - 1 do
		local arcana = {}
		arcana["npc_dota_hero_juggernaut"] = HasJuggernautArcana(i)
		arcana["npc_dota_hero_pudge"] = HasPudgeArcana(i)

		CustomNetTables:SetTableValue("battlepass", tostring(i), {arcana = arcana})
	end
end
