# [TUMX](https://github.com/tmux/tmux/wiki/Getting-Started)

## References

- [Ubuntu Based Guide](https://www.shells.com/l/en-US/tutorial/Installing-and-using-tmux-on-Ubuntu-20-04)
- [A beginners guide to tmux basics](https://www.youtube.com/watch?v=-B5VDp50daI&ab_channel=typecraft)
- [Be a tmux KING with Tmuxifier](https://www.youtube.com/watch?v=ceRYL271cao&t=3s&ab_channel=typecraft)
- [Dracula Theme](https://draculatheme.com/tmux)

## Install

### Install [Plugin Manager](https://github.com/tmux-plugins/tpm)

Inside tmux install plugins
```
<leader>I
```

## Leader Key

```
<CR>b
```

## Config Location

### Linux

~/.tmux.conf

#### Update config changes

```
<leader>:source ~/.tmux.conf
```

## Commands

### Open new tmux session

```sh
tmux
```

### Open new terminal window

```
<leader>c
```

### Switch between terminal windows

```
<leader>w
or
<leader><window-number>
```

### move to a different session

```
<leader>s
```

### Detach from a session

```
<leader>d
```

### Reattch to session

```
tmux ls
tmux attach-session -t <session-id>
```

### Create Session name

```
tmux new -s <session-name>
```

### Kill Session

```
<leader>:kill-session
```

### Splitting Windows

#### Horizontal Split

```
<leader>%
```

#### Vertical Split

```
<leader>"
```

### Rename the current window

```
<leader>,
```

### Go to the next pane

```
<leader>o
```

### Toggle between the current and previous pane

```
<leader>;
```

### Move window from one place to another with

```
<leader>{
```

```
<leader>}
```

### Close the current pane

```
<leader> x
```

### See different layouts

```
<leader>" "
```

### Scroll on console

```
<leader><page-up>
```

```
<leader><page-down>
```

### Copy mode

```
<leader>[
```

To highlight
```
v
```

To copy to buffer

```
<enter>
```


Paste buffer

```
<leader>]
```

### New Session 

- custom

```
<leader>S
```

### Kill Session

- custom

```
<leader>K
```

## [tmuxifier](https://github.com/jimeh/tmuxifier)

Create new a template

```
tmuxifier new-session <my-template>
```


Create load an existing template

```
tmuxifier load-session <my-template>
```

Create edit an existing template

```
tmuxifier edit-session <my-template>
```
