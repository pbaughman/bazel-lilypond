load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load(":toolchain.bzl", "lilypond_toolchain")

bzl_library(
  name = "lilypond",
  srcs = ["lilypond.bzl"],
)

toolchain_type(
  name = "lilypond_toolchain_type",
  visibility = ["//visibility:public"]
)

lilypond_toolchain(
  name="lilypond_linux",
  lilypond="@lilypond_bin_linux_x86_64//:bin/lilypond",
)

toolchain(
  name = "lilypond_linux_toolchain",
  exec_compatible_with = [
    "@platforms//os:linux",
    "@platforms//cpu:x86_64",
  ],
  toolchain = ":lilypond_linux",
  toolchain_type = ":lilypond_toolchain_type",
)

