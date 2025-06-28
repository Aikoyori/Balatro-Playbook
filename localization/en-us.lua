return {
    descriptions = {
        Back={},
        Blind={},
        Edition={},
        Enhanced={},
        Joker={
            j_playbook_triangle_ii = {
                name = "Triangle II",
                text = {
                    {
                        "If discarded hand is a {C:attention}Three of a Kind{}, for each discarded card --",
                        "If there is an {C:attention}empty consumeable slot{}, create a {C:attention}Colour Card{},",
                        "otherwise {C:attention}add one round{} to each Colour Card",
                    },
                    {
                        "If played hand is a {C:attention}Three of a Kind{}, Colour Cards give {X:dark_edition,C:white}\\{n\\}#1#{} Mult,",
                        "where {C:attention}n{} is {X:dark_edition,C:white}log_#2#(A){}, where A is the {C:attention}number of triggers that Colour card{} has",
                    },
                    {
                        "Soul Art by {C:red}notmario"
                    }
                }
            },
            j_playbook_ramina_rogers = {
                name = "Ramina Rogers",
                text = {
                    {
                        "This Joker gains {C:purple,X:edition} ^^^^1 {} Mult",
                        "after #2# {C:inactive}(#3#){C:attention} consecutive{} hands",
                        "are played which contains {C:attention}NO{} Enhancement, Seals, or Edition",
                        "Requirements {C:attention}increases{} by 1 every time this Joker is {C:attention}upgraded{}",
                        "{C:inactive}(Currently {C:purple,X:edition} ^^^^#1# {C:inactive} Mult{C:inactive})",
                    },
                    {
                        "{E:1,C:green}She{E:1} asked for nothing. The universe answered."
                    },
                    {
                        "Soul Art by {C:red}Aikoyori",
                        "Character by {C:green}Remedy Reverie",
                    }
                }
            },
            j_playbook_joh = {
                name = "joh",
                text = {
                    {
                        "{C:red}+#1#{} Mult",
                    },
                    {
                        "Art by {C:red}Aikoyori",
                        "Art Concept by {C:green}superbread",
                    }
                }
            },
            j_playbook_hph = {
                name = "Heaven{f:akyrs_NotoEmoji}🃏",
                text = {
                    {
                        "Enables a new {C:attention}Deck{} to store cards",
                        "Cards in this area {C:attention}triggers{} as normal, in order.",
                        "{C:inactive}(Click the Joker to toggle){}"
                    },
                    {
                        "Also plays {C:red,f:5}テトリス{} by {f:5,C:attention}柊マグネタイト{}",
                    },
                    {
                        "Soul Art by {C:red}Heaven{f:akyrs_NotoEmoji,C:red}🃏",
                    }
                }
            },
            j_playbook_sad_joker = {
                name = "Sad Joker (Junchbo)",
                text = {
                    {
                        "{C:red}Prevents death{} if you",
                        "{C:purple}score{} more than the blind requirements",
                    },
                    {
                        "Sprite by {C:green}Th30ne"
                    }
                }
            },
            j_playbook_hyperrealistic_scary_joker = {
                name = "Hyperrealisticly Scary Joker",
                text = {
                    {
                        "Played {C:attention}face{} cards",
                        "give {C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                        "when scored",
                    },
                    {
                        "Sprite by {C:green}Th30ne"
                    }
                }
            },
            j_playbook_smeared_joker = {
                name = "{f:5}real{} Smeared Joker",
                text = {
                    {
                        "Played {C:spades}Spades{} gain",
                    },
                    {
                        "Sprite by {C:green}Astro"
                    }
                }
            },
            j_playbook_mysthaps = {
                name = "Mysthaps",
                text = {
                    {
                        "This Joker gains {C:white,X:mult} X#1# {} Mult if played hand",
                        "contains {C:attention}Four of a Kind{}",
                        "Additionally, if cards held in hand contains {C:attention}at least{}",
                        "Two {C:attention}Pair{}s, Double it and give it to the next Joker",
                        "In addition to that, also gain {C:money}$#2#{} at the end of the round",
                        "If you have discarded a {C:attention}Flush of {C:hearts}Hearts{} {C:inactive}[{V:1,f:5}#4#{}{C:inactive}]{} this Ante",
                        "Lastly, scored {C:attention}Aces of {C:clubs}Clubs{} converts a",
                        "consumable into {C:purple}Eternal {C:playbook_playful}Playful{} Joker",
                        "{C:inactive}(Currently {C:white,X:mult} X#3# {C:inactive} Mult)",
                    },
                    {
                        "OC of {C:green}Mysthaps",
                        "Soul Art by {C:red}Aikoyori",
                    }
                }
            },
        },
        Other={},
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_playbook_triggered = "Triggered!",
            k_playbook_playful = "Playful",
            k_playbook_the = "the",
            k_playbook_sad_saved = "Saved by Junchbo."
        },
        high_scores={},
        labels={
            k_playbook_playful = "Playful",
            k_playbook_the = "the",
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}
