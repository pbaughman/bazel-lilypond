# Lilypond build rules for Bazel.

To build [Lilypond](https://lilypond.org) files with Bazel, add the following
to your MODULE.bazel:

```
bazel_dep(
  name = "bazel_lilypond"
)

git_override(
  module_name = "bazel_lilypond",
  remote = "https://github.com/pbaughman/bazel-lilypond.git",
  commit = "58b7074",  # Or a different commit if you want
)
```

Then, in your project's build file, turn .ly files into PNGs and MIDI files
like this:

```
load("@bazel_lilypond//:lilypond.bzl", "lilypond")

lilypond(
  name="the_greatest_song_in_the_world",
  src="the_greatest_song_in_the_world.ly",  # Optional
  png_out=True,  # Optional
  midi_out=True  # Optional
)
```

## Limitations

While lilypond publishes binaries for Linux, Windows, and MacOS, currently
`bazel_lilypond` only has a toolchain defined for Linux.  Adding support
for other platforms should be straightforward, but right now I don't have
the right host systems to check that I did it correctly.

Also, many of the lilypond command-line options are not plumbed out through the
bazel rule, but these can be added as needed.
