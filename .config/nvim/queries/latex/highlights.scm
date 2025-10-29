;; extends

; Ignore LaTeX control sequences and their names
(generic_command) @nospell
(command_name)    @nospell

; Ignore math (nodes from your InspectTree)
(inline_formula)     @nospell
(displayed_equation) @nospell

; Ignore non-prose aux nodes you showed
(citation)         @nospell
(label_definition) @nospell

; Do spell-check the actual prose inside braces/lists (from your tree)
(curly_group (text)                @spell)
(curly_group_text (text)           @spell)
(curly_group_text_list (text)      @spell)
