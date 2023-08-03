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

ls.cleanup()

ls.config.setup({
	update_events = "TextChanged,TextChangedI",
	region_check_events = 'InsertEnter',
	delete_check_events = 'InsertLeave',
})

local title = function(index)
	return f(function(arg)
		return string.gsub(arg[1][1], "^.", string.upper)
	end, { index })
end

local basename_or_dirname = function(index)
	return f(function()
		-- for file basename:
		local basename = vim.fn.expand("%:t:r")
		if basename:match("^%u") then
			return basename
		end
		return vim.fn.expand("%:h:t")
	end, { index })
end

ls.add_snippets("javascript", {
	s({
		trig = "l",
		name = "console.log",
	}, fmt([[console.log({});]], { i(0) })),
	s({
		trig = "e",
		name = "console.error",
	}, fmt([[console.error({});]], { i(0) })),
	s({
		trig = "r",
		name = "return",
	}, fmt([[return ]], {})),
	s({
		trig = "us",
		name = "useState",
	}, fmt([[const [{}, set{}] = useState({});]], { i(1), title(1), i(2) })),
	s({
		trig = "ur",
		name = "useRef",
	}, fmt([[const {} = useRef({});]], { i(1), i(2) })),
	s(
		{
			trig = "ue",
			name = "useEffect",
		},
		fmt(
			[[
                          useEffect(() => {{
                            {}
                          }}, [{}]);
                        ]],
			{ i(1), i(2) }
		)
	),
	s(
		{
			trig = "um",
			name = "useMemo",
		},
		fmt(
			[[
                          const {} = useMemo(() => {{
                            {}
                          }}, [{}]);
                        ]],
			{ i(1), i(2), i(3) }
		)
	),
	s(
		{
			trig = "uc",
			name = "useCallback",
		},
		fmt(
			[[
                          const {} = useCallback(() => {{
                            {}
                          }}, [{}]);
                        ]],
			{ i(1), i(2), i(3) }
		)
	),
})

ls.add_snippets("vue", {
	s(
		{
			trig = "vue",
			name = "Satellite Vue Component",
		},
		fmt(
			[[
                          <template src="./{}.html"></template>

                          <script lang="ts">
                          import Vue from 'vue'

                          export default Vue.extend({{
                            {}
                          }})
                          </script>

                          <style scoped lang="less" src="./{}.less"></style>
                        ]],
			{
				basename_or_dirname(),
				i(0),
				basename_or_dirname(),
			}
		)
	),
})

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })
ls.filetype_extend("vue", { "javascript" })
