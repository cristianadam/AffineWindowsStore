This is a standalone CMake project of [Qt Affine Transformations](https://doc.qt.io/qt-6/qtwidgets-painting-affine-example.html) example.

After running `cmake --build <build-dir> --target install` you will be provided with a `affine.appx` package that will be installed under `c:\Program Files\WindowsApps\9801A16D-FCD7-48FD-A132-2ED185569A20_1.0.0.0_x64__q09h79j15ccq6`.

This is meant to showcase how a Qt application can be packaged as a Windows Store package running with `runFullTrust` capabilities.

# Configuration

The project requires either having a `pfx` certificate file or first running from a Visual C++ 2019 command prompt the `make-self-signed-certificate.cmd` shell file.

Then the project should be configured with Visual C++ and a Qt6 installation. I've tested with Qt 6.5.2.

The CMake variable `CMAKE_INSTALL_PREFIX` needs to be set to something else than `c:\Program Files (x86)\affine` which is usually not writable and will cause errors.

After running the `install` target you will be provided with `affine.appx` package file in the build directory.

# Installation

Since we have a self signed certificate, the certificate needs to be installed in the `TrustedPeople` so that when double clicking on `affine.appx` you will be prompted by this image:

![affine-appx-installer](https://github.com/cristianadam/AffineWindowsStore/assets/1257414/98d857e2-10e2-4423-ace8-f995445b35fa)

The certificate installation needs to be done from an Administrator elevated `cmd` window and then running the `install-self-signed-certificate.cmd` shell file.

# Windows Store

Note that I haven't tried to publish this example in the Windows Store, you must deffinately tweak the `CMakeLists.txt` and `AppxManifest.xml.in` files.
