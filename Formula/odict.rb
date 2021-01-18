class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/odict/odict/archive/1.4.tar.gz"
  sha256 "81bab611bcf93b6b8baac2e11fa6a5aa7ca907509bd5ad654fe58c2bfcafac1d"
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
