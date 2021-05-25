class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/TheOpenDictionary/odict/archive/1.4.5.tar.gz"
  sha256 "50ef737cce963025f4076bcb52f2c82fc64c1ab8b53747e80fa36a382c696a44"
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
