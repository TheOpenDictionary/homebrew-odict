class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/odict/odict/archive/1.1.tar.gz"
  sha256 "da9f1fc8e197bce675322ebce417e99a26a5ef1d123994349f6d6623c0cbefd0"

  depends_on "go" => :build

  def install
    system "go", "install"
    system "go", "build", "-o", "#{bin}/odict"
  end

  test do
    system "#{bin}/odict", "--help"
  end
end
