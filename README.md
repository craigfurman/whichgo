# whichgo
Another version manager for Go. Inspired by [GVM](https://github.com/moovweb/gvm).

## Installation
1. clone this repository somewhere
1. add `source /path/to/whichgo/whichgo.sh` to your `.bash_profile`/`.zshrc`/shell profile of your choice.
1. optionally add `whichgo use goX.Y.Z` (replace version) to your shell profile to select a default Go version when you load a shell.

## Removal
1. remove relevant `source` lines from your shell profile.
1. remove the repo from wherever you cloned it.
1. `rm -rf ~/.whichgo`

## Usage
`whichgo list` - lists locally installed Go versions.

`whichgo list --all` - lists all available go versions. **You do not need to update whichgo for this list to be updated.**

`whichgo install GO_VERSION` - installs Go. GO_VERSION must match a version name from `whichgo list --all`.

`whichgo use GO_VERSION`. Use the specified version of Go.

### A note about Go 1.5+
The Go compiler was rewritten in Go for 1.5. To compile Go 1.5+, you must have a previous version of Go already installed, and set `$GOROOT_BOOTSTRAP` to point to this installation. E.g:

1. `whichgo install go1.4.3`
1. `whichgo use go1.4.3`
1. `GOROOT_BOOTSTRAP=$GOROOT whichgo install go1.5.3`
1. `whichgo use go1.5.3`

## TODO
* more graceful error messages: e.g. when trying to install a version of Go that does not exist.
* install binary dependencies for versions prior to 1.5 (https://github.com/golang/go/wiki/InstallFromSource)
* automatic setting of `$GOROOT_BOOTSTRAP` to use an older version of Go (e.g. 1.4) to compile 1.5+.

## Won't add
* automatic `whichgo use` on `cd`. I recommend using [direnv](https://github.com/direnv/direnv) for this. To call functions (like `whichgo`) from a `.envrc`, you will need to source the `whichgo.sh` file first:
```
. ~/code/whichgo/whichgo.sh
whichgo use go1.4.3
```

## Why did I make yet another Go version manager?
I like [GVM](https://github.com/moovweb/gvm), but I wanted something simpler that never modified my $GOPATH. If you are looking for more features I would recommend GVM.
