# ghdl

> GitHub File Downloader

## Table of Contents

- [Features](#features)
- [Usage](#usage)
  - [Examples](#examples)
    - [Download files in current directory](#download-files-in-current-directory)
    - [Download all files recursively under each directory](#download-all-files-recursively-under-each-directory)
- [When you need ghdl.sh, when not?](#when-you-need-ghdlsh-when-not)

## Features

- Lightweight single-script downloader
- Minimum dependency, powered by `curl`
- Support recursive download

## Usage

```
Usage:
  ./ghdl.sh [-r] <url>

Options:
  <url>            GitHub URL
  -r               optional, recursively download all files under each directory
  -h | --help      display this help message
```

### Examples

#### Download files in current directory

- Download files in `cwa-app-android` repository `main` folder:

```bash
~$ ./ghdl.sh https://github.com/corona-warn-app/cwa-app-android/tree/main/Corona-Warn-App/src/main
[INFO] Skip directory /corona-warn-app/cwa-app-android/tree/main/Corona-Warn-App/src/main/assets
[INFO] Skip directory /corona-warn-app/cwa-app-android/tree/main/Corona-Warn-App/src/main/java/de/rki/coronawarnapp
[INFO] Skip directory /corona-warn-app/cwa-app-android/tree/main/Corona-Warn-App/src/main/res
[INFO] Downloading https://github.com//corona-warn-app/cwa-app-android/raw/main/Corona-Warn-App/src/main/AndroidManifest.xml
[INFO] Downloading https://github.com//corona-warn-app/cwa-app-android/raw/main/Corona-Warn-App/src/main/ic_launcher-playstore.png

~$ tree main
main
├── AndroidManifest.xml
└── ic_launcher-playstore.png
```

#### Download all files recursively under each directory

- Download all files under `Directory Traversal` from `PayloadsAllTheThings` repository

```bash
~$ ./ghdl.sh -r https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Directory%20Traversal
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/deep_traversal.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/directory_traversal.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/dotdotpwn.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/traversals-8-deep-exotic-encoding.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/README.md

~$ tree Directory%20Traversal
Directory%20Traversal
├── Intruder
│  ├── deep_traversal.txt
│  ├── directory_traversal.txt
│  ├── dotdotpwn.txt
│  └── traversals-8-deep-exotic-encoding.txt
└── README.md
```

## When you need ghdl.sh, when not?

| Use case                                           | Option                                            |
| -------------------------------------------------- | ------------------------------------------------- |
| Download entire GitHub repository                  | `git clone --depth 1 <repo_url>`                  |
| Download crazy numerous files in a specific folder | [DownGit](https://github.com/MinhasKamal/DownGit) |
| Download some files in a specific folder           | `ghdl.sh <repo_folder_url>`                       |
| Download one single file                           | Please hit the `Raw` button                       |

---

<a href="https://www.buymeacoffee.com/kevcui" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-orange.png" alt="Buy Me A Coffee" height="60px" width="217px"></a>