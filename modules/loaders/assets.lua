SMODS.Atlas{
    key = "playbooksprites",
    path = "playbooksprites.png",
    px = 71,
    py = 95,
}

SMODS.Sound{
    key = "music_tetoris",
    path = "tetoris.ogg",
    select_music_track = function (self)
        return next(SMODS.find_card("j_playbook_hph")) and 1e10 or nil
    end,
    pitch = 1,
}