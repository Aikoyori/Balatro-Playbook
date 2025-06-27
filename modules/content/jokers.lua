SMODS.Joker{
    key = "triangle_ii",
    atlas = "playbook_playbooksprites",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    blueprint_compat = true,
    config = {
        extras = {
            eeemult = 333      
        }
    },
    rarity = 'playbook_playful',
    cost = 5000,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.eeemult
            }
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                eeemult = card.ability.extras.eeemult
            }
        end
    end
}

SMODS.Joker{
    key = "ramina_rogers",
    atlas = "playbook_playbooksprites",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    blueprint_compat = true,
    config = {
        immutable = {
            hands_needed = 1,
            hands_current = 0,
        },
        extras = {
            hypermult = 2      
        }
    },
    rarity = 'playbook_playful',
    cost = 5000,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.hypermult,
                card.ability.immutable.hands_needed,
                card.ability.immutable.hands_current,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.before then
            local no_cards_are_enhanced_at_all = true
            for _,cds in ipairs(G.play.cards) do
                if not (cds.config.center_key == "c_base" and not cds.edition and not cds.seal) then
                    no_cards_are_enhanced_at_all = false
                    break
                end
            end
            if no_cards_are_enhanced_at_all then
                SMODS.calculate_effect( {
                    message = localize("k_playbook_triggered"),
                    func = function ()
                        card.ability.immutable.hands_current = card.ability.immutable.hands_current + 1
                    end
                }, card)
            else
                return {
                    message = localize("k_reset"),
                    func = function ()
                        card.ability.extras.hands_current = 0
                    end
                }
            end
            if card.ability.immutable.hands_needed == card.ability.immutable.hands_current then
                return {
                    message = localize("k_upgrade_ex"),
                    func = function ()
                        card.ability.immutable.hands_current = 0
                        card.ability.immutable.hands_needed = card.ability.immutable.hands_needed + 1
                        card.ability.extras.hypermult = card.ability.extras.hypermult + 1
                    end
                }
            end
        end
        if context.joker_main then
            return {
                hypermult = {4,card.ability.extras.hypermult}
            }
        end
    end
}

SMODS.Joker{
    key = "joh",
    atlas = "playbook_playbooksprites",
    pos = { x = 4, y = 0 },
    blueprint_compat = true,
    config = {
        extras = {
            mult = 4
        }
    },
    rarity = 'playbook_the',
    cost = 3,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.mult
            }
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extras.mult
            }
        end
    end
}

SMODS.Joker{
    key = "hph",
    atlas = "playbook_playbooksprites",
    pos = { x = 5, y = 0 },
    soul_pos = { x = 6, y = 0 },
    blueprint_compat = true,
    config = {
        extras = {
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.playbook_extra.states.collide.can = true
        G.playbook_extra.states.visible = true
        AKYRS.simple_event_add(
        function()
            G.GAME.playbook_hph = #SMODS.find_card("j_playbook_hph",true)
            return true
        end, 0)
    end,
    remove_from_deck = function (self, card, from_debuff)
        
        AKYRS.simple_event_add(
        function()
            G.GAME.playbook_hph = #SMODS.find_card("j_playbook_hph",true)
            if G.GAME.playbook_hph < 1 then
                G.playbook_extra.states.collide.can = false
                G.playbook_extra.states.visible = false
                for _,cr in ipairs(G.playbook_extra.cards) do
                    if cr.ability.consumeable then
                        draw_card(G.playbook_extra,G.consumeables,nil,nil,false,cr)
                    elseif cr.ability.set == "Joker" then
                        draw_card(G.playbook_extra,G.jokers,nil,nil,false,cr)
                    else
                        draw_card(G.playbook_extra,G.deck,nil,nil,false,cr)
                    end
                end
            end
            return true
        end, 0)
    end,
    rarity = 'playbook_playful',
    cost = 5000,
    loc_vars = function (self, info_queue, card)
        return {
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                --mult = card.ability.extras.mult
            }
        end
    end
}
