setDefaultTab("Main")

local switchSwap = "swapButton"
if not storage[switchSwap] then storage[switchSwap] = { enabled = false } end

swapButton = setupUI([[
Panel
  height: 20
  margin-top: -3
  
  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 110
    text: Swap Ring/Amulet
    font: verdana-9px
    color: white
    image-source: /images/ui/button_rounded
    $on:
      font: verdana-9px
      color: green
      image-color: gray
    $!on:
      image-color: gray
      color: white

  Button
    id: settings
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 0
    height: 17
    text: Config
    font: verdana-9px
    image-color: #363636
    image-source: /images/ui/button_rounded
    opacity: 1.00
    color: white
    $hover:
      opacity: 0.95
      color: green
]])
swapButton:setId(switchSwap)
swapButton.title:setOn(storage[switchSwap].enabled)

swapButton.title.onClick = function(widget)
  local newState = not widget:isOn()
  widget:setOn(newState)
  storage[switchSwap].enabled = newState
end

panelSwap = setupUI([[  
RingConfig < Panel
  height: 65
  margin-top: 3

  BotItem
    id: ringPadrao
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    image-source: /images/game/slots/finger
    tooltip: Ring Padrao
    $on:
      image-source: /images/ui/item-blessed

  BotItem
    id: ringEquipavel
    anchors.left: prev.right
    anchors.verticalCenter: parent.verticalCenter
    image-source: /images/game/slots/finger
    margin-left: 5
    tooltip: Ring Especial
    $on:
      image-source: /images/ui/item-blessed

  BotItem
    id: ringEquipavelID
    anchors.left: prev.right
    anchors.verticalCenter: parent.verticalCenter
    image-source: /images/game/slots/finger
    margin-left: 5
    tooltip: [ID] Ring Especial
    $on:
      image-source: /images/ui/item-blessed

  HorizontalScrollBar
    id: hpEquip
    anchors.left: ringEquipavelID.right
    anchors.top: ringEquipavelID.top
    width: 120
    margin-top: 0
    margin-left: 5
    minimum: 0
    maximum: 100
    step: 1

  Label
    id: hpEquipLabel
    anchors.top: prev.top
    anchors.left: prev.left
    anchors.right: prev.right
    text: Equip: 0%
    font: verdana-9px
    color: white
    text-align: center

  HorizontalScrollBar
    id: hpDesequip
    anchors.left: hpEquip.left
    anchors.top: prev.bottom
    width: 120
    margin-top: 8
    minimum: 0
    maximum: 100
    step: 1

  Label
    id: hpDesequipLabel
    anchors.top: prev.top
    anchors.left: prev.left
    anchors.right: prev.right
    text: Unequip: 0%
    font: verdana-9px
    color: white
    text-align: center

  BotSwitch
    id: ativador
    anchors.left: ringPadrao.left
    anchors.right: ringEquipavelID.right
    anchors.top: ringPadrao.bottom
    margin-right: -10
    margin-top: 3
    font: verdana-9px

  BotSwitch
    id: ativadorFull
    anchors.left: hpEquipLabel.left
    margin-left: 10
    anchors.right: hpEquip.right
    anchors.top: ringPadrao.bottom
    margin-top: 3
    font: verdana-9px

  VerticalSeparator
    id: vertSep
    anchors.top: ringPadrao.top
    anchors.bottom: ativador.bottom
    anchors.left: prev.right
    margin-left: 10

  BotItem
    id: backpack
    anchors.top: ringPadrao.top
    anchors.left: prev.right
    margin-left: 33
    image-source: /images/game/slots/back-blessed
    $on:
      image-source: /images/ui/item-blessed

  BotSwitch
    id: ativadorBP
    anchors.top: ativador.top
    anchors.left: vertSep.right
    anchors.bottom: ativador.bottom
    text: BP Inteligente
    margin-top: 0
    margin-left: 10
    text-auto-resize: true
    font: verdana-9px

AmuletConfig < Panel
  height: 65
  margin-top: 3

  BotItem
    id: amuletPadrao
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    image-source: /images/game/slots/neck
    tooltip: Amulet Padrao
    $on:
      image-source: /images/ui/item-blessed

  BotItem
    id: amuletEquipavel
    anchors.left: prev.right
    anchors.verticalCenter: parent.verticalCenter
    image-source: /images/game/slots/neck
    margin-left: 5
    tooltip: Amulet Especial
    $on:
      image-source: /images/ui/item-blessed

  BotItem
    id: amuletEquipavelID
    anchors.left: prev.right
    anchors.verticalCenter: parent.verticalCenter
    image-source: /images/game/slots/neck
    margin-left: 5
    tooltip: [ID] Amulet Especial
    $on:
      image-source: /images/ui/item-blessed

  HorizontalScrollBar
    id: hpEquip
    anchors.left: amuletEquipavelID.right
    anchors.top: amuletEquipavelID.top
    width: 120
    margin-top: 0
    margin-left: 5
    minimum: 0
    maximum: 100
    step: 1

  Label
    id: hpEquipLabel
    anchors.top: prev.top
    anchors.left: prev.left
    anchors.right: prev.right
    text: Equip: 0%
    font: verdana-9px
    color: white
    text-align: center

  HorizontalScrollBar
    id: hpDesequip
    anchors.left: hpEquip.left
    anchors.top: prev.bottom
    width: 120
    margin-top: 8
    minimum: 0
    maximum: 100
    step: 1

  Label
    id: hpDesequipLabel
    anchors.top: prev.top
    anchors.left: prev.left
    anchors.right: prev.right
    text: Unequip: 0%
    font: verdana-9px
    color: white
    text-align: center
    
  BotSwitch
    id: ativador
    anchors.left: amuletPadrao.left
    anchors.right: amuletEquipavelID.right
    anchors.top: amuletPadrao.bottom
    margin-right: -10
    margin-top: 3
    font: verdana-9px

  BotSwitch
    id: ativadorFull
    anchors.left: hpEquipLabel.left
    margin-left: 10
    anchors.right: hpEquip.right
    anchors.top: amuletPadrao.bottom
    margin-top: 3
    font: verdana-9px

  VerticalSeparator
    id: vertSep
    anchors.top: amuletPadrao.top
    anchors.bottom: ativador.bottom
    anchors.left: prev.right
    margin-left: 10

  BotItem
    id: backpack
    anchors.top: amuletPadrao.top
    anchors.left: prev.right
    margin-left: 33
    image-source: /images/game/slots/back-blessed
    $on:
      image-source: /images/ui/item-blessed

  BotSwitch
    id: ativadorBP
    anchors.top: ativador.top
    anchors.left: vertSep.right
    anchors.bottom: ativador.bottom
    text: BP Inteligente
    margin-top: 0
    margin-left: 10
    text-auto-resize: true
    font: verdana-9px

UIWindow
  id: panelSwap
  size: 365 285
  border: 1 black
  anchors.centerIn: parent
  margin-top: -60

  Panel
    id: background
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    background-color: black
    opacity: 0.70

  Panel
    id: topPanel
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    size: 120 30
    text-align: center
    !text: tr('LNS Custom | Smart Swap [Ring & Amulet]')
    color: orange
    margin-left: 0
    margin-right: 0
    background-color: black
    $hover:
      image-color: gray
  
  Panel
    id: iconPanel
    anchors.top: topPanel.top
    anchors.left: parent.left
    size: 60 60
    margin-top: -28
    margin-left: -15

  UIButton
    id: closePanel
    anchors.top: topPanel.top
    anchors.right: parent.right
    size: 18 18
    margin-top: 6
    margin-right: 10
    background-color: orange
    text: X
    color: white
    opacity: 1.00
    $hover:
      color: black
      opacity: 0.80

  Button
    id: Ring
    anchors.top: topPanel.bottom
    anchors.left: topPanel.left
    size: 80 20
    text: RING
    image-source: /images/ui/button_rounded
    image-color: #363636
    margin-left: 5
    margin-top: 5
    font: verdana-9px
    color: white

  Button
    id: Amulet
    anchors.top: prev.top
    anchors.left: prev.right
    size: 80 20
    text: AMULET
    image-source: /images/ui/button_rounded
    image-color: #363636
    font: verdana-9px
    color: white

  FlatPanel
    id: abaRing
    anchors.top: prev.bottom
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 2
    margin-bottom: 10
    margin-left: 5
    margin-right: 5
    padding-left: 10
    padding-top: -10
    image-color: #363636
    layout: verticalBox

    RingConfig
      id: ring1
      margin-left: 5
      size: 330 70

    RingConfig
      id: ring2
      margin-left: 5
      size: 330 70

    RingConfig
      id: ring3
      margin-left: 5
      size: 330 70

  FlatPanel
    id: abaAmulet
    anchors.top: abaRing.top
    anchors.bottom: abaRing.bottom
    anchors.left: abaRing.left
    anchors.right: abaRing.right
    padding-left: 10
    padding-top: -10
    image-color: #363636
    layout: verticalBox

    AmuletConfig
      id: amulet1
      margin-left: 5
      size: 330 70

    AmuletConfig
      id: amulet2
      margin-left: 5
      size: 330 70

    AmuletConfig
      id: amulet3
      margin-left: 5
      size: 330 70

]], g_ui.getRootWidget())

panelSwap:hide()
panelSwap.abaRing:show()
panelSwap.Ring:setColor("yellow")
panelSwap.abaAmulet:hide()

swapButton.settings.onClick = function()
  panelSwap:setVisible(not panelSwap:isVisible())
end

panelSwap.closePanel.onClick = function()
  panelSwap:hide()
end

panelSwap.Ring.onClick = function()
  panelSwap.Ring:setColor("yellow")
  panelSwap.Amulet:setColor("gray")
  panelSwap.abaRing:show()
  panelSwap.abaAmulet:hide()
end

panelSwap.Amulet.onClick = function()
  panelSwap.Ring:setColor("gray")
  panelSwap.Amulet:setColor("yellow")
  panelSwap.abaRing:hide()
  panelSwap.abaAmulet:show()
end

-- =========================
-- STORAGE + BINDS + BLOQUEIO (Unequip >= Equip)
-- =========================
local panelStoreName = "panelSwapStorage"

if not storage[panelStoreName] then
  storage[panelStoreName] = {
    ring = { [1] = {}, [2] = {}, [3] = {} },
    amulet = { [1] = {}, [2] = {}, [3] = {} }
  }
end

local function sched(ms, fn)
  if type(scheduleEvent) == "function" then return scheduleEvent(fn, ms) end
  if g_dispatcher and type(g_dispatcher.scheduleEvent) == "function" then
    return g_dispatcher:scheduleEvent(fn, ms)
  end
  return fn()
end

local function ensureEntry(root, idx)
  root[idx] = root[idx] or {}
  return root[idx]
end

local function safeSetItem(widget, id)
  if not widget then return end
  id = tonumber(id) or 0
  if id > 0 and widget.setItemId then widget:setItemId(id) end
end

local function safeGetItem(widget)
  if not widget then return 0 end
  if widget.getItemId then return tonumber(widget:getItemId()) or 0 end
  if widget.getItem then
    local it = widget:getItem()
    if it and it.getId then return tonumber(it:getId()) or 0 end
  end
  return 0
end

local function bindBotItem(widget, store, key, defaultId)
  if not widget then return end
  local v = tonumber(store[key]) or 0
  if (v <= 0) and (tonumber(defaultId) or 0) > 0 then
    v = tonumber(defaultId)
    store[key] = v
  end
  safeSetItem(widget, v)
  widget.onItemChange = function(w)
    store[key] = safeGetItem(w)
  end
end

local function setLabel(label, prefix, v)
  if label and label.setText then
    label:setText(prefix .. tostring(v) .. "%")
  end
end

-- Bloqueio: Unequip nunca fica < Equip
local function bindEquipUnequipPair(sbEquip, sbUnequip, lbEquip, lbUnequip, store, keyEquip, keyUnequip)
  if not sbEquip or not sbUnequip then return end

  local e = tonumber(store[keyEquip])
  local u = tonumber(store[keyUnequip])

  if e == nil then e = (sbEquip.getValue and sbEquip:getValue()) or 0 end
  if u == nil then u = (sbUnequip.getValue and sbUnequip:getValue()) or 0 end

  if e < 0 then e = 0 end
  if e > 100 then e = 100 end
  if u < 0 then u = 0 end
  if u > 100 then u = 100 end
  if u < e then u = e end

  store[keyEquip] = e
  store[keyUnequip] = u

  if sbEquip.setValue then sbEquip:setValue(e) end
  if sbUnequip.setValue then sbUnequip:setValue(u) end
  setLabel(lbEquip, "Equip: ", e)
  setLabel(lbUnequip, "Unequip: ", u)

  sbEquip.onValueChange = function(_, value)
    value = tonumber(value) or 0
    if value < 0 then value = 0 end
    if value > 100 then value = 100 end

    store[keyEquip] = value
    setLabel(lbEquip, "Equip: ", value)

    local curU = tonumber(store[keyUnequip]) or (sbUnequip.getValue and sbUnequip:getValue()) or 0
    if curU < value then
      curU = value
      store[keyUnequip] = curU
      if sbUnequip.setValue then sbUnequip:setValue(curU) end
      setLabel(lbUnequip, "Unequip: ", curU)
    end
  end

  sbUnequip.onValueChange = function(_, value)
    value = tonumber(value) or 0
    if value < 0 then value = 0 end
    if value > 100 then value = 100 end

    local curE = tonumber(store[keyEquip]) or (sbEquip.getValue and sbEquip:getValue()) or 0
    if value < curE then value = curE end

    store[keyUnequip] = value
    if sbUnequip.setValue then sbUnequip:setValue(value) end
    setLabel(lbUnequip, "Unequip: ", value)
  end
end

local function bindBotSwitch(widget, store, key, defaultBool, text)
  if not widget then return end
  local on = store[key]
  if on == nil then on = (defaultBool == true) end
  store[key] = (on == true)
  if widget.setOn then widget:setOn(store[key]) end
  if text and widget.setText then widget:setText(text) end
  widget.onClick = function(w)
    local newState = not w:isOn()
    w:setOn(newState)
    store[key] = (newState == true)
  end
end

-- Exclusivo: ou Swap ou Equip Full (nunca os dois)
local function bindExclusivePair(swSwap, swFull, store, keySwap, keyFull, textSwap, textFull)
  keySwap = keySwap or "ativador"
  keyFull = keyFull or "ativadorFull"

  -- seta textos
  if textSwap and swSwap and swSwap.setText then swSwap:setText(textSwap) end
  if textFull and swFull and swFull.setText then swFull:setText(textFull) end

  -- defaults
  store[keySwap] = (store[keySwap] == true)
  store[keyFull] = (store[keyFull] == true)

  -- garante exclusividade na carga
  if store[keySwap] and store[keyFull] then
    store[keyFull] = false
  end

  if swSwap and swSwap.setOn then swSwap:setOn(store[keySwap]) end
  if swFull and swFull.setOn then swFull:setOn(store[keyFull]) end

  if swSwap then
    swSwap.onClick = function(w)
      local newState = not w:isOn()
      w:setOn(newState)
      store[keySwap] = (newState == true)

      -- se ligou Swap, desliga Full
      if newState == true then
        store[keyFull] = false
        if swFull and swFull.setOn then swFull:setOn(false) end
      end
    end
  end

  if swFull then
    swFull.onClick = function(w)
      local newState = not w:isOn()
      w:setOn(newState)
      store[keyFull] = (newState == true)

      -- se ligou Full, desliga Swap
      if newState == true then
        store[keySwap] = false
        if swSwap and swSwap.setOn then swSwap:setOn(false) end
      end
    end
  end
end


-- Defaults
local DEFAULT_BP = 2854
local ringDefaults = {
  [1] = { ringEquipavel = 3051, ringEquipavelID = 3088, backpack = DEFAULT_BP },
  [2] = { ringEquipavel = 3048, ringEquipavelID = 3048, backpack = DEFAULT_BP },
  [3] = { backpack = DEFAULT_BP }
}
local amuletDefaults = {
  [1] = { amuletEquipavel = 3081, amuletEquipavelID = 3081, backpack = DEFAULT_BP },
  [2] = { backpack = DEFAULT_BP },
  [3] = { backpack = DEFAULT_BP }
}

local function bindRingRow(rowWidget, idx)
  if not rowWidget then return end
  local rowStore = ensureEntry(storage[panelStoreName].ring, idx)
  local d = ringDefaults[idx] or {}

  bindBotItem(rowWidget.ringPadrao,      rowStore, "ringPadrao")
  bindBotItem(rowWidget.ringEquipavel,   rowStore, "ringEquipavel",   d.ringEquipavel)
  bindBotItem(rowWidget.ringEquipavelID, rowStore, "ringEquipavelID", d.ringEquipavelID)
  bindExclusivePair(rowWidget.ativador, rowWidget.ativadorFull, rowStore, "ativador", "ativadorFull", "Swap Ring " .. idx, "Equip Full")

  bindBotItem(rowWidget.backpack,        rowStore, "backpack", d.backpack)
  bindBotSwitch(rowWidget.ativadorBP,    rowStore, "ativadorBP", false, "BP Inteligente")
  
  bindEquipUnequipPair(
    rowWidget.hpEquip, rowWidget.hpDesequip,
    rowWidget.hpEquipLabel, rowWidget.hpDesequipLabel,
    rowStore, "hpEquip", "hpDesequip"
  )
end

local function bindAmuletRow(rowWidget, idx)
  if not rowWidget then return end
  local rowStore = ensureEntry(storage[panelStoreName].amulet, idx)
  local d = amuletDefaults[idx] or {}

  bindBotItem(rowWidget.amuletPadrao,      rowStore, "amuletPadrao")
  bindBotItem(rowWidget.amuletEquipavel,   rowStore, "amuletEquipavel",   d.amuletEquipavel)
  bindBotItem(rowWidget.amuletEquipavelID, rowStore, "amuletEquipavelID", d.amuletEquipavelID)
  bindExclusivePair(rowWidget.ativador, rowWidget.ativadorFull, rowStore, "ativador", "ativadorFull", "Swap Amulet " .. idx, "Equip Full")

  bindBotItem(rowWidget.backpack,          rowStore, "backpack", d.backpack)
  bindBotSwitch(rowWidget.ativadorBP,      rowStore, "ativadorBP", false, "BP Inteligente")

  bindEquipUnequipPair(
    rowWidget.hpEquip, rowWidget.hpDesequip,
    rowWidget.hpEquipLabel, rowWidget.hpDesequipLabel,
    rowStore, "hpEquip", "hpDesequip"
  )
end

bindRingRow(panelSwap.abaRing.ring1, 1)
bindRingRow(panelSwap.abaRing.ring2, 2)
bindRingRow(panelSwap.abaRing.ring3, 3)

bindAmuletRow(panelSwap.abaAmulet.amulet1, 1)
bindAmuletRow(panelSwap.abaAmulet.amulet2, 2)
bindAmuletRow(panelSwap.abaAmulet.amulet3, 3)

-- =========================
-- EFEITO "$on" (item-blessed quando itemId > 0)
-- =========================
local function autoItemOnState(root)
  if not root or root:isDestroyed() then return end

  local function apply(w)
    if not w or w:isDestroyed() then return end
    if not w.getItemId then return end
    local id = w:getItemId() or 0

    if w.setOn and w.isOn then
      w:setOn(id > 0)
      return
    end

    if w.setImageSource then
      if w._emptyImageSource == nil and w.getImageSource then
        local cur = w:getImageSource()
        if cur and cur ~= "" and cur ~= "/images/ui/item-blessed" then
          w._emptyImageSource = cur
        end
      end
      if id > 0 then
        w:setImageSource("/images/ui/item-blessed")
      else
        if w._emptyImageSource then
          w:setImageSource(w._emptyImageSource)
        end
      end
    end
  end

  local function hook(w)
    if not w or w:isDestroyed() then return end

    if w.getItemId then
      sched(1, function()
        if w and not w:isDestroyed() then apply(w) end
      end)

      local old = w.onItemChange
      w.onItemChange = function(widget, ...)
        sched(1, function()
          if widget and not widget:isDestroyed() then apply(widget) end
        end)
        if old then old(widget, ...) end
      end
    end

    if w.getChildren then
      for _, ch in pairs(w:getChildren()) do
        hook(ch)
      end
    end
  end

  hook(root)
end

autoItemOnState(panelSwap)

-- ==========================================================
-- SWAP + EQUIP FULL (RING/AMULET) - BLOCO ÚNICO FINAL
-- ==========================================================

local __swapOld = g_game.getClientVersion() < 800
local __SWAP_CD_MS = 5000

local __SLOT_FINGER = SlotFinger or 9
local __SLOT_NECK   = SlotNeck or 2

local function __nowMillis()
  if g_clock and type(g_clock.millis) == "function" then return g_clock.millis() end
  if now then return now end
  return 0
end

local function __itemId(it)
  if not it then return 0 end
  if it.getId then return tonumber(it:getId()) or 0 end
  return 0
end

local function __getFinger()
  if type(getFinger) == "function" then return getFinger() end
  return getSlot(__SLOT_FINGER)
end

local function __getNeck()
  if type(getNeck) == "function" then return getNeck() end
  return getSlot(__SLOT_NECK)
end

local function __isIdIn(id, a, b)
  id = tonumber(id) or 0
  a  = tonumber(a) or 0
  b  = tonumber(b) or 0
  if id <= 0 then return false end
  return (a > 0 and id == a) or (b > 0 and id == b)
end

local function __findItemById(id)
  id = tonumber(id) or 0
  if id <= 0 then return nil end

  if type(findItem) == "function" then
    local it = findItem(id)
    if it then return it end
  end

  for _, c in ipairs(g_game.getContainers() or {}) do
    local items = c:getItems() or {}
    for i = 1, #items do
      local it = items[i]
      if it and it.getId and tonumber(it:getId()) == id then
        return it
      end
    end
  end
  return nil
end

local function __equipIdToSlot(id, slot)
  id = tonumber(id) or 0
  if id <= 0 then return false end

  if not __swapOld then
    g_game.equipItemId(id)
    return true
  end

  local it = __findItemById(id)
  if not it then return false end
  g_game.move(it, {x=65535, y=slot, z=0}, 1)
  return true
end

-- id1 = item "real" na bp (ITEM2), id2 = id quando equipado (ITEM3)
local function __equipSpecialToSlot(id1, id2, slot)
  id1 = tonumber(id1) or 0
  id2 = tonumber(id2) or 0

  if not __swapOld then
    local pick = (id1 > 0) and id1 or id2
    if pick <= 0 then return false end
    g_game.equipItemId(pick)
    return true
  end

  local it = __findItemById(id1) or __findItemById(id2)
  if not it then return false end
  g_game.move(it, {x=65535, y=slot, z=0}, 1)
  return true
end

local function __getActiveIndexByKey(kindTable, keyName)
  for i = 1, 3 do
    local row = kindTable and kindTable[i]
    if row and row[keyName] == true then
      return i, row
    end
  end
  return nil, nil
end

-- cooldowns locais
local __ringCdUntil   = { [1]=0, [2]=0, [3]=0 }
local __amuletCdUntil = { [1]=0, [2]=0, [3]=0 }

-- =========================
-- SWAP RING
-- =========================
local function __processRingSwap(idx, row)
  local hp = hppercent()
  local t  = __nowMillis()

  local finger = __getFinger()
  local fid = __itemId(finger)

  local ring1  = tonumber(row.ringPadrao) or 0
  local item2  = tonumber(row.ringEquipavel) or 0
  local item3  = tonumber(row.ringEquipavelID) or 0

  local equipPct   = tonumber(row.hpEquip) or 0
  local unequipPct = tonumber(row.hpDesequip) or equipPct

  local cdUntil = __ringCdUntil[idx] or 0
  local cdActive = cdUntil > t

  if hp < equipPct then
    if item3 > 0 and fid == item3 then return false end
    if __isIdIn(fid, item2, item3) then return false end

    if __equipSpecialToSlot(item2, item3, __SLOT_FINGER) then
      if not cdActive then __ringCdUntil[idx] = t + __SWAP_CD_MS end
      delay(120)
      return true
    end
    return false
  end

  if fid == 0 and cdActive then
    if __equipSpecialToSlot(item2, item3, __SLOT_FINGER) then
      delay(120)
      return true
    end
    return false
  end

  local wantDefault = (hp > unequipPct) or (fid == 0 and hp >= equipPct)
  if wantDefault then
    if cdActive then return false end
    if ring1 > 0 and fid ~= ring1 then
      if __equipIdToSlot(ring1, __SLOT_FINGER) then
        delay(120)
        return true
      end
    end
  end

  return false
end

-- =========================
-- SWAP AMULET
-- =========================
local function __processAmuletSwap(idx, row)
  local hp = hppercent()
  local t  = __nowMillis()

  local neck = __getNeck()
  local nid = __itemId(neck)

  local amu1  = tonumber(row.amuletPadrao) or 0
  local item2 = tonumber(row.amuletEquipavel) or 0
  local item3 = tonumber(row.amuletEquipavelID) or 0

  local equipPct   = tonumber(row.hpEquip) or 0
  local unequipPct = tonumber(row.hpDesequip) or equipPct

  local cdUntil = __amuletCdUntil[idx] or 0
  local cdActive = cdUntil > t

  if hp < equipPct then
    if item3 > 0 and nid == item3 then return false end
    if __isIdIn(nid, item2, item3) then return false end

    if __equipSpecialToSlot(item2, item3, __SLOT_NECK) then
      if not cdActive then __amuletCdUntil[idx] = t + __SWAP_CD_MS end
      delay(120)
      return true
    end
    return false
  end

  if nid == 0 and cdActive then
    if __equipSpecialToSlot(item2, item3, __SLOT_NECK) then
      delay(120)
      return true
    end
    return false
  end

  local wantDefault = (hp > unequipPct) or (nid == 0 and hp >= equipPct)
  if wantDefault then
    if cdActive then return false end
    if amu1 > 0 and nid ~= amu1 then
      if __equipIdToSlot(amu1, __SLOT_NECK) then
        delay(120)
        return true
      end
    end
  end

  return false
end

-- =========================
-- EQUIP FULL (RING/AMULET)
-- regra: independente do hp, se equipado != ITEM3 -> equipa ITEM2
-- =========================
local __ringFullRetryUntil   = { [1]=0, [2]=0, [3]=0 }
local __amuletFullRetryUntil = { [1]=0, [2]=0, [3]=0 }
local __FULL_RETRY_MS = 600

local function __processRingFull(idx, row)
  local t = __nowMillis()
  if (__ringFullRetryUntil[idx] or 0) > t then return false end

  local finger = __getFinger()
  local fid = __itemId(finger)

  local item2 = tonumber(row.ringEquipavel) or 0
  local item3 = tonumber(row.ringEquipavelID) or 0
  if item2 <= 0 and item3 <= 0 then return false end

  local targetEquipped = (item3 > 0) and item3 or item2

  -- se já está com o "equipado" certo, não faz nada
  if fid == targetEquipped then return false end

  -- força equipar ITEM2 (e aceita ITEM3 como fallback)
  if __equipSpecialToSlot(item2, item3, __SLOT_FINGER) then
    delay(120)
    return true
  end

  -- não achou item -> coloca retry leve (não spamma e não soma cooldown)
  __ringFullRetryUntil[idx] = t + __FULL_RETRY_MS
  return false
end

local function __processAmuletFull(idx, row)
  local t = __nowMillis()
  if (__amuletFullRetryUntil[idx] or 0) > t then return false end

  local neck = __getNeck()
  local nid = __itemId(neck)

  local item2 = tonumber(row.amuletEquipavel) or 0
  local item3 = tonumber(row.amuletEquipavelID) or 0
  if item2 <= 0 and item3 <= 0 then return false end

  local targetEquipped = (item3 > 0) and item3 or item2

  if nid == targetEquipped then return false end

  if __equipSpecialToSlot(item2, item3, __SLOT_NECK) then
    delay(120)
    return true
  end

  __amuletFullRetryUntil[idx] = t + __FULL_RETRY_MS
  return false
end

-- =========================
-- MACROS
-- =========================

macro(50, function()
  if not storage["swapButton"] or storage["swapButton"].enabled ~= true then return end
  local st = storage["panelSwapStorage"]
  if not st or not st.ring then return end

  -- Se existir Equip Full ativo, o Swap não roda (modo exclusivo já garante, mas deixo seguro)
  local fIdx = __getActiveIndexByKey(st.ring, "ativadorFull")
  if fIdx then return end

  local idx, row = __getActiveIndexByKey(st.ring, "ativador")
  if not idx or not row then return end
  __processRingSwap(idx, row)
end)

macro(50, function()
  if not storage["swapButton"] or storage["swapButton"].enabled ~= true then return end
  local st = storage["panelSwapStorage"]
  if not st or not st.amulet then return end

  local fIdx = __getActiveIndexByKey(st.amulet, "ativadorFull")
  if fIdx then return end

  local idx, row = __getActiveIndexByKey(st.amulet, "ativador")
  if not idx or not row then return end
  __processAmuletSwap(idx, row)
end)

macro(50,function()
  if not storage["swapButton"] or storage["swapButton"].enabled ~= true then return end
  local st = storage["panelSwapStorage"]
  if not st or not st.ring then return end

  local idx, row = __getActiveIndexByKey(st.ring, "ativadorFull")
  if not idx or not row then return end
  __processRingFull(idx, row)
end)

macro(50,function()
  if not storage["swapButton"] or storage["swapButton"].enabled ~= true then return end
  local st = storage["panelSwapStorage"]
  if not st or not st.amulet then return end

  local idx, row = __getActiveIndexByKey(st.amulet, "ativadorFull")
  if not idx or not row then return end
  __processAmuletFull(idx, row)
end)

-----------------------------------------

-- ==========================================================
-- LNS | BP INTELIGENTE (FINAL - FORCE OPEN)
-- - Abre sozinho a BP configurada (base: renameContainers / forceOpen)
-- - Mantém 1 slot livre (dropa 1 item se container cheio)
-- - Se acabar ITEM2/ITEM3, abre a próxima BP dentro dela
-- - Roda só na linha ativa (Swap ou Equip Full) e só com BP Inteligente ON
-- ==========================================================

-- --------------------------
-- Scheduler / millis
-- --------------------------
local function __sched(ms, fn)
  if type(scheduleEvent) == "function" then return scheduleEvent(fn, ms) end
  if g_dispatcher and type(g_dispatcher.scheduleEvent) == "function" then
    return g_dispatcher:scheduleEvent(fn, ms)
  end
  if type(schedule) == "function" then return schedule(ms, fn) end
  return fn()
end

local function __ms()
  if g_clock and type(g_clock.millis) == "function" then return g_clock.millis() end
  if now then return now end
  return 0
end

-- --------------------------
-- Containers helper (igual teu padrão)
-- --------------------------
local function __getContainersSafe()
  if type(getContainers) == "function" then
    return getContainers() or {}
  end
  if g_game and type(g_game.getContainers) == "function" then
    return g_game.getContainers() or {}
  end
  return {}
end

local function __findBPContainer(bpId)
  bpId = tonumber(bpId) or 0
  if bpId <= 0 then return nil end
  for _, container in pairs(__getContainersSafe()) do
    local cItem = container:getContainerItem()
    if cItem and cItem.getId and tonumber(cItem:getId()) == bpId then
      return container
    end
  end
  return nil
end

-- --------------------------
-- FORCE OPEN CONTAINER BY ID (base: renameContainers)
-- --------------------------
local function __forceOpenContainerById(id)
  id = tonumber(id) or 0
  if id <= 0 then return false end

  -- 1) tenta slots
  local slots = { getBack(), getAmmo(), getFinger(), getNeck(), getLeft(), getRight() }
  for i = 1, #slots do
    local it = slots[i]
    if it and it.getId and tonumber(it:getId()) == id then
      g_game.open(it, nil)
      return true
    end
  end

  -- 2) tenta findItem (no teu client “pega” bem)
  if type(findItem) == "function" then
    local it = findItem(id)
    if it and it.isContainer and it:isContainer() then
      g_game.open(it, nil)
      return true
    end
  end

  -- 3) varre containers abertos e abre pelo item
  for _, c in pairs(__getContainersSafe()) do
    for _, it in ipairs(c:getItems() or {}) do
      if it and it.isContainer and it:isContainer() and it.getId and tonumber(it:getId()) == id then
        g_game.open(it, nil)
        return true
      end
    end
  end

  return false
end

-- throttle global p/ não spammar open
local __bpOpenRetryUntil = 0

local function __ensureBpIsOpen(bpId)
  bpId = tonumber(bpId) or 0
  if bpId <= 0 then return false end

  -- já tá aberta?
  if __findBPContainer(bpId) then return true end

  local t = __ms()
  if __bpOpenRetryUntil > t then return false end
  __bpOpenRetryUntil = t + 400

  return __forceOpenContainerById(bpId)
end

-- --------------------------
-- Slot livre (drop 1 item se full)
-- --------------------------
local function __playerPos()
  if pos then return pos() end
  if player and player.getPosition then return player:getPosition() end
  return nil
end

local function __keepSlotFree(container)
  if not container then return end

  local cap = container.getCapacity and container:getCapacity() or 20
  local count = container.getItemsCount and container:getItemsCount() or #(container:getItems() or {})
  if count < cap then return end

  local p = __playerPos()
  if not p then return end

  local items = container:getItems() or {}

  -- dropa um item NÃO-container (não dropa bag)
  for i = #items, 1, -1 do
    local it = items[i]
    if it then
      local isCont = (it.isContainer and it:isContainer()) or false
      if not isCont then
        g_game.move(it, p, 1)
        return
      end
    end
  end

  -- fallback: dropa o primeiro
  if items[1] then
    g_game.move(items[1], p, 1)
  end
end

-- --------------------------
-- Detectar se container tem item2/item3
-- --------------------------
local function __containerHasId(container, idA, idB)
  if not container then return false end
  idA = tonumber(idA) or 0
  idB = tonumber(idB) or 0
  if idA <= 0 and idB <= 0 then return false end

  for _, it in ipairs(container:getItems() or {}) do
    if it and it.getId then
      local iid = tonumber(it:getId()) or 0
      if (idA > 0 and iid == idA) or (idB > 0 and iid == idB) then
        return true
      end
    end
  end
  return false
end

-- --------------------------
-- Abrir próxima BP de dentro da BP atual
-- (e retornar o ID aberto)
-- --------------------------
local function __openNextBPInside(container)
  if not container then return 0 end
  for _, it in ipairs(container:getItems() or {}) do
    if it and it.isContainer and it:isContainer() and it.getId then
      local nextId = tonumber(it:getId()) or 0
      if nextId > 0 then
        -- abre como no teu exemplo: g_game.open(item, container)
        g_game.open(it, container)
        delay(200)
        return nextId
      end
    end
  end
  return 0
end

-- --------------------------
-- Linha ativa: full tem prioridade, senão swap
-- --------------------------
local function __getActiveRowByMode(tbl)
  for i = 1, 3 do
    local r = tbl and tbl[i]
    if r and r.ativadorFull == true then return i, r end
  end
  for i = 1, 3 do
    local r = tbl and tbl[i]
    if r and r.ativador == true then return i, r end
  end
  return nil, nil
end

-- --------------------------
-- Estado por linha (qual BP está ativa)
-- --------------------------
local __bpActive = {
  ring   = { [1]=0, [2]=0, [3]=0 },
  amulet = { [1]=0, [2]=0, [3]=0 },
}

-- throttle por linha para abrir próxima / dropar
local __bpTickUntil = {
  ring   = { [1]=0, [2]=0, [3]=0 },
  amulet = { [1]=0, [2]=0, [3]=0 },
}

local function __bpInteligenteTick(kind, idx, row, item2, item3)
  if row.ativadorBP ~= true then return end

  local baseBpId = tonumber(row.backpack) or 0
  if baseBpId <= 0 then return end

  local t = __ms()
  if (__bpTickUntil[kind][idx] or 0) > t then return end
  __bpTickUntil[kind][idx] = t + 250

  -- define BP ativa inicial
  if (__bpActive[kind][idx] or 0) <= 0 then
    __bpActive[kind][idx] = baseBpId
  end

  local activeId = __bpActive[kind][idx]

  -- 1) garantir BP ativa aberta sozinha
  __ensureBpIsOpen(activeId)

  local cont = __findBPContainer(activeId)

  -- fallback: tenta a BP base
  if not cont and activeId ~= baseBpId then
    __bpActive[kind][idx] = baseBpId
    activeId = baseBpId
    __ensureBpIsOpen(activeId)
    cont = __findBPContainer(activeId)
  end

  if not cont then return end

  -- 2) manter 1 slot livre
  __keepSlotFree(cont)

  -- 3) se acabou item2/item3, abre próxima BP dentro e troca activeId
  if not __containerHasId(cont, item2, item3) then
    local nextId = __openNextBPInside(cont)

    if nextId > 0 then
      __bpActive[kind][idx] = nextId
      __sched(250, function()
        __ensureBpIsOpen(nextId)
      end)
      return
    end

    -- ✅ CHEGOU NO ÚLTIMO: não tem item2/3 e não tem próxima BP -> fecha o container
    g_game.close(cont)

    -- evita reabrir em loop (dorme 15s)
    __bpTickUntil[kind][idx] = __ms() + 30000
    return
  end
end

-- ==========================================================
-- MACROS: BP Inteligente Ring / Amulet
-- ==========================================================

macro(200, function()
  if not storage["swapButton"] or storage["swapButton"].enabled ~= true then return end
  local st = storage["panelSwapStorage"]
  if not st or not st.ring then return end

  local idx, row = __getActiveRowByMode(st.ring)
  if not idx or not row then return end

  local item2 = tonumber(row.ringEquipavel) or 0
  local item3 = tonumber(row.ringEquipavelID) or 0

  __bpInteligenteTick("ring", idx, row, item2, item3)
end)

macro(200, function()
  if not storage["swapButton"] or storage["swapButton"].enabled ~= true then return end
  local st = storage["panelSwapStorage"]
  if not st or not st.amulet then return end

  local idx, row = __getActiveRowByMode(st.amulet)
  if not idx or not row then return end

  local item2 = tonumber(row.amuletEquipavel) or 0
  local item3 = tonumber(row.amuletEquipavelID) or 0

  __bpInteligenteTick("amulet", idx, row, item2, item3)
end)
