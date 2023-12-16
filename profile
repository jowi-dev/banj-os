

times in msec
 clock   self+sourced   self:  sourced script
 clock   elapsed:              other lines

000.066  000.066: --- NVIM STARTING ---
000.908  000.842: event init
001.349  000.442: early init
001.709  000.360: locale set
002.014  000.305: init first window
004.374  002.360: inits 1
004.471  000.097: window checked
004.486  000.015: parsing arguments
006.987  000.284  000.284: require('vim.shared')
007.986  000.241  000.241: require('vim._options')
008.001  000.993  000.752: require('vim._editor')
008.009  001.443  000.167: require('vim._init_packages')
008.019  002.090: init lua interpreter
008.476  000.456: expanding arguments
008.685  000.210: inits 2
010.316  001.631: init highlight
010.332  000.016: waiting for UI
012.071  001.739: done waiting for UI
012.159  000.087: clear screen
013.012  000.853: init default mappings & autocommands
014.520  001.508: --cmd commands
080.293  000.186  000.186: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/ftplugin.vim
081.188  000.108  000.108: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/indent.vim
084.737  000.612  000.612: require('actions.test')
085.348  000.597  000.597: require('actions.gpt')
086.005  000.647  000.647: require('actions.http_post')
086.605  000.589  000.589: require('actions.gql_request')
087.162  000.524  000.524: require('actions.http_request')
087.724  000.553  000.553: require('actions.copy_to_clipboard')
088.392  000.655  000.655: require('actions.build_environment')
088.933  000.531  000.531: require('actions.send_to_note')
088.985  000.029  000.029: require('vim.keymap')
094.184  000.019  000.019: require('vim.F')
094.497  004.755  004.736: require('vim.diagnostic')
095.062  012.154  002.663: require('keybindings')
097.196  000.276  000.276: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/syntax/synload.vim
099.505  000.063  000.063: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/ultisnips/ftdetect/snippets.vim
099.811  000.074  000.074: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/vim-elixir/ftdetect/elixir.vim
100.055  000.035  000.035: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/vim-fugitive/ftdetect/fugitive.vim
100.380  000.056  000.056: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/vim-nix/ftdetect/nix.vim
101.927  003.585  003.357: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/filetype.lua
106.492  003.968  003.968: require('vim.filetype')
113.351  003.921  003.921: require('vim.filetype.detect')
114.240  018.076  006.325: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/syntax/syntax.vim
116.625  002.191  002.191: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/awesome-vim-colorschemes/colors/angr.vim
118.891  000.530  000.530: require('lualine_require')
120.035  003.375  002.845: require('lualine')
125.370  001.539  001.539: require('lualine.highlight')
145.776  000.349  000.349: require('lualine.utils.mode')
147.106  052.032  026.502: require('opts')
149.568  000.581  000.581: require('telescope._extensions')
149.584  001.258  000.677: require('telescope')
156.009  001.022  001.022: require('plenary.bit')
156.587  000.565  000.565: require('plenary.functional')
156.694  000.053  000.053: require('ffi')
156.760  004.160  002.521: require('plenary.path')
157.066  005.353  001.193: require('plenary.log')
157.151  005.911  000.558: require('telescope.log')
160.620  001.698  001.698: require('plenary.job')
161.545  000.912  000.912: require('plenary.strings')
162.104  000.548  000.548: require('telescope.state')
162.137  004.979  001.821: require('telescope.utils')
162.156  012.557  001.668: require('telescope.sorters')
163.475  000.645  000.645: require('telescope.previewers.previewer')
166.748  000.506  000.506: require('telescope.deprecated')
166.916  000.131  000.131: require('vim.inspect')
173.622  008.703  008.066: require('telescope.config')
174.233  000.593  000.593: require('telescope.from_entry')
174.473  010.924  001.627: require('telescope.previewers.term_previewer')
179.865  001.136  001.136: require('telescope.previewers.utils')
184.954  005.075  005.075: require('plenary.scandir')
185.344  010.861  004.650: require('telescope.previewers.buffer_previewer')
185.363  023.192  000.762: require('telescope.previewers')
191.470  043.743  006.736: require('package_configs/telescope')
195.687  000.376  000.376: require('cmp.utils.debug')
196.880  000.571  000.571: require('cmp.utils.char')
196.906  001.206  000.635: require('cmp.utils.str')
199.016  000.762  000.762: require('cmp.utils.misc')
199.358  000.329  000.329: require('cmp.utils.buffer')
199.848  000.481  000.481: require('cmp.utils.api')
199.868  002.503  000.932: require('cmp.utils.keymap')
199.888  002.975  000.472: require('cmp.utils.feedkeys')
202.925  000.384  000.384: require('cmp.types.cmp')
203.630  000.693  000.693: require('cmp.types.lsp')
203.916  000.274  000.274: require('cmp.types.vim')
203.926  001.686  000.336: require('cmp.types')
203.951  002.418  000.731: require('cmp.config.mapping')
204.301  000.345  000.345: require('cmp.utils.cache')
205.721  000.882  000.882: require('cmp.config.compare')
205.734  001.421  000.538: require('cmp.config.default')
205.770  004.983  000.799: require('cmp.config')
205.825  005.931  000.949: require('cmp.utils.async')
206.689  000.358  000.358: require('cmp.utils.pattern')
206.706  000.875  000.516: require('cmp.context')
210.267  000.851  000.851: require('cmp.matcher')
210.294  002.478  001.628: require('cmp.entry')
210.317  003.606  001.128: require('cmp.source')
211.544  000.374  000.374: require('cmp.utils.event')
213.467  000.324  000.324: require('cmp.utils.options')
213.489  001.303  000.979: require('cmp.utils.window')
213.498  001.943  000.640: require('cmp.view.docs_view')
215.421  000.437  000.437: require('cmp.utils.autocmd')
215.452  001.949  001.512: require('cmp.view.custom_entries_view')
216.412  000.954  000.954: require('cmp.view.wildmenu_entries_view')
217.148  000.725  000.725: require('cmp.view.native_entries_view')
217.827  000.669  000.669: require('cmp.view.ghost_text_view')
217.863  007.541  000.928: require('cmp.view')
219.790  026.206  003.695: require('cmp.core')
220.711  000.360  000.360: require('cmp.config.sources')
221.046  000.321  000.321: require('cmp.config.window')
221.225  028.903  002.016: require('cmp')
223.883  032.399  003.496: require('package_configs/cmp')
225.805  000.914  000.914: require('null-ls.utils')
226.036  001.686  000.771: require('null-ls.config')
226.662  000.313  000.313: require('null-ls.helpers.cache')
227.376  000.701  000.701: require('null-ls.helpers.diagnostics')
227.689  000.302  000.302: require('null-ls.helpers.formatter_factory')
229.191  000.410  000.410: require('null-ls.logger')
229.862  000.659  000.659: require('null-ls.state')
229.879  002.176  001.106: require('null-ls.helpers.generator_factory')
230.880  000.469  000.469: require('null-ls.helpers.command_resolver')
230.892  001.006  000.537: require('null-ls.helpers.make_builtin')
231.277  000.380  000.380: require('null-ls.helpers.range_formatting_args_factory')
231.287  005.240  000.362: require('null-ls.helpers')
234.238  001.227  001.227: require('null-ls.methods')
234.258  002.010  000.783: require('null-ls.diagnostics')
234.287  002.995  000.985: require('null-ls.sources')
234.688  000.390  000.390: require('null-ls.builtins')
234.700  010.800  000.489: require('null-ls')
235.404  000.694  000.694: require('null-ls.builtins.diagnostics.credo')
236.241  000.820  000.820: require('null-ls.builtins.diagnostics.eslint')
245.404  001.225  001.225: require('telescope.builtin')
252.014  001.090  001.090: require('plenary.window.border')
252.467  000.441  000.441: require('plenary.window')
252.920  000.443  000.443: require('plenary.popup.utils')
253.008  003.526  001.552: require('plenary.popup')
253.781  000.766  000.766: require('telescope.pickers.scroller')
254.368  000.576  000.576: require('telescope.actions.state')
255.144  000.766  000.766: require('telescope.actions.utils')
257.309  000.955  000.955: require('telescope.actions.mt')
257.412  002.258  001.303: require('telescope.actions.set')
259.189  000.929  000.929: require('telescope.config.resolve')
259.203  001.783  000.854: require('telescope.pickers.entry_display')
260.212  014.794  005.119: require('telescope.actions')
267.337  000.478  000.478: require('plenary.tbl')
267.356  001.124  000.647: require('plenary.vararg.rotate')
267.362  001.530  000.405: require('plenary.vararg')
267.868  000.501  000.501: require('plenary.errors')
267.889  002.717  000.687: require('plenary.async.async')
270.575  000.613  000.613: require('plenary.async.structs')
270.623  001.553  000.941: require('plenary.async.control')
270.655  002.307  000.753: require('plenary.async.util')
270.663  002.767  000.461: require('plenary.async.tests')
270.675  006.027  000.542: require('plenary.async')
271.542  000.858  000.858: require('telescope.debounce')
272.728  001.174  001.174: require('telescope.mappings')
273.551  000.810  000.810: require('telescope.pickers.highlights')
274.140  000.576  000.576: require('telescope.pickers.window')
274.781  000.631  000.631: require('telescope.pickers.layout')
276.444  000.802  000.802: require('telescope.algos.linked_list')
276.461  001.670  000.868: require('telescope.entry_manager')
277.102  000.634  000.634: require('telescope.pickers.multi')
277.182  016.958  004.578: require('telescope.pickers')
283.740  005.662  005.662: require('telescope.make_entry')
284.552  000.798  000.798: require('telescope.finders.async_static_finder')
287.068  000.531  000.531: require('plenary.class')
287.264  001.960  001.429: require('telescope._')
287.275  002.713  000.753: require('telescope.finders.async_oneshot_finder')
287.904  000.623  000.623: require('telescope.finders.async_job_finder')
287.924  010.734  000.938: require('telescope.finders')
288.588  000.654  000.654: require('telescope.themes')
289.028  000.430  000.430: require('plenary.debug_utils')
293.846  004.808  004.808: require('plenary.filetype')
294.700  000.840  000.840: require('telekasten.utils.taglinks')
295.522  000.809  000.809: require('telekasten.utils.tags')
296.198  000.666  000.666: require('telekasten.utils.links')
300.578  003.483  003.483: require('telekasten.utils.luadate')
300.598  004.389  000.907: require('telekasten.utils.dates')
301.208  000.602  000.602: require('telekasten.utils.files')
301.724  000.505  000.505: require('telekasten.templates')
302.257  000.522  000.522: require('telekasten.pickers')
302.777  000.511  000.511: require('telekasten.utils')
302.915  065.657  007.208: require('telekasten')
328.651  181.530  027.418: require('package_config')
340.474  001.275  001.275: require('vim.lsp.log')
343.063  002.571  002.571: require('vim.lsp.protocol')
349.339  001.497  001.497: require('vim.lsp._snippet')
350.118  000.767  000.767: require('vim.highlight')
350.173  007.095  004.831: require('vim.lsp.util')
350.212  013.079  002.137: require('vim.lsp.handlers')
352.159  001.939  001.939: require('vim.lsp.rpc')
353.254  001.082  001.082: require('vim.lsp.sync')
355.110  001.845  001.845: require('vim.lsp.semantic_tokens')
357.221  002.098  002.098: require('vim.lsp.buf')
358.290  001.057  001.057: require('vim.lsp.diagnostic')
359.535  001.234  001.234: require('vim.lsp.codelens')
359.970  027.670  005.335: require('vim.lsp')
360.239  029.211  001.542: require('lspconfig.util')
360.849  000.598  000.598: require('lspconfig.async')
360.864  030.932  001.123: require('lspconfig.configs')
360.874  031.439  000.507: require('lspconfig')
361.429  000.543  000.543: require('lspconfig.server_configurations.clangd')
363.374  001.025  001.025: require('lspconfig.manager')
364.982  000.522  000.522: require('cmp_nvim_lsp.source')
364.999  001.036  000.515: require('cmp_nvim_lsp')
365.896  000.466  000.466: require('lspconfig.server_configurations.elixirls')
366.450  003.060  001.558: require('languages/elixir')
367.050  000.473  000.473: require('lspconfig.server_configurations.graphql')
368.785  000.466  000.466: require('lspconfig.server_configurations.tsserver')
369.831  000.479  000.479: require('nvim-lsp-ts-utils.options')
370.639  000.796  000.796: require('nvim-lsp-ts-utils.utils')
371.249  000.599  000.599: require('nvim-lsp-ts-utils.client')
371.692  000.433  000.433: require('nvim-lsp-ts-utils.define-commands')
372.115  000.413  000.413: require('nvim-lsp-ts-utils.organize-imports')
373.344  001.221  001.221: require('nvim-lsp-ts-utils.import-all')
373.995  000.640  000.640: require('nvim-lsp-ts-utils.rename-file')
374.497  000.492  000.492: require('nvim-lsp-ts-utils.import-on-completion')
375.598  000.379  000.379: require('nvim-lsp-ts-utils.loop')
375.642  001.135  000.756: require('nvim-lsp-ts-utils.watcher')
376.534  000.885  000.885: require('nvim-lsp-ts-utils.inlay-hints')
376.552  007.706  000.612: require('nvim-lsp-ts-utils')
377.241  009.565  001.393: require('languages/typescript')
377.705  000.450  000.450: require('lspconfig.server_configurations.zls')
379.232  000.994  000.994: require('lspconfig.server_configurations.rust_analyzer')
381.929  000.486  000.486: require('lspconfig.server_configurations.html')
383.279  000.464  000.464: require('lspconfig.server_configurations.cssls')
384.438  000.531  000.531: require('lspconfig.server_configurations.lua_ls')
385.119  056.448  007.417: require('languages')
385.729  000.598  000.598: require('aliases')
385.744  303.074  000.311: sourcing /nix/store/jldhc09hpg45mn7ir8gmn187004abq0h-nvim-init-home-manager.vim
385.761  303.264  000.190: sourcing /home/jowi/.config/nvim/init.lua
385.783  067.705: sourcing vimrc file(s)
422.710  001.667  001.667: sourcing /home/jowi/.nix-profile/share/nvim/site/plugin/fzf.vim
424.602  000.428  000.428: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/gzip.vim
424.742  000.036  000.036: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/health.vim
450.931  000.600  000.600: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/pack/dist/opt/matchit/plugin/matchit.vim
457.183  032.369  031.768: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/matchit.vim
457.761  000.487  000.487: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/matchparen.vim
458.854  000.999  000.999: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/netrwPlugin.vim
459.297  000.031  000.031: sourcing /nix/store/9q4r0sz6f26p2qb2r9mcxwhmbj7lmk39-neovim-0.9.4/rplugin.vim
459.669  000.699  000.667: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/rplugin.vim
459.970  000.194  000.194: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/shada.vim
460.151  000.076  000.076: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/spellfile.vim
460.571  000.326  000.326: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/tarPlugin.vim
460.962  000.274  000.274: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/tohtml.vim
461.113  000.055  000.055: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/tutor.vim
461.652  000.450  000.450: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/zipPlugin.vim
473.203  000.221  000.221: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/editorconfig.lua
473.543  000.236  000.236: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/man.lua
473.894  000.171  000.171: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/plugin/nvim.lua
474.310  049.836: loading rtp plugins
539.357  000.586  000.586: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/autoload/nerdtree.vim
541.179  000.967  000.967: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/path.vim
541.779  000.281  000.281: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/menu_controller.vim
542.242  000.160  000.160: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/menu_item.vim
542.770  000.237  000.237: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/key_map.vim
543.534  000.447  000.447: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/bookmark.vim
544.284  000.407  000.407: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/tree_file_node.vim
545.483  000.853  000.853: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/tree_dir_node.vim
546.262  000.370  000.370: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/opener.vim
547.080  000.482  000.482: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/creator.vim
547.537  000.104  000.104: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/flag_set.vim
548.123  000.270  000.270: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/nerdtree.vim
549.073  000.628  000.628: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/ui.vim
549.504  000.058  000.058: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/event.vim
549.925  000.096  000.096: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/lib/nerdtree/notifier.vim
551.214  000.976  000.976: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/autoload/nerdtree/ui_glue.vim
559.024  000.258  000.258: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/nerdtree_plugin/exec_menuitem.vim
562.291  001.367  001.367: sourcing /nix/store/xq1si67s6h5yzj6whnxrllhy1mqnzkz6-neovim-unwrapped-0.9.4/share/nvim/runtime/autoload/provider/clipboard.vim
563.460  004.321  002.953: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/nerdtree_plugin/fs_menu.vim
563.786  000.114  000.114: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/nerdtree/nerdtree_plugin/vcs.vim
565.154  088.385  076.771: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/nerdtree/plugin/NERD_tree.vim
566.945  000.569  000.569: require('cmp.utils.highlight')
568.190  002.167  001.597: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/nvim-cmp/plugin/cmp.lua
568.844  000.253  000.253: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/nvim-jqx/plugin/nvim-jqx.vim
571.726  001.494  001.494: require('vim.version')
576.481  006.793  005.299: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/nvim-lspconfig/plugin/lspconfig.lua
577.313  000.096  000.096: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/plenary.nvim/plugin/plenary.vim
578.009  000.102  000.102: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/telekasten.nvim/plugin/telekasten.vim
579.840  001.132  001.132: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/telescope.nvim/plugin/telescope.lua
580.306  000.070  000.070: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/tmuxline.vim/plugin/tmuxline.vim
581.820  000.219  000.219: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/ultisnips/autoload/UltiSnips/map_keys.vim
582.054  001.213  000.994: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/ultisnips/plugin/UltiSnips.vim
586.013  003.269  003.269: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/vim-fugitive/plugin/fugitive.vim
588.161  000.520  000.520: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/vim-gitgutter/autoload/gitgutter/utility.vim
589.738  000.350  000.350: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/vim-gitgutter/autoload/gitgutter/highlight.vim
592.525  005.849  004.978: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/vim-gitgutter/plugin/gitgutter.vim
593.210  000.098  000.098: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/vim-merginal/plugin/merginal.vim
593.787  000.037  000.037: sourcing /nix/store/jc8ar3d82l0y9r7jx8fsipwvpj23z34p-packdir-start/pack/myNeovimPackages/start/vim-nix/plugin/nix.vim
617.056  033.284: loading packages
618.448  000.272  000.272: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/ultisnips/after/plugin/UltiSnips_after.vim
620.556  000.216  000.216: require('cmp_buffer.timer')
620.574  001.042  000.826: require('cmp_buffer.buffer')
620.583  001.488  000.446: require('cmp_buffer.source')
620.590  001.625  000.137: require('cmp_buffer')
620.689  001.804  000.180: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/cmp-buffer/after/plugin/cmp_buffer.lua
621.946  000.816  000.816: require('cmp_cmdline')
622.013  000.943  000.127: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/cmp-cmdline/after/plugin/cmp_cmdline.lua
622.515  000.119  000.119: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua
623.815  000.863  000.863: require('cmp_path')
623.885  000.990  000.127: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/cmp-path/after/plugin/cmp_path.lua
624.119  002.935: loading after plugins
624.163  000.044: inits 3
628.333  004.170: reading ShaDa
629.159  000.826: opening buffers
630.479  000.376  000.376: sourcing /nix/store/yys8c0rd4zirmx3pmrl9csfc4wp0ygkq-vim-pack-dir/pack/myNeovimPackages/start/vim-gitgutter/autoload/gitgutter.vim
631.209  001.673: BufEnter autocommands
631.218  000.010: editing files in windows
631.578  000.359: VimEnter autocommands
631.586  000.009: UIEnter autocommands
631.596  000.010: before starting main loop
633.288  001.692: first screen update
633.297  000.009: --- NVIM STARTED ---


times in msec
 clock   self+sourced   self:  sourced script
 clock   elapsed:              other lines

000.038  000.038: --- NVIM STARTING ---
000.632  000.595: event init
000.997  000.364: early init
001.224  000.227: locale set
001.371  000.147: init first window
003.190  001.819: inits 1
003.229  000.038: window checked
003.237  000.009: parsing arguments
005.120  000.277  000.277: require('vim.shared')
005.586  000.164  000.164: require('vim._options')
005.594  000.453  000.289: require('vim._editor')
005.598  000.837  000.107: require('vim._init_packages')
005.606  001.531: init lua interpreter
007.952  002.347: expanding arguments
008.161  000.209: inits 2
009.263  001.102: init highlight
