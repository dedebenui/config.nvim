return {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {
        invert_colors = '{"rest": "<option>","image": "<option>"}',
        open_cmd = "/usr/bin/open %s",
        port = 51616,
        debug = true,
    },
}
