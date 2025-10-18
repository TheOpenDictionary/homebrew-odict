class Odict < Formula
  desc "Lightning-fast dictionary file format and toolchain"
  homepage "https://odict.org"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v3.0.0/odict-cli-aarch64-apple-darwin.tar.xz"
      sha256 "65aa6fa0aa61655fc2cc21f20fabe4121907fad45a6b48c2b5f3d8d8f35314d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v3.0.0/odict-cli-x86_64-apple-darwin.tar.xz"
      sha256 "87c4de9c461664c1ad06d2341eceaf60688b9e1e347bb88d1113b4b4735f39da"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v3.0.0/odict-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "9605954b056b99f7dbe42367884398dc644be1c33aac5a6819efce590c48a72f"
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
