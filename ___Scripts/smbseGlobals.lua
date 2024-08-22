local smbseGlobals = {}

-- [----------------]
-- |GLOBAL CONSTANTS|
-- [----------------]

-- Start off by creating a global table dedicated for SMBSE-related variables
_G.SMBSE = {}

-- And then, create tables for many categories
SMBSE.Directories = {}
SMBSE.Symbols = {}

SMBSE.Resolutions = {}
SMBSE.Resolutions.Screen = {}
SMBSE.Resolutions.Types = {}
SMBSE.Resolutions.Counters = {}

SMBSE.Indicators = {}
SMBSE.Indicators.SaveData = {}

SMBSE.Counts = {}
SMBSE.Counts.Min = {}
SMBSE.Counts.Max = {}
SMBSE.Counts.NumberOf = {}

-- Number of things to use with levels/worlds
SMBSE.Counts.NumberOf.VanillaCharacters = 5
SMBSE.Counts.NumberOf.X2Characters = 16
SMBSE.Counts.NumberOf.Characters = 2
SMBSE.Counts.NumberOf.States = 7
SMBSE.Counts.NumberOf.VanillaSounds = 91
SMBSE.Counts.NumberOf.Sounds = 91 -- Will increase to the extraSounds count later

-- Maximum values a level/world can have
SMBSE.Counts.Max.LocalPlayers = 2
SMBSE.Counts.Max.SaveSlots = 32767
SMBSE.Counts.Max.VanillaStars = 1000
SMBSE.Counts.Max.Stars = 9999 -- Used for the new star system

SMBSE.Counts.Max.Blocks = 20000
SMBSE.Counts.Max.Players = 200
SMBSE.Counts.Max.Effects = 1000
SMBSE.Counts.Max.NPCs = 5000
SMBSE.Counts.Max.Warps = 2000
SMBSE.Counts.Max.Backgrounds = 4000
SMBSE.Counts.Max.Water = 1000
SMBSE.Counts.Max.Quicksand = 1000
SMBSE.Counts.Max.WorldLevels = 400
SMBSE.Counts.Max.WorldPaths = 2000
SMBSE.Counts.Max.WorldMusic = 1000
SMBSE.Counts.Max.Sections = 20
SMBSE.Counts.Max.Tiles = 20000
SMBSE.Counts.Max.Scenes = 5000

local frameBufferWidth, frameBufferHeight = Graphics.getMainFramebufferSize()

-- Resolution
SMBSE.Resolutions.Screen.Width = frameBufferWidth
SMBSE.Resolutions.Screen.Height = frameBufferHeight

-- Save data indicators
SMBSE.Indicators.SaveData.Root = 1
SMBSE.Indicators.SaveData.Progression = 2
SMBSE.Indicators.SaveData.Audio = 3
SMBSE.Indicators.SaveData.Hud = 4
SMBSE.Indicators.SaveData.HudHP = 5
SMBSE.Indicators.SaveData.Settings = 6

-- Resolve paths
SMBSE.Directories.Music = "___Sounds/__Music/"
SMBSE.Directories.SFX = "___Sounds/_Sound Effects/"
SMBSE.Directories.Scripts = "___Scripts/"
SMBSE.Directories.Fonts = "__Fonts/"

-- Emoji symbol constants
SMBSE.Symbols.MoneyBag = "💰"
SMBSE.Symbols.Coin = "🪙"
SMBSE.Symbols.Clock = "🕒"

-- Resolution-related things
SMBSE.Resolutions.Types.Fullscreen = 1
SMBSE.Resolutions.Types.SteamDeck = 2
SMBSE.Resolutions.Types.Widescreen = 3
SMBSE.Resolutions.Types.UltraWide = 4
SMBSE.Resolutions.Types.SuperWide = 5
SMBSE.Resolutions.Types.CustomWidth = 6

SMBSE.Resolutions.Counters.MinimumWidth = 800
SMBSE.Resolutions.Counters.MaximumWidth = 2200

return smbseGlobals