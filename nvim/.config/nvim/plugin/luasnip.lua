require("luasnip.loaders.from_vscode").lazy_load()

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

ls.config.setup({
  update_events = "TextChanged,TextChangedI",
})

local title = function(index)
  return f(function(arg)
    return string.gsub(arg[1][1], "^.", string.upper)
  end, { index })
end

ls.add_snippets("javascript", {
  s({
    trig = "l",
    name = "console.log",
  }, fmt([[console.log({});]], { i(0) })),
  s({
    trig = "rs",
    name = "useState",
  }, fmt([[const [{}, set{}] = useState({});]], { i(1), title(1), i(2) })),
  s({
    trig = "rr",
    name = "useRef",
  }, fmt([[const {} = useRef({});]], { i(1), i(2) })),
  s(
    {
      trig = "re",
      name = "useEffect",
    },
    fmt(
      [[
      useEffect(() => {{
        {}
      }}, [{}]);
    ]] ,
      { i(1), i(2) }
    )
  ),
  s(
    {
      trig = "rm",
      name = "useMemo",
    },
    fmt(
      [[
      const {} = useMemo(() => {{
        {}
      }}, [{}]);
    ]] ,
      { i(1), i(2), i(3) }
    )
  ),
  s(
    {
      trig = "rc",
      name = "useCallback",
    },
    fmt(
      [[
      const {} = useCallback(() => {{
        {}
      }}, [{}]);
    ]] ,
      { i(1), i(2), i(3) }
    )
  ),
})

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })
