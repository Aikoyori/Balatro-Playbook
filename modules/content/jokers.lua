SMODS.Joker{
    key = "triangle_ii",
    atlas = "playbook_playbooksprites",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    blueprint_compat = true,
    config = {
        extras = {
            factor = 3,
            log = 3,
        }
    },
    rarity = 'playbook_playful',
    cost = 5000,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.factor,
                card.ability.extras.log
            }
        }
    end,
    calculate = function (self, card, context)
        -- first part of the effect, creating colour cards
        if context.pre_discard and not context.hook then
            local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if text == "Three of a Kind" then
                for _,_c1 in ipairs(G.hand.highlighted) do
                    if #G.consumeables.cards >= G.consumeables.config.card_limit then
                        SMODS.calculate_effect(
                        {
                            message = localize("k_playbook_triggered"),
                            func = function ()
                                Playbook.more_fluff_ease_round(1)
                            end
                        }
                        ,_c1)
                    else
                        
                        SMODS.calculate_effect(
                        {
                            message = localize("k_playbook_triggered"),
                            func = function ()
                                SMODS.add_card({set = "Colour"})
                            end
                        }
                        ,_c1)
                    end
                end
            end
        end
        if context.joker_main and context.scoring_hand == "Three of a Kind" then
            for _,cc in ipairs(G.consumeables.cards) do
                local logged = to_big(cc.ability.val).log 
                and to_big(cc.ability.val):log(card.ability.extras.log) 
                or to_big(cc.ability.val):logBase(to_big(card.ability.extras.log))
                if cc.ability.set == "Colour" then
                    SMODS.calculate_effect({
                        hypermult = {to_number(logged:floor()),card.ability.extras.factor}
                    }, cc)
                end
            end

        end
    end,
}

SMODS.Joker{
    key = "ramina_rogers",
    atlas = "playbook_playbooksprites",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    blueprint_compat = true,
    perishable_compat = false,
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
    end,
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
    end,
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
        G.playbook_extra.states.visible = false
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
    end,
}


SMODS.Joker{
    key = "sad_joker",
    atlas = "playbook_playbooksprites",
    pos = { x = 7, y = 0 },
    rarity = "playbook_the",
    config = {
        extras = {
        }
    },
    calculate = function (self, card, context)
        if context.end_of_round and G.GAME.chips > G.GAME.blind.chips then
            return {
                saved = localize("k_playbook_sad_saved")
            }
        end
    end
}

SMODS.Joker{
    key = "hyperrealistic_scary_joker",
    atlas = "playbook_playbooksprites",
    pos = { x = 8, y = 0 },
    rarity = "playbook_the",
    blueprint_compat = true,
    config = {
        extras = {
            chips = 30,
            mult = 5,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.chips,
                card.ability.extras.mult,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                chips = card.ability.extras.chips,
                mult = card.ability.extras.mult,
            }
        end
    end
}
SMODS.Joker{
    key = "smeared_joker",
    atlas = "playbook_playbooksprites",
    pos = { x = 9, y = 0 },
    rarity = "playbook_the",
    blueprint_compat = true,
    config = {
        extras = {
            mult = 5,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.mult,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
            return {
                message_card = context.other_card,
                func = function ()
                    context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extras.mult
                end,
                message = localize("k_upgrade_ex")
            }
        end
    end
}
SMODS.Joker{
    key = "mysthaps",
    atlas = "playbook_playbooksprites",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    rarity = "playbook_playful",
    blueprint_compat = true,
    cost = 5000,
    config = {
        extras = {
            xmult_g = 1,
            xmult = 1,
            cash = 5,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.xmult_g,
                card.ability.extras.cash,
                card.ability.extras.xmult,
                G.GAME.playbook_flush_of_hearts_discarded_this_ante and "○" or "×",
                colours = {
                    G.GAME.playbook_flush_of_hearts_discarded_this_ante and G.C.GREEN or G.C.RED
                }
            }
        }
    end,
    calculate = function (self, card, context)
        if context.before then
            if next(context.poker_hands["Four of a Kind"]) then
                SMODS.calculate_effect({
                    func = function ()
                        card.ability.extras.xmult = card.ability.extras.xmult + card.ability.extras.xmult_g
                    end,
                    message = localize("k_upgrade_ex")
                },card)
            end
        end
        if context.joker_main then
            local ind = AKYRS.find_index(card.area.cards,card)
            if ind < #card.area.cards and card.area.cards[ind+1] then
                local ccdd = card.area.cards[ind+1]
                SMODS.calculate_effect({
                    func = function ()
                        local hand_poker_hand = evaluate_poker_hand(G.hand.cards)
                        if #hand_poker_hand["Pair"] >= 2 then
                            if card.area then
                                SMODS.calculate_effect({
                                    xmult = 2 * card.ability.extras.xmult
                                }, ccdd)
                            end
                        end
                    end,
                    message = localize("k_upgrade_ex")
                },card)
            end
        end
        if context.end_of_round and context.cardarea == card.area and G.GAME.playbook_flush_of_hearts_discarded_this_ante then
            return {
                dollars = card.ability.extras.cash
            }
        end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and context.other_card:is_suit("Clubs") then
            return {
                juice_card = nil,
                func = function()
                    local x = {}
                    local y = {}
                    for _, _cr in ipairs(G.consumeables.cards) do
                        if _cr.ability.consumeable then
                            table.insert(x, _cr)
                        end
                    end
                    for _, _cr in ipairs(G.P_CENTER_POOLS.Joker) do
                        if _cr.rarity == "playbook_playful" then
                            table.insert(y, _cr)
                        end
                    end
                    if next(x) and next(y) then
                        SMODS.calculate_effect({
                            message = localize("k_upgrade_ex"),
                            func = function ()
                                local realc = pseudorandom_element(x, pseudoseed("myst_playbook"))
                                local real_j = pseudorandom_element(y, pseudoseed("myst_playbook_rarity"))
                                if realc then
                                    AKYRS.simple_event_add(
                                        function()
                                            realc:flip()
                                            play_sound("card1")
                                            return true
                                        end
                                    )
                                    AKYRS.simple_event_add(
                                        function()
                                            realc:flip()
                                            realc:set_ability(real_j)
                                            realc.ability.eternal = true
                                            return true
                                        end
                                    )
                                end
                            end
                        },card)
                    end
                end
            }
        end
    end
}
