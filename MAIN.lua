local function updateTabsBorder()
  for _, test in pairs(modules.game_bot.botWindow:recursiveGetChildById("botTabs"):getChildren()) do
    for _, test3 in pairs(test:getChildren()) do
      if test3:isChecked(true) then
        test3:setText("LNS")
      end
    end
  end
end

updateTabsBorder()

sepp = UI.Separator():setMarginTop(-0)

local panelName = "codPanel"
local codPanel = setupUI([[
Panel
  id: codPanel
  height: 75
  margin-top: 0

  Label
    id: textLabel2
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    margin-top: 0
    height: 55
    text-align: center
    text-wrap: true
    text-auto-resize: true
    color: gray
    font: verdana-11px-rounded

  Button
    id: buttonDiscord
    anchors.left: prev.left
    anchors.right: prev.right
    anchors.top: prev.bottom
    text: Acessar Discord
    color: orange
    font: verdana-9px
    image-source: /images/ui/button_rounded
    image-color: #363636
    margin-top: 4
    opacity: 1.00
    color: white
    $hover:
      opacity: 0.95
      color: green

  Label
    id: iconDiscord
    anchors.left: prev.left
    anchors.top: prev.top
    margin-top: 1
    size: 20 20
    image-source: /images/ui/discord

  Button
    id: buttonYoutube
    anchors.left: buttonDiscord.left
    anchors.right: buttonDiscord.right
    anchors.top: prev.bottom
    text: YouTube
    font: verdana-9px
    image-source: /images/ui/button_rounded
    image-color: #363636
    margin-top: 4
    opacity: 1.00
    color: red
    $hover:
      opacity: 0.95
      color: white

  Panel
    id: iconYoutube
    anchors.left: prev.left
    anchors.verticalCenter: prev.verticalCenter
    margin-top: -1
    margin-left: 2
    size: 20 13

  HorizontalSeparator
    id: sep2
    anchors.left: buttonYoutube.left
    anchors.right: buttonYoutube.right
    anchors.top: buttonYoutube.bottom
    margin-top: 5
]])
codPanel.textLabel2:setText("[LNS CUSTOM]")
local link = "https://imgur.com/7DxD39S.png"
HTTP.downloadImage(link, function(texId)
  if texId then
    codPanel.iconYoutube:setImageSource(texId)
  else
    warn("Falha ao baixar imagem: " .. link)
  end
end)

codPanel.buttonDiscord.onClick = function()
  modules.game_textmessage.displayGameMessage("Carregando convite ao Discord, aguarde...")
end

local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text

local label = codPanel.textLabel2

-- cores alvo (RGB)
local colors = {
  {r = 160, g = 160, b = 160}, -- cinza
  {r = 255, g = 255, b = 255}, -- branco
  {r = 20,  g = 20,  b = 20},  -- preto
}

local currentColor = 1
local step = 0
local stepsTotal = 40      -- quanto maior, mais suave
local intervalMs = 50      -- velocidade da animação

local function rgbToHex(r, g, b)
  return string.format("#%02X%02X%02X", r, g, b)
end

local function animateLabelColor()
  local from = colors[currentColor]
  local to   = colors[currentColor % #colors + 1]

  step = step + 1
  local t = step / stepsTotal

  local r = math.floor(from.r + (to.r - from.r) * t)
  local g = math.floor(from.g + (to.g - from.g) * t)
  local b = math.floor(from.b + (to.b - from.b) * t)

  label:setColor(rgbToHex(r, g, b))

  if step >= stepsTotal then
    step = 0
    currentColor = currentColor % #colors + 1
  end
end

macro(intervalMs, function()
  if not label then return end
  animateLabelColor()
end)

MyConfigName = modules.game_bot.contentsPanel.config:getCurrentOption().text

local function updateButtonsBot()
    modules.game_bot.contentsPanel.config:setImageColor("gray")
    modules.game_bot.contentsPanel.config:setOpacity(1.00)
    modules.game_bot.contentsPanel.config:setFont("verdana-9px")
    modules.game_bot.contentsPanel.editConfig:setImageColor("gray")
    modules.game_bot.contentsPanel.editConfig:setOpacity(1.00)
    modules.game_bot.contentsPanel.editConfig:setFont("verdana-9px")
    modules.game_bot.contentsPanel.enableButton:setImageColor("gray")
    modules.game_bot.contentsPanel.enableButton:setOpacity(1.00)
    modules.game_bot.contentsPanel.enableButton:setFont("verdana-9px")
    modules.game_bot.botWindow.closeButton:setImageColor("#363434")
    modules.game_bot.botWindow.minimizeButton:setImageColor("#363434")
    modules.game_bot.botWindow.lockButton:setImageColor("#363434")
    modules.game_bot.botWindow:setBorderWidth(1)
    modules.game_bot.botWindow:setImageColor("white")
    modules.game_bot.botWindow:setBorderColor("alpha")
end

updateButtonsBot()

UI.ContainerEx = function(callback, unique, parent, widget)
  if not widget then
    widget = UI.createWidget("BotContainer", parent)
  end
  local oldItems = {}
  local function updateItems()
    local items = widget:getItems()
    local somethingNew = (#items ~= #oldItems)
    for i, item in ipairs(items) do
      if type(oldItems[i]) ~= "table" then
        somethingNew = true
        break
      end
      if oldItems[i].id ~= item.id or oldItems[i].count ~= item.count then
        somethingNew = true
        break
      end
    end
    if somethingNew then
      oldItems = items
      callback(widget, items)
    end
    widget:setItems(items)
  end
  widget.setItems = function(self, items)
    if type(self) == "table" then
      items = self
    end
    local itemsToShow = math.max(10, #items + 2)
    if itemsToShow % 5 ~= 0 then
      itemsToShow = itemsToShow + 5 - itemsToShow % 5
    end
    widget.items:destroyChildren()
    for i = 0, itemsToShow do
      local itemWidget = g_ui.createWidget("BotItem", widget.items)
      if i == 0 then
        itemWidget:setBorderWidth(1)
        itemWidget:setBorderColor("#d7c08a")
      end
      if type(items[i]) == 'number' then
        items[i] = {id = items[i], count = 1}
      end
      if type(items[i]) == 'table' then
        itemWidget:setItem(Item.create(items[i].id, items[i].count))
      end
    end
    oldItems = items
    for _, child in ipairs(widget.items:getChildren()) do
      child.onItemChange = updateItems
    end
  end

  widget.getItems = function()
    local items = {}
    local duplicates = {}
    for _, child in ipairs(widget.items:getChildren()) do
      if child:getItemId() >= 100 then
        if not duplicates[child:getItemId()] or not unique then
          table.insert(items, {
            id = child:getItemId(),
            count = child:getItemCountOrSubType()
          })
          duplicates[child:getItemId()] = true
        end
      end
    end
    return items
  end
  widget:setItems({})
  return widget
end
