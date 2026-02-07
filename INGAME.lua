setDefaultTab("Tools")
UI.Separator():setMarginTop(-0)

ingameList = setupUI([[  
UIWindow
  id: listIngame
  size: 200 220

  Button
    id: buttonIngame
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    text: Adicionar Script
    font: verdana-9px
    height: 18
    image-source: /images/ui/button_rounded
    image-color: #828282

  FlatPanel
    id: background
    anchors.top: prev.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    opacity: 1.00
    margin-top: 2

  VerticalScrollBar
    id: contentScroll
    anchors.top: prev.top
    margin-top: 1
    margin-bottom: 1
    anchors.right: parent.right
    anchors.bottom: prev.bottom
    margin-right: 0
    step: 28
    pixels-scroll: true

  ScrollablePanel
    id: content
    anchors.top: prev.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: prev.bottom
    vertical-scrollbar: contentScroll

    Panel
      id: ingameScriptList
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      margin-top: 1
      margin-left: 5
      margin-right: 15
      margin-bottom: 3
      layout:
        type: verticalBox
        fit-children: true
]])

local scriptsIngameEditor = ingameList.content.ingameScriptList

-- =========================
-- EDITOR LNS (WINDOW PRÓPRIA)
-- =========================
local function LnsEditorWindow(text, opts, onSave)
  opts = opts or {}
  local root = g_ui.getRootWidget()

  local win = setupUI([[
UIWindow
  id: lnsEditor
  size: 380 300
  draggable: true
  anchors.centerIn: parent

  Panel
    id: background
    anchors.fill: parent
    background-color: black
    opacity: 0.92

  Panel
    id: topPanel
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 28
    background-color: black

    Label
      id: title
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.top: parent.top
      text-align: center
      size: 120 30
      text: LNS Custom | Ingame Script Editor
      color: orange

  TextList
    id: textBg
    anchors.top: topPanel.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: bottomPanel.top
    margin-top: 6
    margin-left: 8
    margin-right: 12
    margin-bottom: 6
    image-color: #828282

  VerticalScrollBar
    id: textScroll
    anchors.top: textBg.top
    anchors.bottom: textBg.bottom
    anchors.right: textBg.right
    margin-right: 2
    step: 14
    pixels-scroll: true

  TextEdit
    id: textContent
    anchors.top: textBg.top
    anchors.left: textBg.left
    anchors.right: textScroll.left
    anchors.bottom: textBg.bottom
    margin-left: 2
    margin-top: 2
    margin-right: 2
    margin-bottom: 2
    vertical-scrollbar: textScroll
    image-source:
    color: white
    font: verdana-9px
    multiline: true
    text-wrap: true

  Panel
    id: bottomPanel
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: 34

  Button
    id: btnSave
    anchors.right: btnClose.left
    anchors.bottom: parent.bottom
    margin-right: 6
    margin-bottom: 8
    text: Salvar
    width: 70
    height: 20
    font: verdana-9px
    image-source: /images/ui/button_rounded
    image-color: #363636
    color: white

  Button
    id: btnClose
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    margin-right: 10
    margin-bottom: 8
    text: Fechar
    width: 70
    height: 20
    font: verdana-9px
    image-source: /images/ui/button_rounded
    image-color: orange
    color: white
]], root)

  -- título
  if opts.title and win.topPanel and win.topPanel.title then
    win.topPanel.title:setText(opts.title)
  end

  -- tamanho opcional
  if opts.width and opts.height then
    win:setSize({ width = 380, height = 400 })
  end

  -- texto inicial
  win.textContent:setText(text or "")

  local function closeWin()
    if win and type(win.destroy) == "function" then
      win:destroy()
    end
  end

  win.btnSave.onClick = function()
    if type(onSave) == "function" then
      onSave(win.textContent:getText())
    end
    closeWin()
  end

  win.btnClose.onClick = closeWin

  win:show()
  win:raise()
  win:focus()

  return win
end

-- =========================
-- ABRIR EDITOR
-- =========================
ingameList.buttonIngame.onClick = function()
  LnsEditorWindow(storage.ingame_hotkeys or "", { title = "LNS Custom | Ingame Script", width = 380, height = 300 }, function(text)
    storage.ingame_hotkeys = text
    reload()
  end)
end

-- =========================
-- EXECUÇÃO PADRÃO (IGUAL SEU EXEMPLO)
-- =========================
for _, scripts in pairs({ storage.ingame_hotkeys }) do
  if type(scripts) == "string" and scripts:len() > 3 then
    local originalMacro = macro

    if not originalMacro then
      error("A função global 'macro' não foi encontrada.")
      return
    end

    macro = function(time, name, func, panel, ...)
      if panel == nil then
        originalMacro(time, name, func, scriptsIngameEditor, ...)
      else
        originalMacro(time, name, func, panel, ...)
      end
    end

    local status, result = pcall(function()
      assert(load(scripts, "ingame_editor"))()
    end)

    macro = originalMacro

    if not status then
      error("Ingame editor error:\n" .. result)
    end
  end
end

UI.Separator()
