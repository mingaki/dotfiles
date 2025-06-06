local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local c = ls.choice_node
-- local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets("markdown", {
    s(
        "det",
        fmt(
            [[<details>
  <summary>{}</summary>
  {}
</details>]],
            {
                i(1),
                i(0),
            }
        )
    ),
})

ls.filetype_extend("quarto", { "markdown" })

ls.add_snippets("markdown", {
    -- code cell
    s(
        "`",
        fmta(
            [[```<lang>
<last>
``]],
            {
                lang = c(1, { t("python"), t("lua"), t("") }),
                last = i(0),
            }
        )
    ),
})
