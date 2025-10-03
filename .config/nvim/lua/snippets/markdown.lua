local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

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

-- Common languages to cycle through
local LANGS = { "", "bash", "sh", "python", "cpp", "c", "json", "lua", "rust", "ts", "js", "yaml", "toml" }

return {
  ls.snippet(
    {
      trig = "code",
      name = "Fenced code block",
      dscr = "Insert a fenced code block; choose language; optional info string; wraps selection if present",
    },
    fmt(
      [[
```{lang}{info}
{body}
```
{cursor}]],
      {
        lang = ls.choice_node(
          1,
          (function()
            local nodes = {}
            for _, l in ipairs(LANGS) do
              table.insert(nodes, ls.text_node(l))
            end
            return nodes
          end)()
        ),
        info = ls.choice_node(2, {
          ls.text_node(""),
          fmt(" {}", { ls.insert_node(1, "title='snippet'") }),
        }),
        body = ls.dynamic_node(3, visual_or_insert, {}),
        cursor = ls.insert_node(0),
      }
    )
  ),
}
