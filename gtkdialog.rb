class Gtkdialog < Formula
  desc "Small utility for fast and easy GUI building"
  homepage "https://code.google.com/archive/p/gtkdialog/"
  if OS.mac?
    url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/gtkdialog/gtkdialog-0.8.3.tar.gz"
    sha256 "ff89d2d7f1e6488e5df5f895716ac1d4198c2467a2a5dc1f51ab408a2faec38e"
  else
    url "https://github.com/puppylinux-woof-CE/gtkdialog/archive/0.8.4d.tar.gz"
    sha256 "1d3619ef1aca2baa783b936e8c6bd67135621f47428049c8231db9ee366f73db"
  end
  revision 2

  depends_on "atk" => :build
  depends_on "cairo" => :build
  depends_on "fontconfig" => :build
  depends_on "freetype" => :build
  depends_on "fribidi" => :build
  depends_on "gdk-pixbuf" => :build
  depends_on "gettext" => :build
  depends_on "glib" => :build
  depends_on "graphite2" => :build
  depends_on "gtk+" => :build
  depends_on "harfbuzz" => :build
  depends_on "libepoxy" => :build
  depends_on "libffi" => :build
  depends_on "libpng" => :build
  depends_on "libpthread-stubs" => :build
  depends_on "libtiff" => :build
  depends_on "libx11" => :build
  depends_on "libxau" => :build
  depends_on "libxcb" => :build
  depends_on "libxdmcp" => :build
  depends_on "libxext" => :build
  depends_on "libxrender" => :build
  depends_on "pango" => :build
  depends_on "pixman" => :build
  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build

  on_linux do
    depends_on "autoconf" => :build
    depends_on "automake" => :build  
  end

  # Update patch to compile gtkdialog on macOS
  # See: http://www.murga-linux.com/puppy/viewtopic.php?t=108945
  patch :DATA if OS.mac?

  def install
  	if OS.mac?
      system "./configure"
      system "make"
    else
      system "./autogen.sh"
      system "make"
    end
    bin.install "src/gtkdialog"
  end
end

__END__
diff -urN a/src/automaton.c b/src/automaton.c
--- a/src/automaton.c	2017-11-16 07:27:06.000000000 +0200
+++ b/src/automaton.c	2017-11-16 07:21:33.000000000 +0200
@@ -1295,7 +1295,7 @@
    Miert nem kapja meg az adatokat parameterben es foglalkozik
    a veremmel a hivo?
  */
-#ifdef __arm__
+#if defined(__arm__) || defined(__APPLE__)
 /* 120701 BK Puppy Linux forum member jamesbond fixed this for arm cpus...*/
 stackelement _sum(stackelement b, stackelement a)
 #else
diff -urN a/src/variables.c b/src/variables.c
--- a/src/variables.c	2017-11-16 07:27:06.000000000 +0200
+++ b/src/variables.c	2017-11-16 07:22:42.000000000 +0200
@@ -1113,7 +1113,7 @@
 		actual = root;
 
 	if (actual == NULL)
-		return;
+		return 0;
 
 	if (actual->left != NULL)
 		n = do_variables_count_widgets(actual->left, n);
