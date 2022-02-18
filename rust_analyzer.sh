#!/bin/bash
curl -s https://api.github.com/repos/rust-analyzer/rust-analyzer/releases/latest | grep -E 'browser_download_url' | grep "x86_64-unknown-linux-gnu.gz" | cut -d '"' -f 4 | wget -qi -
rm -f rust-analyzer-x86_64-unknown-linux-gnu
gunzip rust-analyzer-x86_64-unknown-linux-gnu.gz
chmod +x rust-analyzer-x86_64-unknown-linux-gnu
rm -f rust-analyzer
ln -s rust-analyzer-x86_64-unknown-linux-gnu rust-analyzer
pwd
