class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/TheOpenDictionary/odict/archive/1.4.3.tar.gz"
  sha256 "9157b79ce39ae201d40ad5aa3a2692cc9b72233c83f041f6552ffce8b4b15d60"
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
