# git-dl

> GitHub File Downloader

## Features

- Lightweight single-script downloader
- Minimum dependency, powered by `curl` and `wget`
- Support recursive download

## Usage

```
Usage:
  ./git-dl.sh [-r] <url>

Options:
  <url>            GitHub URL
  -r               optional, recursivly download all files under each directory
  -h | --help      display this help message
```

### Examples

- Download files in `cwa-app-android` repository `main` folder:

```bash
~$ ./git-dl.sh https://github.com/corona-warn-app/cwa-app-android/tree/master/Corona-Warn-App/src/main
[INFO] Skip directory /corona-warn-app/cwa-app-android/tree/master/Corona-Warn-App/src/main/assets
[INFO] Skip directory /corona-warn-app/cwa-app-android/tree/master/Corona-Warn-App/src/main/java/de/rki/coronawarnapp
[INFO] Skip directory /corona-warn-app/cwa-app-android/tree/master/Corona-Warn-App/src/main/res
[INFO] Downloading https://github.com//corona-warn-app/cwa-app-android/raw/master/Corona-Warn-App/src/main/AndroidManifest.xml
[INFO] Downloading https://github.com//corona-warn-app/cwa-app-android/raw/master/Corona-Warn-App/src/main/ic_launcher-playstore.png

~$ tree main
main
├── AndroidManifest.xml
└── ic_launcher-playstore.png
```

- Download all files under `Directory Traversal` from `PayloadsAllTheThings` repository

```bash
~$ ./git-dl.sh -r https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Directory%20Traversal
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/deep_traversal.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/directory_traversal.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/dotdotpwn.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/Intruder/traversals-8-deep-exotic-encoding.txt
[INFO] Downloading https://github.com/swisskyrepo/PayloadsAllTheThings/raw/master/Directory%20Traversal/README.md

~$ tree Directory%20Traversal
Directory%20Traversal
├── Intruder
│   ├── deep_traversal.txt
│   │   └── deep_traversal.txt
│   ├── directory_traversal.txt
│   │   └── directory_traversal.txt
│   ├── dotdotpwn.txt
│   │   └── dotdotpwn.txt
│   └── traversals-8-deep-exotic-encoding.txt
│       └── traversals-8-deep-exotic-encoding.txt
└── README.md
    └── README.md
```

## When you need git-dl.sh, when not?

| Use case                                           | Option                                            |
| -------------------------------------------------- | ------------------------------------------------- |
| Download entire GitHub repository                  | `git clone --depth 1 <repo_url>`                  |
| Download crazy numerous files in a specific folder | [DownGit](https://github.com/MinhasKamal/DownGit) |
| Download some files in a specific folder           | `git-dl.sh <repo_folder_url>`                     |
| Download one single file                           | Please hit the `Raw` button                       |
