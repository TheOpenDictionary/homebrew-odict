class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/odict/odict/archive/1.3.tar.gz"
  sha256 "6bc9b9fa56848d39bf6a69ca3d98249407e0bb59d2685728fbe513bee1e9852f"

  depends_on "go" => :build

  def install
    system "go", "install"
    system "go", "build", "-o", "#{bin}/odict"
  end

  test do
    system "#{bin}/odict", "--help"
  end
end
