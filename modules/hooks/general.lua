
local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.playbook_hph = 0
    return ret
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
    if self.config.center_key == "j_playbook_hph" and self.states.drag.is then
        G.playbook_extra:set_role{role_type = "Minor", xy_bond = "Strong", major = self, offset = { x = -1 , y = 3}}
    end
    return cardUpdateHook(self,dt)
end

local strun = Game.start_run
function Game:start_run(args)
    local x = {strun(self,args)}
    if G.GAME.playbook_hph > 0 then
        G.playbook_extra.states.collide.can = true
        G.playbook_extra.states.visible = true
    end
    return unpack(x)
end