# Made by Avianca17
# Feel free to use, edit, or redistribute this script as you see fit, but please give credit! Thank you! :)))

pkgname=simpleroot

pkgver=1.0

pkgrel=1

pkgdesc="A script to simplify the process of chrooting into a new environment without manually typing the required commands to mount the virtual filesystems!"

arch=('any')

license=('MIT')

source=('simpleroot.sh')

sha256sums=('SKIP')

package() {
    cd "$srcdir"
    # Install and rename into the system path
    install -Dm755 simpleroot.sh "$pkgdir/usr/bin/$pkgname"
}
