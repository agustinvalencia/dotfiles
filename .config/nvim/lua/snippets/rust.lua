local ls = require("luasnip")

-- These are the functions we'll use to build snippets
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local fmt = require("luasnip.extras.fmt").fmt
--
-- Helper: insert visual selection if present, else give placeholder
local function visual_or_insert(_, parent)
  local env = parent.snippet.env or {}
  local selected = env.SELECT_DEDENT or env.SELECT_RAW or ""
  if selected ~= "" then
    return ls.snippet_node(nil, ls.text_node(selected))
  else
    return ls.snippet_node(nil, ls.insert_node(1))
  end
end

return {
  -- #[derive(macro1, macro2)]
  s(
    {
      trig = "derive",
      name = "Derive macro",
      dscr = "Insert a macro block",
    },
    fmt(
      [[
#[derive({macros})]
{cursor}]],
      {
        macros = i(1, "macros"),
        cursor = i(0),
      }
    )
  ),

  -- struct StructName {
  -- field: type
  -- }
  s(
    {
      trig = "struct",
      name = "Struct definition",
      dscr = "Struct definition",
    },
    fmt(
      [[
struct {structName} {{
    {field}: {type},{cursor}
}}]],
      {
        structName = i(1, "structName"),
        field = i(2, "field"),
        type = i(3, "type"),
        cursor = i(0),
      }
    )
  ),

  -- struct StructName {
  -- field: type
  -- }
  s(
    {
      trig = "pub struct",
      name = "Struct definition",
      dscr = "Struct definition",
    },
    fmt(
      [[
pub struct {structName} {{
    pub {field}: {type},{cursor}
}}]],
      {
        structName = i(1, "structName"),
        field = i(2, "field"),
        type = i(3, "type"),
        cursor = i(0),
      }
    )
  ),
}
