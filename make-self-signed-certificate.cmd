@echo off

makecert -r -pe -n "CN=qt-project.org" -a sha256 -e 01/01/2028 -sky exchange -sv affine_TemporaryKey.pvk affine_TemporaryKey.cer
pvk2pfx -pvk affine_TemporaryKey.pvk -spc affine_TemporaryKey.cer -pfx affine_TemporaryKey.pfx
