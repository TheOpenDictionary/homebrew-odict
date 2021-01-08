class Odict < Formula
  desc "Command-line utility for the ODict dictionary format"
  homepage "https://odict.org"
  url "https://github.com/odict/odict/archive/1.2.tar.gz"
  sha256 "2ff7603538d58250ff24fb72ecc4933ecef172f4485afb428bb6ff8963807575"

  depends_on "go" => :build

  def install
    system "go", "install"
    system "go", "build", "-o", "#{bin}/odict"
  end

  test do
    system "#{bin}/odict", "--help"
  end
end
