* 拡張機能の状態を出力。
```bash
    code --list-extensions > extensions.txt
```

* txtをもとに拡張機能をインストール。
```bash
    cat code/extensions.txt | xargs -n 1 code --install-extension
```
## SSH

`ssh/.ssh/config`をGNU Stowで`~/.ssh/config`にリンクする。
リポジトリのルートで実行する（既存の設定は先にバックアップする）。

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if [ -e ~/.ssh/config ] && [ ! -L ~/.ssh/config ]; then
    mv -i ~/.ssh/config ~/.ssh/config.before-stow
fi
stow --no-folding --target="$HOME" ssh
```

接続先のホスト名・IPアドレス・ユーザー名はGitHub上でも見えるため、
公開したくない設定や端末固有の設定は`~/.ssh/config.local`に書く。
このファイルは先に読み込まれるため、同じ項目について共通設定より優先される。
作成した場合は`chmod 600 ~/.ssh/config.local`で権限を設定する。

秘密鍵・`known_hosts`・`authorized_keys`はこのリポジトリで管理しない。
`IdentityFile`には鍵のパスだけを記載し、鍵自体は各端末の`~/.ssh`に置く。
`ssh/.ssh/`内は`config`と`.gitignore`以外をGitの対象外にしている。

## VS Code
