class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/odict/odict/archive/1.3.tar.gz"
  sha256 "6a0735789b83f875983b385f0762b9e42a47c356cf4da6651d913f05737d85e4"
  depends_on "go" => :build

  def install
    system "sh", "scripts/build.sh"
    bin.install "bin/odict" => "odict"
  end

  test do
    system "#{bin}/odict", "--help"
  end
end
