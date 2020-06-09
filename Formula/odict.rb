class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/odict/odict/archive/1.0.tar.gz"
  sha256 "ca4f9217a4158a265338e9d21a7d123639113119d35bbe4c8118db85a36a84b3"

  depends_on "go" => :build

  def install
    system "go", "install"
    system "go", "build", "-o", "#{bin}/odict"
  end

  test do
    system "#{bin}/odict", "--help"
  end
end
