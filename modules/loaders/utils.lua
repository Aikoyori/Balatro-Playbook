-- copied from breeze https://discord.com/channels/1116389027176787968/1337300709602754611/1337705824859979817
Playbook.save_config = function(e)
  local status, err = pcall(SMODS.save_mod_config,AKYRS)
  if status == false then
      sendErrorMessage("Failed to perform a manual mod config save.", 'Iroyokia\'s Playbook') -- sorry 
  end
end