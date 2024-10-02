## Godot Action

Actions for releasing godot build to various platforms.

All actions assume you are using the following container for the jobs:
(update godot version to the one you are using)

```yml
container:
    image: barichello/godot-ci:4.3
```

### Godot Build

A composite actions that simplifies the build process for you. Intended to be usind in a matrix:

```yml
strategy:
    matrix:
    channel: [web, win, linux]
```

### Godot Env

Setup godot environment build file

### Changelog

Generate changelog between tags