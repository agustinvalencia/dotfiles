-- -- Usage
-- If you are familiar with quickfix, use quickfix as usual.
-- If you don't know quickfix well, you can run :vimgrep /\w\+/j % | copen under a buffer inside nvim to get started quickly.
-- If you want to taste quickfix like demo, check out Integrate with other plugins, and pick up the configuration you like.
-- Filter with signs
-- Press <Tab> or <S-Tab> to toggle the sign of item
-- Press zn or zN will create new quickfix list
-- Fzf mode
-- Press zf in quickfix window will enter fzf mode.
--
-- fzf in nvim-bqf supports ctrl-t/ctrl-x/ctrl-v key bindings that allow you to open up an item in a new tab, a new horizontal split, or in a new vertical split.
--
-- fzf becomes a quickfix filter and create a new quickfix list when multiple items are selected and accepted.
--
-- nvim-bqf also supports ctrl-q to toggle items' sign and adapts preview-half-page-up, preview-half-page-down and toggle-preview fzf's actions for preview.
--
-- Please run man fzf and check out KEY/EVENT BINDINGS section for details.
--
-- There're two ways to adapt fzf's actions for preview function, use ctrl-fand ctrl-b keys as example.
--
-- Make $FZF_DEFAULT_OPTS contains --bind=ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up;
-- Inject extra_opts = {'--bind', 'ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up'} to setup function;
--
return {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
}
