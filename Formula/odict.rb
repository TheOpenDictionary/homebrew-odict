class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  version "1.5.0"
  url "https://github.com/TheOpenDictionary/odict/archive/refs/tags/1.5.0.tar.gz"
  sha256 "c886d6e4bc7a94385548b3d72d1e69326303c2ae688b690085469b4685b2b78b"
  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "flatbuffers" => :build

  def install
    system "make", "cli-build"
    bin.install "bin/odict" => "odict"
  end

  test do
    system "#{bin}/odict", "--help"
  end
end
