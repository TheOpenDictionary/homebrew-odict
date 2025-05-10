class Odict < Formula
  desc "Lightning-fast dictionary file format and toolchain"
  homepage "https://odict.org"
  version "2.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.7.0/odict-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7f693590ef4ce52eeca0dcd20ef345466a052f5b033a6c4eaf24b95372b6bf2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.7.0/odict-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c331bab6311f2c2dd4edd2cc69be113a883e70650e52b315d349703a03f136ec"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.7.0/odict-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "30e064ff423934352a9aefab27c07cceb8525a68b411fa6bf5e69d86aa2d462b"
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
