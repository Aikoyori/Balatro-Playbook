-- copied from breeze https://discord.com/channels/1116389027176787968/1337300709602754611/1337705824859979817
Playbook.save_config = function(e)
  local status, err = pcall(SMODS.save_mod_config,AKYRS)
  if status == false then
      sendErrorMessage("Failed to perform a manual mod config save.", 'Iroyokia\'s Playbook') -- sorry 
  end
end

Playbook.more_fluff_ease_round = function(base_count)
  for _,_card in ipairs(G.consumeables.cards) do
    for j = 1, base_count do
      -- all of them that go up over time
      if _card.ability.upgrade_rounds then
        _card.ability.partial_rounds = _card.ability.partial_rounds + 1
        local upgraded = false
        while _card.ability.partial_rounds >= _card.ability.upgrade_rounds do
          upgraded = true
          _card.ability.val = _card.ability.val + 1
          if _card.ability.val >= 10 then
            check_for_unlock({ type = 'mf_ten_colour_rounds' })
          end
          _card.ability.partial_rounds = _card.ability.partial_rounds - _card.ability.upgrade_rounds

          if _card.ability.name == "col_Yellow" then
            _card.ability.extra_value = _card.ability.extra_value + _card.ability.value_per
            _card:set_cost()
            card_eval_status_text(_card, 'extra', nil, nil, nil, {
              message = localize('k_val_up'),
              colour = G.C.MONEY,
              card = _card
            })
          else
            card_eval_status_text(_card, 'extra', nil, nil, nil, {
              message = localize('k_upgrade_ex'),
              colour = G.C.SECONDARY_SET.ColourCard,
              card = _card
            })
          end
        end
        if not upgraded then
          local str = _card.ability.partial_rounds .. '/' .. _card.ability.upgrade_rounds
          card_eval_status_text(_card, 'extra', nil, nil, nil, {
            message = str,
            colour = G.C.SECONDARY_SET.ColourCard,
            card = _card
          })
        end
      end
    end
  end
end
