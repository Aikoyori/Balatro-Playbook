Playbook = SMODS.current_mod

if Cryptid then
    Cryptid.mod_whitelist["Playbook"] = true
end
-- i love jonh debugpkus
assert(SMODS.current_mod.lovely, "Lovely patches were not loaded.\nMake sure your mod folder is not nested (there should be a bunch of files in the mod folder and not just another folder).")


assert(SMODS.load_file("./modules/loaders/assets.lua"))()
assert(SMODS.load_file("./modules/loaders/colours.lua"))()

assert(SMODS.load_file("./modules/content/rarity.lua"))()
assert(SMODS.load_file("./modules/content/jokers.lua"))()