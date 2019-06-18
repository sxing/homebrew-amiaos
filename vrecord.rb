class Vrecord < Formula
  desc "Capturing a video signal and turning it into a digital file"
  homepage "https://github.com/amiaopensource/vrecord"
  url "https://github.com/amiaopensource/vrecord/archive/v2019-05-03.tar.gz"
  version "2019-05-03"
  sha256 "8775b2502c33d1a0397250a78f6527194897c39865ae3855e832f1ee8a736693"
  head "https://github.com/amiaopensource/vrecord.git"

  bottle :unneeded

  depends_on "amiaopensource/amiaos/decklinksdk"
  depends_on "amiaopensource/amiaos/ffmpegdecklink"
  depends_on "amiaopensource/amiaos/gtkdialog"
  depends_on "cowsay"
  depends_on "freetype"
  depends_on "gnuplot"
  depends_on "mediaconch"
  depends_on "mkvtoolnix"
  depends_on "mpv"
  depends_on "pandoc"
  depends_on "qcli"
  depends_on "sdl"
  depends_on "xmlstarlet"

  def install
    bin.install "vrecord"
    bin.install "vtest"
    prefix.install "Resources/qcview.lua"
    prefix.install "Resources/vrecord_policy_ffv1.xml"
    prefix.install "Resources/vrecord_policy_uncompressed.xml"
    prefix.install "Resources/vrecord logo.png"
    prefix.install "Resources/vrecord logo playback.png"
    prefix.install "Resources/vrecord logo audio.png"
    prefix.install "Resources/vrecord logo edit.png"
    prefix.install "Resources/vrecord logo help.png"
    prefix.install "Resources/vrecord logo documentation.png"
    prefix.install "Resources"
    man1.install "vrecord.1"
    man1.install "vtest.1"
  end

  def post_install
    puts "Building local Documentation"
    command = "pandoc -f markdown -t html5 <(cat #{prefix}/README.md <(echo) #{prefix}/Resources/Documentation/installation_and_setup.md <(echo) #{prefix}/Resources/Documentation/vrecord_window.md <(echo) #{prefix}/Resources/Documentation/passthrough.md <(echo) #{prefix}/Resources/Documentation/settings.md <(echo) #{prefix}/Resources/Documentation/gui_mode.md <(echo) #{prefix}/Resources/Documentation/analog_digitization.md <(echo) #{prefix}/Resources/Documentation/troubleshooting.md | sed 's/Resources\\/Documentation\\/installation_and_setup\\.md\\|Resources\\/Documentation\\/passthrough\\.md\\|Resources\\/Documentation\\/settings\\.md\\|Resources\\/Documentation\\/troubleshooting\\.md//g' | sed 's/Resources\\/Documentation\\/analog\\_digitization.md/\\#analog_digitization\\.md/g') -o #{prefix}/Resources/Documentation/vrecord-docs.html -c https://github.githubassets.com/assets/github-3be7a33928202f4784cddb229421674d.css"
    system("/bin/bash", "-c", command)
  end

  test do
    system "#{bin}/vrecord", "-h"
  end
end