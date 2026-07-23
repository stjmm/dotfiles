local M = {}

M.palette = {
  bg = '#f0efeb',
  bg_alt = '#e0dcd4',

  base0 = '#f5f4f2',
  base1 = '#efeeed',
  base2 = '#e5e3e0',
  base3 = '#d8d6d3',
  base4 = '#b8b5b0',
  base5 = '#9a9791',
  base6 = '#7d7a75',
  base7 = '#5f5c58',
  base8 = '#2d2a27',

  fg = '#1a1d21',
  fg_alt = '#4a4d51',

  red = '#8b6666',
  orange = '#7a6d5a',
  green = '#5a6b5a',
  yellow = '#8b7e52',
  blue = '#5a6b7a',
  cyan = '#64757d',
  teal = '#4d6b6b',
  dark_cyan = '#546470',
}

function M.setup()
  local p = M.palette
  local set = vim.api.nvim_set_hl

  vim.opt.termguicolors = true

  vim.cmd('highlight clear')

  if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
  end

  vim.g.colors_name = 'franek'

  -- Editor UI
  set(0, 'Normal', {
    fg = p.fg,
    bg = p.bg,
  })

  set(0, 'NormalNC', {
    fg = p.fg,
    bg = p.bg,
  })

  set(0, 'NormalFloat', {
    fg = p.fg,
    bg = p.base1,
  })

  set(0, 'FloatBorder', {
    fg = p.base5,
    bg = p.base1,
  })

  set(0, 'FloatTitle', {
    fg = p.base8,
    bg = p.base1,
    bold = true,
  })

  set(0, 'Cursor', {
    fg = p.bg,
    bg = p.base8,
  })

  set(0, 'CursorLine', {
    bg = p.base2,
  })

  set(0, 'CursorColumn', {
    bg = p.base2,
  })

  set(0, 'ColorColumn', {
    bg = p.base2,
  })

  set(0, 'LineNr', {
    fg = p.base6,
    bg = p.bg,
  })

  set(0, 'LineNrAbove', {
    fg = p.base5,
    bg = p.bg,
  })

  set(0, 'LineNrBelow', {
    fg = p.base5,
    bg = p.bg,
  })

  set(0, 'CursorLineNr', {
    fg = p.base8,
    bg = p.base2,
    bold = true,
  })

  set(0, 'SignColumn', {
    fg = p.base7,
    bg = p.bg,
  })

  set(0, 'FoldColumn', {
    fg = p.base6,
    bg = p.bg,
  })

  set(0, 'Folded', {
    fg = p.base7,
    bg = p.base2,
  })

  set(0, 'Visual', {
    fg = p.bg,
    bg = p.base7,
  })

  set(0, 'VisualNOS', {
    fg = p.bg,
    bg = p.base7,
  })

  set(0, 'Search', {
    fg = p.base8,
    bg = p.yellow,
  })

  set(0, 'IncSearch', {
    fg = p.bg,
    bg = p.orange,
  })

  set(0, 'CurSearch', {
    fg = p.bg,
    bg = p.orange,
    bold = true,
  })

  set(0, 'Substitute', {
    fg = p.bg,
    bg = p.red,
  })

  set(0, 'MatchParen', {
    fg = p.blue,
    bold = true,
    underline = true,
  })

  set(0, 'NonText', {
    fg = p.base4,
  })

  set(0, 'Whitespace', {
    fg = p.base3,
  })

  set(0, 'SpecialKey', {
    fg = p.base5,
  })

  set(0, 'EndOfBuffer', {
    fg = p.bg,
  })

  set(0, 'Directory', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'Title', {
    fg = p.base8,
    bold = true,
  })

  set(0, 'Question', {
    fg = p.green,
    bold = true,
  })

  set(0, 'MoreMsg', {
    fg = p.green,
  })

  set(0, 'ModeMsg', {
    fg = p.base8,
    bold = true,
  })

  set(0, 'WarningMsg', {
    fg = p.yellow,
  })

  set(0, 'ErrorMsg', {
    fg = p.red,
    bold = true,
  })

  -- Window separators
  set(0, 'WinSeparator', {
    fg = p.base4,
    bg = p.bg,
  })

  set(0, 'VertSplit', {
    link = 'WinSeparator',
  })

  -- Status line
  set(0, 'StatusLine', {
    fg = p.fg,
    bg = p.base3,
    bold = true,
  })

  set(0, 'StatusLineNC', {
    fg = p.base6,
    bg = p.base2,
  })

  set(0, 'StatusLineTerm', {
    link = 'StatusLine',
  })

  set(0, 'StatusLineTermNC', {
    link = 'StatusLineNC',
  })

  -- Tab line
  set(0, 'TabLine', {
    fg = p.base6,
    bg = p.base2,
  })

  set(0, 'TabLineFill', {
    bg = p.base2,
  })

  set(0, 'TabLineSel', {
    fg = p.base8,
    bg = p.bg,
    bold = true,
  })

  -- Popup menu
  set(0, 'Pmenu', {
    fg = p.fg,
    bg = p.base1,
  })

  set(0, 'PmenuSel', {
    fg = p.base8,
    bg = p.base3,
    bold = true,
  })

  set(0, 'PmenuKind', {
    fg = p.blue,
    bg = p.base1,
  })

  set(0, 'PmenuKindSel', {
    fg = p.blue,
    bg = p.base3,
    bold = true,
  })

  set(0, 'PmenuExtra', {
    fg = p.base6,
    bg = p.base1,
  })

  set(0, 'PmenuExtraSel', {
    fg = p.base7,
    bg = p.base3,
  })

  set(0, 'PmenuSbar', {
    bg = p.base2,
  })

  set(0, 'PmenuThumb', {
    bg = p.base5,
  })

  -- Diff
  set(0, 'DiffAdd', {
    fg = p.green,
    bg = p.base1,
  })

  set(0, 'DiffChange', {
    fg = p.blue,
    bg = p.base1,
  })

  set(0, 'DiffDelete', {
    fg = p.red,
    bg = p.base1,
  })

  set(0, 'DiffText', {
    fg = p.base8,
    bg = p.base3,
    bold = true,
  })

  -- Traditional syntax groups
  set(0, 'Comment', {
    fg = p.base7,
    italic = true,
  })

  set(0, 'Constant', {
    fg = p.teal,
  })

  set(0, 'String', {
    fg = p.fg,
  })

  set(0, 'Character', {
    fg = p.fg,
  })

  set(0, 'Number', {
    fg = p.teal,
  })

  set(0, 'Boolean', {
    fg = p.teal,
    bold = true,
  })

  set(0, 'Float', {
    fg = p.teal,
  })

  set(0, 'Identifier', {
    fg = p.blue,
  })

  set(0, 'Function', {
    fg = p.fg,
  })

  set(0, 'Statement', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'Conditional', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'Repeat', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'Label', {
    fg = p.blue,
  })

  set(0, 'Operator', {
    fg = p.green,
    bold = true,
  })

  set(0, 'Keyword', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'Exception', {
    fg = p.red,
    bold = true,
  })

  set(0, 'PreProc', {
    fg = p.orange,
  })

  set(0, 'Include', {
    fg = p.orange,
    bold = true,
  })

  set(0, 'Define', {
    fg = p.orange,
  })

  set(0, 'Macro', {
    fg = p.orange,
  })

  set(0, 'PreCondit', {
    fg = p.orange,
  })

  set(0, 'Type', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'StorageClass', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'Structure', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'Typedef', {
    fg = p.blue,
  })

  set(0, 'Special', {
    fg = p.orange,
  })

  set(0, 'SpecialChar', {
    fg = p.orange,
  })

  set(0, 'Tag', {
    fg = p.blue,
  })

  set(0, 'Delimiter', {
    fg = p.base7,
  })

  set(0, 'SpecialComment', {
    fg = p.base7,
    italic = true,
  })

  set(0, 'Debug', {
    fg = p.red,
  })

  set(0, 'Underlined', {
    fg = p.blue,
    underline = true,
  })

  set(0, 'Ignore', {
    fg = p.base5,
  })

  set(0, 'Error', {
    fg = p.red,
    bold = true,
  })

  set(0, 'Todo', {
    fg = p.yellow,
    bold = true,
  })

  -- Tree-sitter comments
  set(0, '@comment', {
    link = 'Comment',
  })

  set(0, '@comment.documentation', {
    fg = p.base7,
    italic = true,
  })

  set(0, '@comment.error', {
    fg = p.red,
    bold = true,
  })

  set(0, '@comment.warning', {
    fg = p.yellow,
    bold = true,
  })

  set(0, '@comment.todo', {
    fg = p.yellow,
    bold = true,
  })

  set(0, '@comment.note', {
    fg = p.blue,
    bold = true,
  })

  -- Tree-sitter constants and literals
  set(0, '@constant', {
    link = 'Constant',
  })

  set(0, '@constant.builtin', {
    fg = p.teal,
    bold = true,
  })

  set(0, '@constant.macro', {
    fg = p.orange,
  })

  set(0, '@string', {
    link = 'String',
  })

  set(0, '@string.documentation', {
    fg = p.fg_alt,
  })

  set(0, '@string.regexp', {
    fg = p.green,
  })

  set(0, '@string.escape', {
    fg = p.orange,
    bold = true,
  })

  set(0, '@string.special', {
    fg = p.orange,
  })

  set(0, '@character', {
    link = 'Character',
  })

  set(0, '@character.special', {
    fg = p.orange,
  })

  set(0, '@boolean', {
    link = 'Boolean',
  })

  set(0, '@number', {
    link = 'Number',
  })

  set(0, '@number.float', {
    link = 'Float',
  })

  -- Tree-sitter variables
  set(0, '@variable', {
    fg = p.fg,
  })

  set(0, '@variable.builtin', {
    fg = p.teal,
    italic = true,
  })

  set(0, '@variable.parameter', {
    fg = p.fg_alt,
  })

  set(0, '@variable.parameter.builtin', {
    fg = p.teal,
    italic = true,
  })

  set(0, '@variable.member', {
    fg = p.blue,
  })

  set(0, '@property', {
    fg = p.blue,
  })

  -- Tree-sitter modules and labels
  set(0, '@module', {
    fg = p.dark_cyan,
  })

  set(0, '@module.builtin', {
    fg = p.dark_cyan,
    italic = true,
  })

  set(0, '@label', {
    fg = p.blue,
  })

  -- Tree-sitter functions
  set(0, '@function', {
    link = 'Function',
  })

  set(0, '@function.builtin', {
    fg = p.dark_cyan,
  })

  set(0, '@function.call', {
    link = 'Function',
  })

  set(0, '@function.macro', {
    fg = p.orange,
  })

  set(0, '@function.method', {
    link = 'Function',
  })

  set(0, '@function.method.call', {
    link = 'Function',
  })

  set(0, '@constructor', {
    fg = p.blue,
    bold = true,
  })

  -- Tree-sitter keywords
  set(0, '@keyword', {
    link = 'Keyword',
  })

  set(0, '@keyword.coroutine', {
    link = 'Keyword',
  })

  set(0, '@keyword.function', {
    link = 'Keyword',
  })

  set(0, '@keyword.operator', {
    link = 'Keyword',
  })

  set(0, '@keyword.import', {
    fg = p.orange,
    bold = true,
  })

  set(0, '@keyword.type', {
    link = 'Keyword',
  })

  set(0, '@keyword.modifier', {
    link = 'Keyword',
  })

  set(0, '@keyword.repeat', {
    link = 'Repeat',
  })

  set(0, '@keyword.return', {
    link = 'Keyword',
  })

  set(0, '@keyword.debug', {
    fg = p.red,
  })

  set(0, '@keyword.exception', {
    link = 'Exception',
  })

  set(0, '@keyword.conditional', {
    link = 'Conditional',
  })

  set(0, '@keyword.conditional.ternary', {
    link = 'Conditional',
  })

  set(0, '@keyword.directive', {
    fg = p.orange,
  })

  set(0, '@keyword.directive.define', {
    fg = p.orange,
  })

  -- Tree-sitter operators and punctuation
  set(0, '@operator', {
    link = 'Operator',
  })

  set(0, '@punctuation.delimiter', {
    fg = p.base7,
  })

  set(0, '@punctuation.bracket', {
    fg = p.base7,
  })

  set(0, '@punctuation.special', {
    fg = p.orange,
  })

  -- Tree-sitter types
  set(0, '@type', {
    link = 'Type',
  })

  set(0, '@type.builtin', {
    fg = p.blue,
    bold = true,
  })

  set(0, '@type.definition', {
    fg = p.blue,
  })

  -- Tree-sitter attributes and tags
  set(0, '@attribute', {
    fg = p.orange,
  })

  set(0, '@attribute.builtin', {
    fg = p.orange,
  })

  set(0, '@tag', {
    fg = p.blue,
  })

  set(0, '@tag.builtin', {
    fg = p.blue,
  })

  set(0, '@tag.attribute', {
    fg = p.orange,
  })

  set(0, '@tag.delimiter', {
    fg = p.base7,
  })

  -- Tree-sitter markup
  set(0, '@markup.strong', {
    bold = true,
  })

  set(0, '@markup.italic', {
    italic = true,
  })

  set(0, '@markup.strikethrough', {
    strikethrough = true,
  })

  set(0, '@markup.underline', {
    underline = true,
  })

  set(0, '@markup.heading', {
    fg = p.base8,
    bold = true,
  })

  set(0, '@markup.heading.1', {
    fg = p.base8,
    bold = true,
  })

  set(0, '@markup.heading.2', {
    fg = p.blue,
    bold = true,
  })

  set(0, '@markup.heading.3', {
    fg = p.green,
    bold = true,
  })

  set(0, '@markup.quote', {
    fg = p.base7,
    italic = true,
  })

  set(0, '@markup.math', {
    fg = p.teal,
  })

  set(0, '@markup.link', {
    fg = p.blue,
  })

  set(0, '@markup.link.label', {
    fg = p.blue,
    underline = true,
  })

  set(0, '@markup.link.url', {
    fg = p.dark_cyan,
    underline = true,
  })

  set(0, '@markup.raw', {
    fg = p.green,
  })

  set(0, '@markup.raw.block', {
    fg = p.green,
  })

  set(0, '@markup.list', {
    fg = p.orange,
  })

  set(0, '@markup.list.checked', {
    fg = p.green,
  })

  set(0, '@markup.list.unchecked', {
    fg = p.base7,
  })

  -- Tree-sitter diff
  set(0, '@diff.plus', {
    fg = p.green,
  })

  set(0, '@diff.minus', {
    fg = p.red,
  })

  set(0, '@diff.delta', {
    fg = p.blue,
  })

  -- Diagnostics
  set(0, 'DiagnosticError', {
    fg = p.red,
  })

  set(0, 'DiagnosticWarn', {
    fg = p.yellow,
  })

  set(0, 'DiagnosticInfo', {
    fg = p.green,
  })

  set(0, 'DiagnosticHint', {
    fg = p.base7,
  })

  set(0, 'DiagnosticOk', {
    fg = p.green,
  })

  set(0, 'DiagnosticVirtualTextError', {
    fg = p.red,
    bg = p.base1,
  })

  set(0, 'DiagnosticVirtualTextWarn', {
    fg = p.yellow,
    bg = p.base1,
  })

  set(0, 'DiagnosticVirtualTextInfo', {
    fg = p.green,
    bg = p.base1,
  })

  set(0, 'DiagnosticVirtualTextHint', {
    fg = p.base7,
    bg = p.base1,
  })

  set(0, 'DiagnosticUnderlineError', {
    undercurl = true,
    sp = p.red,
  })

  set(0, 'DiagnosticUnderlineWarn', {
    undercurl = true,
    sp = p.yellow,
  })

  set(0, 'DiagnosticUnderlineInfo', {
    undercurl = true,
    sp = p.green,
  })

  set(0, 'DiagnosticUnderlineHint', {
    undercurl = true,
    sp = p.base7,
  })

  set(0, 'DiagnosticFloatingError', {
    fg = p.red,
  })

  set(0, 'DiagnosticFloatingWarn', {
    fg = p.yellow,
  })

  set(0, 'DiagnosticFloatingInfo', {
    fg = p.green,
  })

  set(0, 'DiagnosticFloatingHint', {
    fg = p.base7,
  })

  set(0, 'DiagnosticSignError', {
    fg = p.red,
    bg = p.bg,
  })

  set(0, 'DiagnosticSignWarn', {
    fg = p.yellow,
    bg = p.bg,
  })

  set(0, 'DiagnosticSignInfo', {
    fg = p.green,
    bg = p.bg,
  })

  set(0, 'DiagnosticSignHint', {
    fg = p.base7,
    bg = p.bg,
  })

  -- LSP references
  set(0, 'LspReferenceText', {
    bg = p.base2,
  })

  set(0, 'LspReferenceRead', {
    bg = p.base2,
  })

  set(0, 'LspReferenceWrite', {
    bg = p.base3,
    bold = true,
  })

  set(0, 'LspSignatureActiveParameter', {
    fg = p.base8,
    bg = p.base3,
    bold = true,
  })

  set(0, 'LspCodeLens', {
    fg = p.base6,
  })

  set(0, 'LspCodeLensSeparator', {
    fg = p.base4,
  })

  set(0, 'LspInlayHint', {
    fg = p.base6,
    bg = p.base1,
    italic = true,
  })

  -- LSP semantic tokens
  set(0, '@lsp.type.comment', {
    link = '@comment',
  })

  set(0, '@lsp.type.string', {
    link = '@string',
  })

  set(0, '@lsp.type.number', {
    link = '@number',
  })

  set(0, '@lsp.type.regexp', {
    link = '@string.regexp',
  })

  set(0, '@lsp.type.operator', {
    link = '@operator',
  })

  set(0, '@lsp.type.namespace', {
    link = '@module',
  })

  set(0, '@lsp.type.type', {
    link = '@type',
  })

  set(0, '@lsp.type.class', {
    link = '@type',
  })

  set(0, '@lsp.type.enum', {
    link = '@type',
  })

  set(0, '@lsp.type.interface', {
    link = '@type',
  })

  set(0, '@lsp.type.struct', {
    link = '@type',
  })

  set(0, '@lsp.type.typeParameter', {
    fg = p.blue,
  })

  set(0, '@lsp.type.parameter', {
    link = '@variable.parameter',
  })

  set(0, '@lsp.type.variable', {
    link = '@variable',
  })

  set(0, '@lsp.type.property', {
    link = '@property',
  })

  set(0, '@lsp.type.enumMember', {
    link = '@constant',
  })

  set(0, '@lsp.type.function', {
    link = '@function',
  })

  set(0, '@lsp.type.method', {
    link = '@function.method',
  })

  set(0, '@lsp.type.macro', {
    link = '@function.macro',
  })

  set(0, '@lsp.type.decorator', {
    link = '@attribute',
  })

  -- Spell checking
  set(0, 'SpellBad', {
    undercurl = true,
    sp = p.red,
  })

  set(0, 'SpellCap', {
    undercurl = true,
    sp = p.yellow,
  })

  set(0, 'SpellLocal', {
    undercurl = true,
    sp = p.green,
  })

  set(0, 'SpellRare', {
    undercurl = true,
    sp = p.blue,
  })

  -- Git signs commonly used by plugins
  set(0, 'GitSignsAdd', {
    fg = p.green,
  })

  set(0, 'GitSignsChange', {
    fg = p.blue,
  })

  set(0, 'GitSignsDelete', {
    fg = p.red,
  })

  -- Telescope
  set(0, 'TelescopeNormal', {
    fg = p.fg,
    bg = p.base1,
  })

  set(0, 'TelescopeBorder', {
    fg = p.base5,
    bg = p.base1,
  })

  set(0, 'TelescopePromptNormal', {
    fg = p.fg,
    bg = p.base2,
  })

  set(0, 'TelescopePromptBorder', {
    fg = p.base5,
    bg = p.base2,
  })

  set(0, 'TelescopePromptTitle', {
    fg = p.base8,
    bg = p.base2,
    bold = true,
  })

  set(0, 'TelescopeSelection', {
    fg = p.base8,
    bg = p.base3,
    bold = true,
  })

  set(0, 'TelescopeMatching', {
    fg = p.blue,
    bold = true,
  })

  -- Completion menu
  set(0, 'CmpItemAbbr', {
    fg = p.fg,
  })

  set(0, 'CmpItemAbbrDeprecated', {
    fg = p.base5,
    strikethrough = true,
  })

  set(0, 'CmpItemAbbrMatch', {
    fg = p.blue,
    bold = true,
  })

  set(0, 'CmpItemAbbrMatchFuzzy', {
    fg = p.blue,
  })

  set(0, 'CmpItemKind', {
    fg = p.dark_cyan,
  })

  set(0, 'CmpItemMenu', {
    fg = p.base6,
  })

  -- Indentation guides
  set(0, 'IblIndent', {
    fg = p.base3,
  })

  set(0, 'IblScope', {
    fg = p.base5,
  })

  set(0, 'IndentBlanklineChar', {
    fg = p.base3,
  })

  set(0, 'IndentBlanklineContextChar', {
    fg = p.base5,
  })
end

return M
