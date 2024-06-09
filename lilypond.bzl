load("@bazel_skylib//lib:paths.bzl", "paths")

def _lilypond_impl(ctx):
  if not ctx.attr.png_out and not ctx.attr.midi_out:
    fail("PNG or MIDI output (or both) must be enabled")

  toolchain = ctx.toolchains["@bazel_lilypond//:lilypond_toolchain_type"]
  args = ctx.actions.args()

  if ctx.attr.png_out:
    args.add("--png")

  args.add("--output", paths.dirname(ctx.outputs.outs[0].path))
  args.add(ctx.file.src.path)

  ctx.actions.run(
    mnemonic = "Lilypond",
    executable = toolchain.lilypond.files.to_list()[0].path,
    arguments = [args],
    inputs = depset(
      direct=[ctx.file.src],
      transitive = [toolchain.lilypond.files]
    ),
    outputs = ctx.outputs.outs,
  )
  return [DefaultInfo(files = depset(ctx.outputs.outs))]


_lilypond = rule(
  attrs = {
    "src": attr.label(allow_single_file=[".ly"], mandatory = True),
    "png_out": attr.bool(default=True),
    "midi_out": attr.bool(default=True),
    "outs": attr.output_list(),
  },
  toolchains = ["@bazel_lilypond//:lilypond_toolchain_type"],
  implementation = _lilypond_impl,
)

def lilypond(**kwargs):
  if 'src' not in kwargs:
    kwargs['src'] = kwargs['name'] + ".ly"
  kwargs['outs'] = []
  if kwargs.get('png_out', True):
    kwargs['outs'].append(paths.replace_extension(kwargs['src'], '.png'))
  if kwargs.get('midi_out', True):
    kwargs['outs'].append(paths.replace_extension(kwargs['src'], '.midi'))
  _lilypond(**kwargs)

