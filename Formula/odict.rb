class Odict < Formula
  desc "Lightning-fast dictionary file format and toolchain"
  homepage "https://odict.org"
  version "3.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v3.2.0/odict-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8e0945f18d17d82bdbe6af99fc4efcab8395811393b0b6fb1781ebe66f356a95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v3.2.0/odict-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ba1df21089f07f99263326de161ff2360c800774ae6010237d162321fb595b1a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v3.2.0/odict-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "b07e4c6e087324be122df3994cdb90904384c17fcb5f91aae015140a1ed0113f"
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
