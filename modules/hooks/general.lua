
local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.playbook_hph = 0
    ret.playbook_flush_of_hearts_discarded_this_ante = false
    ret.playbook_last_ante = nil
    return ret
end

SMODS.current_mod.reset_game_globals = function (run_start)
    
    if G.GAME.playbook_last_ante ~= G.GAME.round_resets.ante then
        G.GAME.playbook_flush_of_hearts_discarded_this_ante = false
        G.GAME.playbook_last_ante = G.GAME.round_resets.ante
    end
end

local cfc = AKYRS.card_conf_any_drag 
AKYRS.card_conf_any_drag = function(area, card)
    if card.area and card.area == G.playbook_extra then
        if card.ability.consumeable and area == G.consumeables then
            return true
        elseif card.ability.set == "Joker" and area == G.jokers then
            return true
        elseif area == G.deck or area == G.hand then
            return true
        end
    end
    return cfc(area, card)
end

local cardUpdateHook = Card.update
function Card:update(dt)
    self.playbook_click_delay = math.max((self.playbook_click_delay or 0) - dt, 0)
    if self.config.center_key == "j_playbook_hph" and self.states.drag.is and G.playbook_extra then
        G.playbook_extra:set_role{role_type = "Minor", xy_bond = "Strong", major = self, offset = { x = -G.playbook_extra.T.w/2 + 1, y = 3}}
    end
    local x = {cardUpdateHook(self,dt)}
    return unpack(x)
end

local cardClickHook = Card.click
function Card:click()
    if self.config.center_key == "j_playbook_hph" and G and G.GAME then
        if self.states.drag.is and G.playbook_extra then
            G.playbook_extra:set_role{role_type = "Minor", xy_bond = "Strong", major = self, offset = { x = -G.playbook_extra.T.w/2 + 1, y = 3}}
        end
    end
    self.playbook_click_delay = self.playbook_click_delay + 10

    local x = {cardClickHook(self)}
    
    if self.config.center_key == "j_playbook_hph" and G and G.GAME and G.playbook_extra then
        G.playbook_extra.states.visible = self.highlighted
    end
    return unpack(x)
end

local strun = Game.start_run
function Game:start_run(args)
    local x = {strun(self,args)}
    if G.GAME.playbook_hph > 0 and G.playbook_extra then
        G.playbook_extra.states.collide.can = true
    end
    return unpack(x)
end

local evalc_h = eval_card
function eval_card(c,ctx)
    c.ability.playbook_triggers = (c.ability.playbook_triggers or 0) + 1
    local x = {evalc_h(c,ctx)}
    return unpack(x)
end

local disc = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function (e1,e2)
    table.sort(G.hand.highlighted, function(a,b) return a.T.x < b.T.x end)
    
    local hand_poker_hand = evaluate_poker_hand(G.hand.highlighted)
    for _,p in ipairs(hand_poker_hand["Flush"]) do
        local fohl = true
        for _,dcard in ipairs(p) do
            if not dcard:is_suit("Hearts") then
                fohl = false
            end
        end
        if fohl then
            G.GAME.playbook_flush_of_hearts_discarded_this_ante = true
            break
        end
    end
    return disc(e1,e2)
end