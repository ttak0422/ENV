require 'org-bullets'.setup {
  concealcursor = false,
  symbols = {
    headlines = { '◉', '○', '✸', '✿' },
    checkboxes = {
      cancelled = { '', 'OrgCancelled' },
      done = { '✓', 'OrgDone' },
      todo = { '˟', 'OrgTODO' },
    },
  }
}
