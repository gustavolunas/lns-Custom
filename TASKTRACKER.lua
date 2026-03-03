local switchTaskT = "taskButton"

storage = storage or {}
local STKEY = "lnsTaskTracker"
storage[STKEY] = storage[STKEY] or {
  enabled = true,
  current = nil,
  kills = 0,
  required = 0,
  progress = {} -- salva por task
}
local st = storage[STKEY]
st.progress = st.progress or {}

-- =========================
-- TASKS
-- =========================
local TASKS = {
  goblins = { label="GOBLINS", required=100, iconId=61, creatures={ "Goblin", "Goblin Assassin", "Goblin Leader", "Goblin Scavenger" } },
  trolls = { label="TROLLS", required=100, iconId=15, creatures={ "Troll", "Swamp Troll", "Frost Troll", "Island Troll" } },
  orcs = { label="ORCS", required=250, iconId=5, creatures={ "Orc", "Orc Spearman", "Orc Warrior", "Orc Shaman", "Orc Rider", "Orc Berserker", "Orc Leader", "Orc Warlord" } },
  rotworms = { label="ROTWORMS", required=200, iconId=26, creatures={ "Rotworm", "Carrion Worm" } },
  minotaurs = { label="MINOTAURS", required=300, iconId=25, creatures={ "Minotaur", "Minotaur Archer", "Minotaur Guard", "Minotaur Mage" } },
  dwarfs = { label="DWARFS", required=300, iconId=69, creatures={ "Dwarf", "Dwarf Soldier", "Dwarf Guard", "Dwarf Geomancer" } },
  dworcs = { label="DWORCS", required=300, iconId=216, creatures={ "Dworc Venomsniper", "Dworc Voodoomaster", "Dworc Fleshhunter" } },
  elves = { label="ELVES", required=400, iconId=62, creatures={ "Elf", "Elf Scout", "Elf Arcanist", "Firestarter" } },
  darkcathedral = { label="DARK CATHEDRAL", required=500, iconId=372, creatures={ "Dark Apprentice", "Dark Magician", "Dark Monk", "Assassin", "Smuggler", "Bandit", "Wild Warrior", "Witch", "Ghost", "Hunter", "Stone Golem", "Demon Skeleton" } },
  tombs = { label="TOMBS", required=800, iconId=48, creatures={ "Ghost", "Mummy", "Ghoul", "Demon Skeleton", "Skeleton", "Crypt Shambler" } },
  scarabs = { label="SCARABS", required=600, iconId=83, creatures={ "Scarab" } },
  cyclops = { label="CYCLOPS", required=500, iconId=22, creatures={ "Cyclops", "Cyclops Drone", "Cyclops Smith" } },
  mutateds = { label="MUTATEDS", required=500, iconId=502, creatures={ "Mutated Human", "Mutated Rat", "Mutated Tiger" } },
  coryms = { label="CORYMS", required=500, iconId=916, creatures={ "Corym Charlatan", "Corym Skirmisher", "Corym Vanguard" } },
  banutasurface = { label="BANUTA SURFACE", required=500, iconId=116, creatures={ "Kongra", "Merlkin", "Sibang" } },
  pirates = { label="PIRATES", required=600, iconId=247, creatures={ "Pirate Marauder", "Pirate Cutthroat", "Pirate Corsair", "Pirate Buccaneer" } },
  barbarians = { label="BARBARIANS", required=600, iconId=323, creatures={ "Barbarian Bloodwalker", "Barbarian Brutetamer", "Barbarian Headsplitter", "Barbarian Skullhunter" } },
  djinns = { label="DJINNS", required=600, iconId=51, creatures={ "Green Djinn", "Blue Djinn", "Efreet", "Marid" } },
  stonerefiners = { label="STONEREFINERS", required=500, iconId=1525, creatures={ "Stonerefiner" } },
  dragons = { label="DRAGONS", required=500, iconId=34, creatures={ "Dragon", "Dragon Hatchling" } },
  quaras = { label="QUARAS", required=500, iconId=241, creatures={ "Quara Mantassin", "Quara Mantassin Scout", "Quara Constrictor", "Quara Constrictor Scout", "Quara Pincher", "Quara Pincher Scout", "Quara Predator", "Quara Predator Scout", "Quara Hydromancer", "Quara Hydromancer Scout" } },
  drefiacrypts = { label="DREFIA CRYPTS", required=600, iconId=975, creatures={ "Gravedigger", "Zombie", "Blood Hand", "Necromancer" } },
  ancientscarabs = { label="ANCIENT SCARABS", required=500, iconId=79, creatures={ "Ancient Scarab" } },
  giantspiders = { label="GIANT SPIDERS", required=500, iconId=38, creatures={ "Giant Spider" } },
  lagunaislands = { label="LAGUNA ISLANDS", required=500, iconId=259, creatures={ "Thornback Tortoise", "Tortoise", "Toad", "Blood Crab" } },
  oramond = { label="ORAMOND", required=1000, iconId=1052, creatures={ "Minotaur Hunter", "Mooh'Tah Warrior", "Minotaur Amazon", "Worm Priestess", "Execowtioner", "Moohtant" } },
  wyrms = { label="WYRMS", required=1000, iconId=461, creatures={ "Wyrm", "Elder Wyrm" } },
  bookworld = { label="BOOK WORLD", required=2000, iconId=2673, creatures={ "Bluebeak", "Bramble Wyrmling", "Crusader", "Hawk Hopper", "Headwalker", "Lion Hydra" } },
  cults = { label="CULTS", required=2000, iconId=1506, creatures={ "Orc Cult Fanatic", "Orc Cult Inquisitor", "Orc Cult Minion", "Orc Cult Priest", "Orc Cultist" } },
  barkless = { label="BARKLESS", required=1500, iconId=1486, creatures={ "Barkless Devotee", "Barkless Fanatic" } },
  feyristsurface = { label="FEYRIST SURFACE", required=1500, iconId=1434, creatures={ "Faun", "Dark Faun", "Nymph", "Pixie", "Pooka", "Twisted Pooka", "Swan Maiden" } },
  deeplings = { label="DEEPLINGS", required=1000, iconId=734, creatures={ "Deepling Spellsinger", "Deepling Scout", "Deepling Warrior", "Deepling Guard" } },
  wereboars = { label="WEREBOARS", required=1500, iconId=1143, creatures={ "Wereboar", "Werebear", "Werebadger", "Werefox", "Werewolf" } },
  minotaurcults = { label="MINOTAUR CULTS", required=1800, iconId=1508, creatures={ "Minotaur Cult Follower", "Minotaur Cult Prophet", "Minotaur Cult Zealot" } },
  orccults = { label="ORC CULTS", required=2000, iconId=1506, creatures={ "Orc Cult Fanatic", "Orc Cult Inquisitor", "Orc Cult Minion", "Orc Cult Priest", "Orc Cultist" } },
  feyristnightmares = { label="FEYRIST NIGHTMARES", required=2000, iconId=1442, creatures={ "Weakened Frazzlemaw", "Enfeebled Silencer" } },
  bandits = { label="BANDITS", required=3000, iconId=1119, creatures={ "Glooth Bandit", "Glooth Brigand" } },
  exotics = { label="EXOTICS", required=3500, iconId=2032, creatures={ "Exotic Cave Spider", "Exotic Bat" } },
  pirats = { label="PIRATS", required=2000, iconId=2038, creatures={ "Pirat Bombardier", "Pirat Cutthroat", "Pirat Mate", "Pirat Scoundrel" } },
  werehyaenas = { label="WEREHYAENAS", required=2000, iconId=2743, creatures={ "Werehyaena", "Werehyaena Shaman" } },
  dragonlords = { label="DRAGON LORDS", required=2500, iconId=39, creatures={ "Dragon Lord" } },
  frostdragons = { label="FROST DRAGONS", required=2500, iconId=317, creatures={ "Frost Dragon" } },
  banutadeeper = { label="BANUTA DEEPER", required=2000, iconId=570, creatures={ "Medusa", "Serpent Spawn", "Hydra", "Eternal Guardian" } },
  nightmares = { label="NIGHTMARES", required=2000, iconId=299, creatures={ "Nightmare", "Nightmare Scion" } },
  drakens = { label="DRAKENS", required=3000, iconId=673, creatures={ "Draken Abomination", "Draken Elite", "Draken Spellweaver", "Draken Warmaster", "Lizard Legionnaire", "Lizard Magistratus", "Lizard Noble", "Lizard Chosen", "Lizard Dragon Priest", "Lizard High Guard" } },
  thehive = { label="THE HIVE", required=3000, iconId=792, creatures={ "Waspoid", "Crawler", "Spitter", "Kollos", "Spidris", "Spidris Elite", "Hive Overseer" } },
  iksupan = { label="IKSUPAN", required=5000, iconId=2437, creatures={ "Iks Yapunac", "Mitmah Scout", "Mitmah Seer" } },
  carnivors = { label="CARNIVORS", required=4000, iconId=1721, creatures={ "Lumbering Carnivor", "Spiky Carnivor", "Menacing Carnivor" } },
  nightmareisles = { label="NIGHTMARE ISLES", required=3000, iconId=1015, creatures={ "Choking Fear", "Retching Horror", "Silencer" } },
  warlock = { label="WARLOCK", required=2000, iconId=10, creatures={ "Warlock" } },
}

local function norm(s)
  s = tostring(s or ""):lower()
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  s = s:gsub("%s+", " ")
  return s
end

local function smartNormalize(s)
  s = tostring(s or ""):lower()
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  s = s:gsub("^the%s+", "")        -- remove "the "
  s = s:gsub("%s+", " ")           -- limpa espaços duplicados

  if s:sub(-1) == "s" then
    s = s:sub(1, -2)
  end

  return s
end


local function parseHunt(text)
  local msg = tostring(text or "")
  local hunt = msg:match("[Yy]our hunt for%s+([%a%s']+)%s+has begun")
  if not hunt then return nil end

  local normalizedHunt = smartNormalize(hunt)

  for key, cfg in pairs(TASKS) do
    -- compara com key
    if smartNormalize(key) == normalizedHunt then
      return key
    end

    -- compara com label
    if smartNormalize(cfg.label) == normalizedHunt then
      return key
    end
  end

  return nil
end

-- =========================
-- UI PRINCIPAL
-- =========================
taskInterface = setupUI([=[
UIWindow
  size: 250 100
  opacity: 0.95

  Panel
    anchors.fill: parent
    background-color: #0b0b0b
    border: 1 #3b2a10

  Panel
    id: topBar
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 25
    background-color: #111111

  Label
    id: title
    anchors.centerIn: topBar
    text: [LNS] Task Tracker
    color: orange
    font: verdana-11px-rounded
    text-auto-resize: true

  Button
    id: minimize
    anchors.top: prev.top
    anchors.right: parent.right
    margin-right: 10
    size: 30 15
    text: -
    font: verdana-11px-rounded
    color: orange
    image-source: /images/ui/button_rounded
    image-color: #2a2a2a

  TextList
    id: taskList
    anchors.top: topBar.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    margin: 6
    padding: 2
    image-color: #1b1b1b
    border: 1 #3b2a10
]=], g_ui.getRootWidget())
taskInterface:hide()
local taskList = taskInterface.taskList

taskInterface.minimize.onClick = function()
  if taskList:isVisible() then
    taskList:hide()
    taskInterface:setHeight(35)
    taskInterface.minimize:setText("+")
  else
    taskList:show()
    taskInterface:setHeight(100)
    taskInterface.minimize:setText("-")
  end
end

storage.widgetPos = storage.widgetPos or {}
storage.widgetPos["taskInterface"] = storage.widgetPos["taskInterface"] or {}

-- restaura pos
taskInterface:setPosition({
  x = storage.widgetPos["taskInterface"].x or taskInterface:getX(),
  y = storage.widgetPos["taskInterface"].y or taskInterface:getY()
})



taskInterface.onDragEnter = function(widget, mousePos)
  widget:breakAnchors()
  widget.movingReference = {
    x = mousePos.x - widget:getX(),
    y = mousePos.y - widget:getY()
  }
  return true
end

taskInterface.onDragMove = function(widget, mousePos, moved)
  local parentRect = widget:getParent():getRect()

  local x = math.min(
    math.max(parentRect.x, mousePos.x - widget.movingReference.x),
    parentRect.x + parentRect.width - widget:getWidth()
  )

  local y = math.min(
    math.max(parentRect.y - widget:getParent():getMarginTop(), mousePos.y - widget.movingReference.y),
    parentRect.y + parentRect.height - widget:getHeight()
  )

  widget:move(x, y)
  storage.widgetPos["taskInterface"] = { x = x, y = y }
  return true
end
-- =========================
-- ROW TEMPLATE (layout antigo)
-- =========================
local rowTemplate = [[
UIWidget
  height: 60
  focusable: true
  background-color: alpha
  opacity: 1.00

  UICreature
    id: icon
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    margin-left: 0
    size: 50 50
    margin-top: 0
    visible: true

  Label
    id: spellName
    anchors.left: icon.right
    anchors.top: parent.top
    margin-left: 8
    margin-top: 13
    font: verdana-9px
    color: orange
    text: ""

  Label
    id: distText
    anchors.left: icon.right
    anchors.top: spellName.bottom
    margin-left: 8
    margin-top: 4
    font: verdana-9px
    text-auto-resize: true
    color: #dcdcdc
    text: "0/0"

  Label
    id: mobsText
    anchors.left: distText.right
    anchors.verticalCenter: distText.verticalCenter
    margin-left: 3
    font: verdana-9px
    text-auto-resize: true
    color: #dcdcdc
    text: "KILLS"

  Label
    id: safeText
    anchors.left: mobsText.right
    anchors.verticalCenter: distText.verticalCenter
    margin-left: 8
    font: verdana-9px
    text-auto-resize: true
    color: gray
    text: "[0%]"

  Button
    id: remove
    anchors.right: parent.right
    anchors.top: parent.top
    width: 60
    height: 16
    margin-right: 6
    margin-top: 6
    text: CANCEL
    font: verdana-9px
    color: #FF4040
    image-color: #363636
    image-source: /images/ui/button_rounded
]]

-- =========================
-- Helpers list (igual AttackBot)
-- =========================
local function clearChildren(w)
  local children = w:getChildren() or {}
  for i = #children, 1, -1 do
    children[i]:destroy()
  end
end

local function getProgressKey(taskKey)
  st.progress[taskKey] = st.progress[taskKey] or { kills = 0 }
  st.progress[taskKey].kills = tonumber(st.progress[taskKey].kills or 0) or 0
  return st.progress[taskKey]
end

local function calcPct(kills, req)
  kills = tonumber(kills or 0) or 0
  req = tonumber(req or 0) or 0
  if req <= 0 then return 0 end
  local pct = math.floor((kills * 100) / req)
  if pct < 0 then pct = 0 end
  if pct > 100 then pct = 100 end
  return pct
end

-- =========================
-- REFRESH LIST (ONLINE)
-- =========================
local function refreshList()
  clearChildren(taskList)

  if not st.current or not TASKS[st.current] then
    return
  end

  local cfg = TASKS[st.current]
  local kills = tonumber(st.kills or 0) or 0
  local req = tonumber(st.required or cfg.required) or cfg.required
  if kills > req then kills = req end

  local pct = calcPct(kills, req)
  local done = (kills >= req)

  local row = setupUI(rowTemplate, taskList)

  -- =========================
  -- AQUI É O IMPORTANTE (UICreature)
  -- =========================
  if row.icon and row.icon.setOutfit then
    local outfit = nil

    if player and player.getOutfit then
      local ok, base = pcall(function() return player:getOutfit() end)
      if ok and type(base) == "table" then
        base.type = tonumber(cfg.iconId) or 0
        base.addons = 0
        outfit = base
      end
    end

    outfit = outfit or {
      mount = 0,
      feet = 0,
      legs = 0,
      body = cfg.iconId,
      type = 0,
      auxType = 0,
      addons = 0,
      head = 0
    }

    pcall(function()
      row.icon:setOutfit(outfit)
    end)
  end

  -- =========================

  row.spellName:setText(cfg.label)
  row.distText:setText(kills .. "/" .. req)
  row.mobsText:setText("KILLS")

  row.safeText:setText("[" .. pct .. "%]")
  row.safeText:setColor(done and "#66ff66" or "gray")

  row.remove.onClick = function()
    -- guarda qual task está sendo cancelada
    local key = st.current

    -- limpa progresso salvo dessa task
    if key and st.progress then
      st.progress[key] = nil
    end

    -- reseta estado atual
    st.current = nil
    st.kills = 0
    st.required = 0

    refreshList()
  end
end

-- =========================
-- SET TASK (carrega progresso salvo)
-- =========================
local function setTask(key)
  if not TASKS[key] then return end
  st.current = key
  st.required = TASKS[key].required

  local p = getProgressKey(key)
  st.kills = tonumber(p.kills or 0) or 0
  if st.kills > st.required then st.kills = st.required end

  refreshList()
end

-- =========================
-- AUTO KILL COUNT (salva + atualiza online)
-- =========================
local function addKill()
  local row = setupUI(rowTemplate, taskList)
  if not st.current or not TASKS[st.current] then return end

  st.kills = (tonumber(st.kills or 0) or 0) + 1
  if st.kills > st.required then st.kills = st.required end

  local p = getProgressKey(st.current)
  p.kills = st.kills

  refreshList()
end

local function isTaskCreatureName(mobName)
  if not st.current or not TASKS[st.current] then return false end
  mobName = norm(mobName)

  for _, cname in ipairs(TASKS[st.current].creatures) do
    if mobName == norm(cname) then
      return true
    end
  end
  return false
end

local function extractLootMobName(text)
  local mobName = nil
  local reg = { "Loot of a (.*):", "Loot of an (.*):", "Loot of the (.*):", "Loot of (.*):" }
  for i = 1, #reg do
    local _, _, m = string.find(text, reg[i])
    if m then
      mobName = m
      break
    end
  end
  return mobName
end

local function handleLootText(text)
  if not (storage[HUD_PANEL_STORAGE] and storage[HUD_PANEL_STORAGE].switches and storage[HUD_PANEL_STORAGE].switches.taskTracker) then return end
  if not st.current then return end
  if type(text) ~= "string" then return end

  local mobName = extractLootMobName(text)
  if not mobName then return end

  if not isTaskCreatureName(mobName) then return end

  addKill()
end

onTalk(function(name, level, mode, text, channelId, pos)
  if channelId == 11 then
    handleLootText(text)
  end
end)

onTextMessage(function(mode, text)
  handleLootText(text)
end)

-- =========================
-- CAPTURA Ragnar (ONLINE)
-- =========================
onTalk(function(name, level, mode, text)
  if not name then return end
  if norm(name) ~= "ragnar" then return end

  local key = parseHunt(text)
  if key then
    setTask(key)
  end
end)

onTextMessage(function(mode, text)
  local key = parseHunt(text)
  if key then
    setTask(key)
  end
end)

-- INIT
if st.current and TASKS[st.current] then
  setTask(st.current) -- recarrega progresso salvo e desenha
else
  refreshList()
end