local smbseFunctionsTables = {}

-- Table variable sorting
smbseFunctionsTables.regular = smbseFunctionsTables.regular or {}
smbseFunctionsTables.mapped = smbseFunctionsTables.mapped or {}

smbseFunctionsTables.regular.sounds = smbseFunctionsTables.regular.sounds or {}
smbseFunctionsTables.regular.levels = smbseFunctionsTables.regular.levels or {}
smbseFunctionsTables.regular.keyboard = smbseFunctionsTables.regular.keyboard or {}

smbseFunctionsTables.mapped.sounds = smbseFunctionsTables.mapped.sounds or {}
smbseFunctionsTables.mapped.levels = smbseFunctionsTables.mapped.levels or {}

-- [-- LEVEL INFO --]

-- A list of levels that suppress the loading screen SFX. This table gets checked before playing the sound
smbseFunctionsTables.regular.levels.noLoadingSFXList = {
    "SMBSE - World Map.lvlx",
    "SMBSE - Opening.lvlx",
}

-- A list of every playable level in the game, regular table version.
smbseFunctionsTables.regular.levels.allLevels = {
    "SMBSE - W-1, L-1.lvlx",
    "SMBSE - W-1, L-2.lvlx",
    "SMBSE - W-1, L-3.lvlx",
    "SMBSE - W-1, L-4.lvlx",
    "SMBSE - W-1, L-5.lvlx",
    "SMBSE - W-1, L-6.lvlx",
    "SMBSE - W-1, L-A.lvlx",
    "SMBSE - W-1, L-Castle.lvlx",
    "SMBSE - W-1, L-Tower.lvlx",
    "SMBSE - W-2, L-1.lvlx",
    "SMBSE - W-2, L-2.lvlx",
    "SMBSE - W-2, L-3.lvlx",
    "SMBSE - W-2, L-4.lvlx",
    "SMBSE - W-2, L-5.lvlx",
    "SMBSE - W-2, L-A.lvlx",
    "SMBSE - W-2, L-Castle.lvlx",
    "SMBSE - W-2, L-Tower.lvlx",
}

-- A list of every playable level in the game, table map version.
smbseFunctionsTables.mapped.levels.allLevels = table.map{
    "SMBSE - W-1, L-1.lvlx",
    "SMBSE - W-1, L-2.lvlx",
    "SMBSE - W-1, L-3.lvlx",
    "SMBSE - W-1, L-4.lvlx",
    "SMBSE - W-1, L-5.lvlx",
    "SMBSE - W-1, L-6.lvlx",
    "SMBSE - W-1, L-A.lvlx",
    "SMBSE - W-1, L-Castle.lvlx",
    "SMBSE - W-1, L-Tower.lvlx",
    "SMBSE - W-2, L-1.lvlx",
    "SMBSE - W-2, L-2.lvlx",
    "SMBSE - W-2, L-3.lvlx",
    "SMBSE - W-2, L-4.lvlx",
    "SMBSE - W-2, L-5.lvlx",
    "SMBSE - W-2, L-A.lvlx",
    "SMBSE - W-2, L-Castle.lvlx",
    "SMBSE - W-2, L-Tower.lvlx",
}

-- [-- SOUNDS --]

-- All vanilla SFX IDs
smbseFunctionsTables.mapped.sounds.vanillaSoundIDs = table.map{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91}
-- Vanilla SFX IDs not being used in extraSounds
smbseFunctionsTables.mapped.sounds.unusedVanillaSoundIDs = table.map{2,3,5,6,9,11,12,13,16,17,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,37,38,40,41,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,78,79,80,82,83,84,85,86,87,88,89,90,91}
smbseFunctionsTables.regular.sounds.soundFileList = {
    "player-jump", --1
    "stomped", --2
    "block-hit", --3
    "block-smash", --4
    "player-shrink", --5
    "player-grow", --6
    "mushroom", --7
    "player-died", --8
    "shell-hit", --9
    "player-slide", --10
    "item-dropped", --11
    "has-item", --12
    "camera-change", --13
    "coin", --14
    "1up", --15
    "lava", --16
    "warp", --17
    "fireball", --18
    "level-win", --19
    "boss-beat", --20
    "dungeon-win", --21
    "bullet-bill", --22
    "grab", --23
    "spring", --24
    "hammer", --25
    "slide", --26
    "newpath", --27
    "level-select", --28
    "do", --29
    "pause", --30
    "key", --31
    "pswitch", --32
    "tail", --33
    "racoon", --34
    "boot", --35
    "smash", --36
    "thwomp", --37
    "birdo-spit", --38
    "birdo-hit", --39
    "smb2-exit", --40
    "birdo-beat", --41
    "npc-fireball", --42
    "fireworks", --43
    "bowser-killed", --44
    "game-beat", --45
    "door", --46
    "message", --47
    "yoshi", --48
    "yoshi-hurt", --49
    "yoshi-tongue", --50
    "yoshi-egg", --51
    "got-star", --52
    "zelda-kill", --53
    "player-died2", --54
    "yoshi-swallow", --55
    "ring", --56
    "dry-bones", --57
    "smw-checkpoint", --58
    "dragon-coin", --59
    "smw-exit", --60
    "smw-blaarg", --61
    "wart-bubble", --62
    "wart-die", --63
    "sm-block-hit", --64
    "sm-killed", --65
    "sm-glass", --66
    "sm-hurt", --67
    "sm-boss-hit", --68
    "sm-cry", --69
    "sm-explosion", --70
    "climbing", --71
    "swim", --72
    "grab2", --73
    "smw-saw", --74
    "smb2-throw", --75
    "smb2-hit", --76
    "zelda-stab", --77
    "zelda-hurt", --78
    "zelda-heart", --79
    "zelda-died", --80
    "zelda-rupee", --81
    "zelda-fire", --82
    "zelda-item", --83
    "zelda-key", --84
    "zelda-shield", --85
    "zelda-dash", --86
    "zelda-fairy", --87
    "zelda-grass", --88
    "zelda-hit", --89
    "zelda-sword-beam", --90
    "bubble", --91
    "sprout-vine", --92
    "iceball", --93
    "yi-freeze", --94
    "yi-icebreak", --95
    "2up", --96
    "3up", --97
    "5up", --98
    "dragon-coin-get2", --99
    "dragon-coin-get3", --100
    "dragon-coin-get4", --101
    "dragon-coin-get5", --102
    "cherry", --103
    "explode", --104
    "hammerthrow", --105
    "combo1", --106
    "combo2", --107
    "combo3", --108
    "combo4", --109
    "combo5", --110
    "combo6", --111
    "combo7", --112
    "score-tally", --113
    "score-tally-end", --114
    "bowser-fire", --115
    "boomerang", --116
    "smb2-charge", --117
    "stopwatch", --118
    "whale-spout", --119
    "door-reveal", --120
    "p-wing", --121
    "wand-moving", --122
    "wand-whoosh", --123
    "hop", --124
    "smash-big", --125
    "smb2-hitenemy", --126
    "boss-fall", --127
    "boss-lava", --128
    "boss-shrink", --129
    "boss-shrink-done", --130
    "hp-get", --131
    "hp-max", --132
    "cape-feather", --133
    "cape-fly", --134
    "flag-slide", --135
    "smb1-exit", --136
    "smb2-clear", --137
    "smb1-world-clear", --138
    "smb1-underground-overworld", --139
    "smb1-underground-desert", --140
    "smb1-underground-sky", --141
    "goaltape-countdown-start", --142
    "goaltape-countdown-loop", --143
    "goaltape-countdown-end", --144
    "goaltape-irisout", --145
    "smw-exit-orb", --146
    "ace-coins-5", --147
    "door-close", --148
    "sprout-megashroom", --149
    "0up", --150
    "correct", --151
    "wrong", --152
    "castle-destroy", --153
    "twirl", --154
    "fireball-hit", --155
    "shell-grab", --156
    "ice-melt", --157
    "player-jump2", --158
    "ground-pound", --159
    "ground-pound-hit", --160
    "zelda-fireball", --161
    "zelda-iceball", --162
    "pballoon", --163
    "peach-cry", --164
    "timeout", --165
    "flyinghammer-throw", --166
    "fireball2", --167
    "fireball3", --168
    "fireball-hit-hammershield", --169
}

smbseFunctionsTables.regular.keyboard.map = {
    
    --[[
    
    This list was generated and carefully crafted to make sure that even a list makes things much easier to see which key is which.
    
    Note that some keys aren't on certain/most keyboards, but whoever is looking at the code I bet already knew that.
    
    See https://github.com/MicrosoftDocs/win32/blob/docs/desktop-src/inputdev/virtual-key-codes.md for where I got some of the information for this list.
    
    ]]
    
    --First 6 is mouse controls, which idk why it's part of this
    
    1, -- [1], Left mouse button
    2, -- [2], Right mouse button
    3, -- [3], Control-break processing
    4, -- [4], Middle mouse button
    5, -- [5], X1 mouse button
    6, -- [6], X2 mouse button
    7, -- [7], -Undefined-
    
    --Now we get to the juicy stuff!
    
    8, -- [8], BACKSPACE Key
    VK_TAB, -- [9], TAB Key
    10, -- [10], -Reserved-
    11, -- [11], -Reserved-
    VK_CLEAR, -- [12], CLEAR Key
    13, -- [13], ENTER Key (Also on right numberical side of common Keyboards)
    14, -- [14], -Undefined-
    15, -- [15], -Undefined-
    16, -- [16], SHIFT Key (Left & Right) (Default Drop Item Button)
    17, -- [17], CTRL Key (Left & Right)
    VK_MENU, -- [18], Alt Key (Left & Right)
    19, -- [19], PAUSE Key
    VK_CAPITAL, -- [20], CAPS Lock
    VK_KANA, -- [21], IME Kana mode
    
    --Next 5 will be blank, until we figure out which IME keys are for which
    
    22, -- [22], --TBA--
    23, -- [23], --TBA--
    24, -- [24], --TBA--
    25, -- [25], --TBA--
    26, -- [26], --TBA--
    
    --
    
    27, -- [27], ESC Key (Default Pause Button)
    
    --Next 4 will be blank, until we figure out which IME keys are for which
    
    28, -- [28], --TBA--
    29, -- [29], --TBA--
    30, -- [30], --TBA--
    31, -- [31], --TBA--
    
    --
    
    VK_SPACE, -- [32], SPACE Key
    33, -- [33], PAGE UP Key
    34, -- [34], PAGE DOWN Key
    VK_END, -- [35], END Key
    VK_HOME, -- [36], HOME Key
    
    --Arrow keys, used for moving the player on SMBX2
    
    VK_LEFT, -- [37], Left Arrow Key
    VK_UP, -- [38], Up Arrow Key
    VK_RIGHT, -- [39], Right Arrow Key
    VK_DOWN, -- [40], Down Arrow Key
    
    --
    
    41, -- [41], SELECT Key
    42, -- [42], PRINT Key
    43, -- [43], EXECUTE Key
    44, -- [44], PRINT SCREEN Key
    45, -- [45], INS Key
    46, -- [46], DEL Key
    VK_HELP, -- [47], HELP Key
    
    --Number Keys, normal keys (Like on top of the keyboard)
    
    VK_0, -- [48], 0 Key/Right parenthesis
    VK_1, -- [49], 1 Key/Exclaimation Mark
    VK_2, -- [50], 2 Key/Ampersat
    VK_3, -- [51], 3 Key/Octothorpe (Hashtag)
    VK_4, -- [52], 4 Key/Dollar Sign
    VK_5, -- [53], 5 Key/Percent
    VK_6, -- [54], 6 Key/Caret
    VK_7, -- [55], 7 Key/Ampersand
    VK_8, -- [56], 8 Key/Asterisk
    VK_9, -- [57], 9 Key/Left parenthesis
    
    --Are the next 7 keys undefined? We'll need to search this later
    
    58, -- [58], --TBA--
    59, -- [59], --TBA--
    60, -- [60], --TBA--
    61, -- [61], --TBA--
    62, -- [62], --TBA--
    63, -- [63], --TBA--
    64, -- [64], --TBA--
    
    --Letter Keys are next.
    
    VK_A, -- [65], A Key (Default Alt-Jump Button)
    VK_B, -- [66], B Key
    VK_C, -- [67], C Key
    VK_D, -- [68], D Key (Default Special Button, SMAS++)
    VK_E, -- [69], E Key
    VK_F, -- [70], F Key
    VK_G, -- [71], G Key
    VK_H, -- [72], H Key
    VK_I, -- [73], I Key
    VK_J, -- [74], J Key
    VK_K, -- [75], K Key
    VK_L, -- [76], L Key
    VK_M, -- [77], M Key
    VK_N, -- [78], N Key
    VK_O, -- [79], O Key
    VK_P, -- [80], P Key
    VK_Q, -- [81], Q Key
    VK_R, -- [82], R Key
    VK_S, -- [83], S Key (Default Alt-Run Button)
    VK_T, -- [84], T Key
    VK_U, -- [85], U Key
    VK_V, -- [86], V Key
    VK_W, -- [87], W Key
    VK_X, -- [88], X Key (Default Run Button)
    VK_Y, -- [89], Y Key
    VK_Z, -- [90], Z Key (Default Jump Button)
    
    --
    
    91, -- [91], Windows Key (Left)
    92, -- [92], Windows Key (Right)
    93, -- [93], Applications Key
    94, -- [94], -Reserved-
    95, -- [95], Computer Sleep Key
    
    --Number Keys on Numeric Keypad
    
    96, -- [96], 0 Key (Numeric Keypad)
    97, -- [97], 1 Key (Numeric Keypad)
    98, -- [98], 2 Key (Numeric Keypad)
    99, -- [99], 3 Key (Numeric Keypad)
    100, -- [100], 4 Key (Numeric Keypad)
    101, -- [101], 5 Key (Numeric Keypads)
    102, -- [102], 6 Key (Numeric Keypad)
    103, -- [103], 7 Key (Numeric Keypad)
    104, -- [104], 8 Key (Numeric Keypad)
    105, -- [105], 9 Key (Numeric Keypad)
    
    --Other Numeric Keypad Keys
    
    106, -- [106], Asterisk Key (Numeric Keypad)
    107, -- [107], Plus Key (Numeric Keypad)
    108, -- [108], Separator Key (Numeric Keypad?)
    109, -- [109], Dash (Hyphen) Key (Numeric Keypad)
    110, -- [110], Decimal Key (Numeric Keypad)
    111, -- [111], Slash/Divide Key (Numeric Keypad)
    
    --F-Keys!
    
    VK_F1, -- [112], F1 Key
    VK_F2, -- [113], F2 Key
    VK_F3, -- [114], F3 Key
    VK_F4, -- [115], F4 Key
    VK_F5, -- [116], F5 Key
    VK_F6, -- [117], F6 Key
    VK_F7, -- [118], F7 Key
    VK_F8, -- [119], F8 Key
    VK_F9, -- [120], F9 Key
    VK_F10, -- [121], F10 Key
    VK_F11, -- [122], F11 Key
    VK_F12, -- [123], F12 Key
    
    --The next 12 F-Keys are used on some keyboards but not the most common ones
    
    VK_F13, -- [124], F13 Key
    VK_F14, -- [125], F14 Key
    VK_F15, -- [126], F15 Key
    VK_F16, -- [127], F16 Key
    VK_F17, -- [128], F17 Key
    VK_F18, -- [129], F18 Key
    VK_F19, -- [130], F19 Key
    VK_F20, -- [131], F20 Key
    VK_F21, -- [132], F21 Key
    VK_F22, -- [133], F22 Key
    VK_F23, -- [134], F23 Key
    VK_F24, -- [135], F24 Key
    
    --
    
    136, -- [136], -Unassigned-
    137, -- [137], -Unassigned-
    138, -- [138], -Unassigned-
    139, -- [139], -Unassigned-
    140, -- [140], -Unassigned-
    141, -- [141], -Unassigned-
    142, -- [142], -Unassigned-
    143, -- [143], -Unassigned-
    144, -- [144], Number Lock Key
    VK_SCROLL, -- [145], Scroll Lock Key
    146, -- [146], -OEM specific-
    147, -- [147], -OEM specific-
    148, -- [148], -OEM specific-
    149, -- [149], -OEM specific-
    150, -- [150], -OEM specific-
    151, -- [151], -Unassigned-
    152, -- [152], -Unassigned-
    153, -- [153], -Unassigned-
    154, -- [154], -Unassigned-
    155, -- [155], -Unassigned-
    156, -- [156], -Unassigned-
    157, -- [157], -Unassigned-
    158, -- [158], -Unassigned-
    159, -- [159], -Unassigned-
    VK_LSHIFT, -- [160], Left SHIFT Key (Not used on SMBX2)
    VK_RSHIFT, -- [161], Right SHIFT Key (Not used on SMBX2)
    VK_LCONTROL, -- [162], Left CONTROL Key (Not used on SMBX2)
    VK_RCONTROL, -- [163], Right CONTROL Key (Not used on SMBX2)
    VK_LMENU, -- [164], Left ALT Key (Not used on SMBX2)
    VK_RMENU, -- [165], Right ALT Key (Not used on SMBX2)
    
    --Are the next 20 keys accurate? Check whenever you can
    
    166, -- [166], Browser Back Key
    167, -- [167], Browser Forward Key
    168, -- [168], Browser Refresh Key
    169, -- [169], Browser Stop Key
    170, -- [170], Browser Search Key
    171, -- [171], Browser Favorites Key
    172, -- [172], Browser Start and Home Key
    173, -- [173], Volume Mute key
    174, -- [174], Volume Down key
    175, -- [175], Volume Up key
    176, -- [176], Next Track key
    177, -- [177], Previous Track key
    178, -- [178], Stop Media key
    179, -- [179], Play/Pause Media key
    180, -- [180], Start Mail key
    181, -- [181], Select Media key
    182, -- [182], Start Application 1 key
    183, -- [183], Start Application 2 key
    184, -- [184], -Reserved-
    185, -- [185], -Reserved-
    
    --Some symbol keys
    
    186, -- [186], Colon/Semicolon (It can vary by keyboard though)
    187, -- [187], Plus/Equals
    188, -- [188], Comma/Less Than
    189, -- [189], Underscore/Dash (Hyphen)
    190, -- [190], Period/Greater Than
    191, -- [191], Question Mark/Slash (It can vary by keyboard though)
    192, -- [192], Tilde/Acute (It can vary by keyboard though)
    
    --Are the next 26 keys accurate? Check whenever you can
    
    193, -- [193], -Reserved-
    194, -- [194], -Reserved-
    195, -- [195], -Reserved-
    196, -- [196], -Reserved-
    197, -- [197], -Reserved-
    198, -- [198], -Reserved-
    199, -- [199], -Reserved-
    200, -- [200], -Reserved-
    201, -- [201], -Reserved-
    202, -- [202], -Reserved-
    203, -- [203], -Reserved-
    204, -- [204], -Reserved-
    205, -- [205], -Reserved-
    206, -- [206], -Reserved-
    207, -- [207], -Reserved-
    208, -- [208], -Reserved-
    209, -- [209], -Reserved-
    210, -- [210], -Reserved-
    211, -- [211], -Reserved-
    212, -- [212], -Reserved-
    213, -- [213], -Reserved-
    214, -- [214], -Reserved-
    215, -- [215], -Reserved-
    216, -- [216], -Unassigned-
    217, -- [217], -Unassigned-
    218, -- [218], -Unassigned-
    
    --Some other symbol keys
    
    219, -- [219], Left Brace/Left Bracket (It can vary by keyboard though)
    220, -- [220], Backslash/Pipe (It can vary by keyboard though)
    221, -- [221], Right Brace/Right Bracket (It can vary by keyboard though)
    222, -- [222], Quote/Apostrophe (It can vary by keyboard though)
    
    --The rest might need a checkup to see if all of them are correct or not
    
    223, -- [223], This can vary by keyboard
    224, -- [224], -Reserved-
    225, -- [225], -OEM specific-
    226, -- [226], <> Keys (Or \| on non-US 102-key keyboard)
    227, -- [227], -OEM specific-
    228, -- [228], -OEM specific-
    229, -- [229], IME PROCESS Key
    230, -- [230], -OEM specific-
    231, -- [231], Used to pass Unicode characters as if they were keystrokes. For more information, see VK_PACKET on link above.
    232, -- [232], -Unassigned-
    233, -- [233], -OEM specific-
    234, -- [234], -OEM specific-
    235, -- [235], -OEM specific-
    236, -- [236], -OEM specific-
    237, -- [237], -OEM specific-
    238, -- [238], -OEM specific-
    239, -- [239], -OEM specific-
    240, -- [240], -OEM specific-
    241, -- [241], -OEM specific-
    242, -- [242], -OEM specific-
    243, -- [243], -OEM specific-
    244, -- [244], -OEM specific-
    245, -- [245], -OEM specific-
    246, -- [246], -OEM specific-
    247, -- [247], Attn key
    248, -- [248], CrSel key
    249, -- [249], ExSel key
    250, -- [250], Erase EOF key
    251, -- [251], Play key
    252, -- [252], Zoom key
    253, -- [253], -Reserved-
    254, -- [254], PA1 key
    255, -- [255], Clear Key
}

return smbseFunctionsTables