class Odict < Formula
  desc "Lightning-fast dictionary file format and toolchain"
  homepage "https://odict.org"
  version "2.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.3.0/odict-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2067a0af48739ebf0f2dfe1f8d1eb8e00e9f58d7274d76f586de8b564f0ff03a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.3.0/odict-cli-x86_64-apple-darwin.tar.xz"
      sha256 "76b52c41f4f44b2c28cdfdc945c15cb4b3f17b7c16aceb0084f0138edb1f73b3"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.3.0/odict-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "7fd3d3051649b8cf92d97ab38df01ec44e8b82161f4edf252107a0f2a8c73f45"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "odict" if OS.mac? && Hardware::CPU.arm?
    bin.install "odict" if OS.mac? && Hardware::CPU.intel?
    bin.install "odict" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
