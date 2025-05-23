class Odict < Formula
  desc "Lightning-fast dictionary file format and toolchain"
  homepage "https://odict.org"
  version "2.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.8.0/odict-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d24be53abafb43e4976ef2adbd4c2f7282659a342ee8e1a8e136d93c2458882a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.8.0/odict-cli-x86_64-apple-darwin.tar.xz"
      sha256 "62cecc204c491342474537363b2f2e2fa423c4bb03407939aec7f845ac12dc5f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/TheOpenDictionary/odict/releases/download/cli/v2.8.0/odict-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e8e15a03f866b30db9b9d6830205f5565b2cc3dabf633c21c5a1eef4c320bdc5"
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
