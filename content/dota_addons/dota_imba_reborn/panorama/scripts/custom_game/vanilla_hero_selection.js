var count = 0;
var herolist = CustomNetTables.GetTableValue('hero_selection', 'herolist')
var herocard = FindDotaHudElement('GridCore');
var total = herocard.GetChildCount();
var picked_heroes = []

function FindDotaHudElement(sElement) {
	return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(sElement);
}

function InitHeroSelection()  {
	for(var i = 0; i < total; i++) {
		$.Schedule((0.02 * i), UpdateHero);
	}
}

function UpdateHero() {
	var hero_image_panel;

	if (herocard.GetChild(count) != null) {
		hero_image_panel = herocard.GetChild(count).FindChildTraverse("HeroImage");
	}

	if (hero_image_panel != undefined) {
		hero_image_panel.GetParent().style.visibility = "visible";
		for (hero in herolist.hotdisabledlist) {
			if (hero == "npc_dota_hero_" + hero_image_panel.heroname) {
				if (hero_image_panel.GetParent()) {
					hero_image_panel.GetParent().GetParent().FindChildTraverse("BannedOverlay").style.opacity = "1";
					hero_image_panel.GetParent().GetParent().AddClass("Unavailable")
					hero_image_panel.GetParent().GetParent().AddClass("Banned")
					hero_image_panel.GetParent().GetParent().SetPanelEvent("onmouseover", function(){});
					hero_image_panel.GetParent().GetParent().SetPanelEvent("onactivate", function(){});
					CheckForBannedHero();
					count++;
					return;
				}
			}
		}

		for (hero in herolist.imbalist) {
			if (hero == "npc_dota_hero_" + hero_image_panel.heroname) {
				hero_image_panel.GetParent().AddClass("IMBA_HeroCard");
				hero_image_panel.GetParent().style.boxShadow = "inset #FF7800aa 0 0 30px 0";
				break;
			}
		}

		for (hero in herolist.customlist) {
			if (hero == "npc_dota_hero_" + hero_image_panel.heroname) {
				hero_image_panel.GetParent().AddClass("IMBA_HeroCard");
				hero_image_panel.GetParent().style.boxShadow = "inset purple 0 0 30px 0";
				break;
			}
		}
	}

	count++;
}

function OnUpdateHeroSelectionDirty() {
	CheckForBannedHero();
}

function OnUpdateHeroSelectionRepeat() {
	OnUpdateHeroSelection();
	CheckForBannedHero();
//	$.Schedule(1.0, OnUpdateHeroSelection); // iteration last longer, find another way
}

function OnUpdateHeroSelection() {
	picked_heroes = []

	for(var i = 0; i < 19; i++)
	{
		if (Game.GetPlayerInfo(i)) {
			picked_heroes[i] = Game.GetPlayerInfo(i).player_selected_hero;
		}
	}

	$.Msg("Start hero picked update...")

	count = 0;

	for(var i = 0; i < total; i++)
	{
		UpdatePickedHeroes();
	}

	count = 0;
}

function UpdatePickedHeroes() {
	var hero_image_panel;

	if (herocard.GetChild(count) != null) {
		hero_image_panel = herocard.GetChild(count).FindChildTraverse("HeroImage");
	}

	if (hero_image_panel != undefined) {
		for(var i = 0; i < picked_heroes.length; i++)
		{
			if (picked_heroes[i] == "npc_dota_hero_" + hero_image_panel.heroname) {
				if (hero_image_panel.GetParent()) {
					$.Msg(picked_heroes[i] + " Has been disabled!")
					hero_image_panel.GetParent().GetParent().FindChildTraverse("BannedOverlay").style.opacity = "0";
					hero_image_panel.GetParent().GetParent().AddClass("Unavailable")
					hero_image_panel.GetParent().GetParent().RemoveClass("Banned")
					hero_image_panel.GetParent().GetParent().SetPanelEvent("onmouseover", function(){});
					hero_image_panel.GetParent().GetParent().SetPanelEvent("onactivate", function(){});
					count++;
					return;
				}
			}
		}
	}

	count++;
}

/*
[PanoramaScript] Start hero picked update...
[PanoramaScript] Start hero picked update...
[PanoramaScript] npc_dota_hero_gyrocopter Has been disabled!
[PanoramaScript] Start hero picked update...
[PanoramaScript] npc_dota_hero_gyrocopter Has been disabled!
[PanoramaScript] Start hero picked update...
[PanoramaScript] npc_dota_hero_gyrocopter Has been disabled!
*/

function CheckForBannedHero() {
	var pick_button = FindDotaHudElement("LockInButton");

	if (pick_button) {
		var hero_tooltip = pick_button.FindChildrenWithClassTraverse("PickButtonHeroName")[0].text.toLowerCase();

		hero_tooltip = hero_tooltip.replace(" ", "_");

		if (hero_tooltip.search(" (imba)"))
			hero_tooltip = hero_tooltip.replace(" (imba)", "");

		for (hero in herolist.hotdisabledlist) {
			hero = hero.replace("npc_dota_hero_", "");
			if (hero_tooltip.search(hero) == 0) {
				pick_button.style.opacity = "0";
				return;
			} else {
				pick_button.style.opacity = "1";
			}
		}

		for (hero in picked_heroes) {
			hero = hero.replace("npc_dota_hero_", "");
			if (hero_tooltip.search(hero) == 0) {
				pick_button.style.opacity = "0";
				return;
			} else {
				pick_button.style.opacity = "1";
			}
		}
	}
}

(function() {
	var PreGame = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("PreGame")
	PreGame.style.opacity = "1";

	$.Schedule(1.0, InitHeroSelection);
	$.Schedule(1.0, OnUpdateHeroSelection);

	GameEvents.Subscribe("dota_player_hero_selection_dirty", OnUpdateHeroSelectionDirty);
	GameEvents.Subscribe("dota_player_update_hero_selection", OnUpdateHeroSelectionRepeat);
})();