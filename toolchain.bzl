def _lilypond_toolchain_impl(ctx):
  return [
    platform_common.ToolchainInfo(
      lilypond = ctx.attr.lilypond,
    ),
  ]

lilypond_toolchain = rule(
  implementation = _lilypond_toolchain_impl,
  attrs = {
    "lilypond": attr.label(
      allow_single_file = True,
      cfg = "exec",
      executable = True
    )
  }
)
