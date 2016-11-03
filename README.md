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

Add some fixup commits and autosquash them:

```shell
$ echo "Cool changes!" >> README.md
$ git commit -a --fixup {ref-to-my-readme-commit}
$ echo "Dependency: zlib=1.2.0" >> deps.json
$ git commit -a --fixup {ref-to-my-zlib-commit}
```

And to squash them:

```shell
$ git wip autosquash
```

[git]: https://git-scm.com/
