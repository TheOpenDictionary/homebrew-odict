class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/TheOpenDictionary/odict/archive/1.4.5.tar.gz"
  sha256 "e540133567ed44d905934b40ed5f057763065e2b9d8294b049884969be615db0"
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
