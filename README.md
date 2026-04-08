# RK3588 Android 12 HEVC Main10 SDR Fix

This repository documents a working fix for the green-line / green-screen issue seen on some RK3588 / RK3588S Android 12 devices when playing 1080p HEVC Main10 SDR video.

## Result
Verified behavior on the target device:
- 1080p HEVC Main10 BT.709 SDR samples: fixed
- 4K HEVC Main10 HDR10+ sample: still normal

The final working stack on the target device was:
- `libmpp.so`: stock Rock5B Android 12 vendor library
- `libcodec2_rk_component.so`: stock Rock5B Android 12 vendor library

Source image used for extraction:
- `Rock5B_Android12_rkr14_20240419-gpt.img`

Local extraction source used during validation:
- `vendor.ext_unzip/lib64/libmpp.so`
- `vendor.ext_unzip/lib/libmpp.so`
- `vendor.ext_unzip/lib64/libcodec2_rk_component.so`
- `vendor.ext_unzip/lib/libcodec2_rk_component.so`

## Targeted Video Profiles
Fixed SDR cases:
- HEVC Main10
- 1920x1080
- BT.709
- Limited range
- 23.976 fps

Preserved HDR case:
- HEVC Main10
- 3840x2160
- BT.2020 + PQ
- HDR10+ metadata
- 24 fps

## Repository Layout
- `template/`: Magisk package template without proprietary vendor blobs
- `scripts/build_magisk_zip.ps1`: builds a flashable zip from locally extracted vendor files
- `SHA256SUMS.txt`: reference hashes collected during validation
- `GITHUB_RELEASE_NOTES.md`: publishing guidance and redistribution warning

## Build The Flashable Zip
Prepare a local directory that contains:
- `lib64/libmpp.so`
- `lib/libmpp.so`
- `lib64/libcodec2_rk_component.so`
- `lib/libcodec2_rk_component.so`

Then run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build_magisk_zip.ps1 -VendorRoot <path-to-vendor.ext_unzip>
```

The zip will be created in `dist/`.

## Installation
1. Build the zip from your locally extracted vendor files.
2. Install it with your preferred root module installer.
3. Reboot.
4. Verify playback with both 1080p SDR and 4K HDR samples.

## Important Note
This repository is intentionally structured to avoid directly publishing proprietary vendor binaries.
Review redistribution rights before uploading vendor `.so` files or prebuilt zips to a public repository.
