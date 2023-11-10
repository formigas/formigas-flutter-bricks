# Framwork bricks

There are currently two bricks in this reposiory:

- core: core flutter app inspired by [very_good_ventures][very_good_ventures_link]
- feature: a brick that provides the files and strucu for a freature how we implement it at [formigas][formigas_link]

[very_good_ventures_link]: https://github.com/VeryGoodOpenSource/very_good_core
[formigas_link]: https://formigas.io

# Usage

## Preparation

If not done, add the formigas_core brick to your local mason:

```sh
$ mason init
$ mason add formigas_core --git-url git@git.dev.formigas.de:framework/bricks.git --git-path core --git-ref develop
```

The formigas_core brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_core 0.1.0 -> git@git.dev.formigas.de:framework/bricks.git#{commit-hash}
```

## Core

Create a new formigas core application

```sh
mason make formigas_core
```

## Feature

To add a new feature to your app run the following command in the root of your project:

```sh
mason make formigas_core
```

# Helpful links

- [VGV Core Brick](https://github.com/VeryGoodOpenSource/very_good_core)
- [Brick Hub Development](https://docs.brickhub.dev/brick-development)
- [Mason](https://github.com/felangel/mason)
