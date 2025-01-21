``:q!`` quit vi

command mode you cannot type anything

Arrow keys to move in command mode or use hjkl

- h left
- j down
- k up
- l right

in command mode to execute commands ``:!<command>`` (omit <>)

``i`` insert mode
``esc`` exit insert mode

``:w`` save changes

``:q`` discard changes add ``!`` to override

``:wq`` save and quit

``G`` go to last line

``a`` move one character forward and enter insert mode

``A`` move to end line and enter insert mode

``dl`` delete character

``d4l`` delete 4 letters

``dw`` delete word

``d5w`` delete 5 words

``dd`` delete line

``d2d`` delete 2 lines

``cw`` replace word

``o`` goto now line and enter insert mode

``yy`` yank (copy) line

``p`` paste

``y3y`` yank (copy) 3 lines

``yw`` yank word

``y3w`` yank 3 words

``/is`` search for is  press ``n`` for next  ``?is`` reverse search with ``n``

``:s/text/replaced/switch``

switches

i ignore

g global

c ask for confirmation

igc all words in one line are repleaced

``:%s/hello/goodbye/igc`` replace all hellos in all lines with goodbye, and ask for conformation

