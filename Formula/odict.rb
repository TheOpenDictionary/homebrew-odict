class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/TheOpenDictionary/odict/archive/1.4.5.tar.gz"
  sha256 "d278002e52c3c43076103e6de31cdd9e052260993267aaeb74f4716de9b86bfa"
  depends_on "go" => :build
  depends_on "bazel" => :build 

  def install
    system "bazel", "build", "cli"
    bin.install "bazel-bin/cli/odict" => "odict"
  end

  test do
    system "#{bin}/odict", "--help"
  end
end
