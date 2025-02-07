return {
  "christoomey/vim-tmux-navigator",
  vim.keymap.set("n", "C-h", "TmuxNavigateLeft<CR>", { desc = "Navigate to the left tmux pane" }),
  vim.keymap.set("n", "C-l", "TmuxNavigateRight<CR>", { desc = "Navigate to the right tmux pane" }),
  vim.keymap.set("n", "C-j", "TmuxNavigateDown<CR>", { desc = "Navigate to the bottom tmux pane" }),
  vim.keymap.set("n", "C-k", "TmuxNavigateUp<CR>", { desc = "Navigate to the top tmux pane" }),
}
