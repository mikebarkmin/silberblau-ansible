# Getting Started

## Prerequisites

* Fedora Silverblue
* `curl` or `wget` should be installed
* `git` should be installed

## Installation

Everything is installed by running one of the following commands in your
terminal. You can install this via the command-line with either `curl`, `wget`
or a similar tool.

| Method | Command |
|--------|---------|
|curl|`sh -c "$(curl -fsSL https://raw.githubusercontent.com/mikebarkmin/ansible/main/bin/install.sh)`|
|wget|`sh -c "$(curl -fsSL https://raw.githubusercontent.com/mikebarkmin/ansible/main/bin/install.sh)`|

You can choose

### Manual Installation

It's a good idea to inspect the install script from projects you don't yet
know. You can do that by downloading the install script first, looking through
it so everything looks normal, then running it:

```
wget https://raw.githubusercontent.com/mikebarkmin/ansible/main/bin/install.sh
sh install.sh
```

## Profiles

There are two profiles which can be chosen.

- work: This is my work setup
- personal: This is my personal setup

Both profiles are connected to private git repositories. Therefore, these can
not be used by someone else.

If you want to try the repo out, you can use the `demo` profile.

| Profile | Command |
|--|--|
| personal | (Private) Will use the `silberkarpfen` host vars |
| work | (Private) Will use the `silberfisch` host vars |
| demo | (Public) Will use the `demo` host vars |

## Applying an Update

If you have change something in `.dotfiles` or in `Sources/ansible` you can run
`dotr` and `ansr` to apply the updates. Everything from `.dotfiles` will be
symlinks, so you only need to run `dotr` if you have created new files.

## Committing Updates

You can just run `dotc` and `ansc` for committing with an automatic message.
