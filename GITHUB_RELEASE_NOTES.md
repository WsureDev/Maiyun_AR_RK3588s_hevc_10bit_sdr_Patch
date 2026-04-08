# GitHub Release Notes

This repository should preferably publish:
- documentation
- hashes
- packaging scripts
- extraction instructions

Avoid public upload unless redistribution is allowed:
- `libmpp.so`
- `libcodec2_rk_component.so`
- any prebuilt zip containing those vendor binaries

Recommended public workflow:
1. Reference the exact source image: `Rock5B_Android12_rkr14_20240419-gpt.img`
2. Ask users to extract the needed vendor files locally.
3. Build the Magisk zip locally with `scripts/build_magisk_zip.ps1`.
4. Publish only scripts, docs, and hashes in the GitHub repo.
