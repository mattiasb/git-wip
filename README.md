# Git-wip #

`git-wip` is a [git][git] extension to make working with continually rebased and
force-pushed work-in-progress branches a breeze.

## Examples ##

Run an interactive rebase on all commits in your wip (work-in-progress) branch:

```shell
$ git wip reapply
```

View the log of this wip branch:

```shell
$ git wip log
```

Add some fixup- and squash commits:

```shell
$ echo "Cool changes!" >> README.md
$ git wip fixup -a
$ echo "Dependency: zlib=1.2.0" >> deps.json
$ git wip squash -a
```

And to perform the actual fixup/squash:

```shell
$ git wip autosquash
```

[git]: https://git-scm.com/
