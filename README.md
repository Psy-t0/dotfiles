* 拡張機能の状態を出力。
```bash
    code --list-extensions > extensions.txt
```

* txtをもとに拡張機能をインストール。
```bash
    cat code/extensions.txt | xargs -n 1 code --install-extension
```
## Bash

`bash/.bashrc`をGNU Stowで`~/.bashrc`にリンクする。
リポジトリのルートで実行する（既存の設定は先にバックアップする）。

```bash
if [ -e ~/.bashrc ] && [ ! -L ~/.bashrc ]; then
    mv -i ~/.bashrc ~/.bashrc.before-stow
fi
stow --target="$HOME" bash
```

対話的なターミナルの起動時に、`fastfetch`でOSロゴとシステム情報を表示する。
fastfetchが未インストールの場合や、出力が端末でない場合、`TERM=dumb`の場合は表示しない。
反映は新しいターミナルを開くか、`source ~/.bashrc`を実行する。

## Oh My Posh

Bashのプロンプトを、ユーザー・ホスト名、フォルダ、Git状態を示す色付きの帯で表示する。
Gitの帯は変更がなければ緑、未コミットの変更があれば黄色になる。
2行目でコマンドを入力する。

[公式のLinuxインストール手順](https://ohmyposh.dev/docs/installation/linux)で本体を導入する。
Stowは設定のみをリンクするため、別の端末でも本体のインストールが必要。

```bash
mkdir -p ~/.local/bin
curl -fsSL https://ohmyposh.dev/install.sh -o /tmp/oh-my-posh-install.sh
bash /tmp/oh-my-posh-install.sh -d ~/.local/bin
stow --no-folding --target="$HOME" oh-my-posh
stow --target="$HOME" bash
exec bash
```

既存の `~/.config/oh-my-posh/theme.omp.json` がある場合は、先にバックアップする。
`~/.local/bin`をPATHに含め、ターミナルのフォントには
`JetBrainsMono Nerd Font Mono`などのNerd Fontを指定する。
`XDG_CONFIG_HOME`を変更している場合は、そのディレクトリに設定を配置する。

テーマは`oh-my-posh/.config/oh-my-posh/theme.omp.json`で管理する。
本体または設定がない環境では通常のBashプロンプトを使用する。

Gitの鉛筆アイコンは作業ツリー、チェック付きアイコンはステージ済みの変更を表す。
件数の前の`~`は変更、`+`は追加、`-`は削除、`?`は未追跡、`x`は競合。
`↑` / `↓`は追跡先より先行 / 遅延しているコミット数を表す。
追跡先との差はローカル情報で比較する（自動fetchは行わない）。

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

## tmux

`tmux/.tmux.conf`をGNU Stowで`~/.tmux.conf`にリンクする。
リポジトリのルートで実行する（既存の設定は先にバックアップする）。

```bash
if [ -e ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ]; then
    mv -i ~/.tmux.conf ~/.tmux.conf.before-stow
fi
stow --target="$HOME" tmux
```

Alt＋矢印キーでペインを移動できる。
起動中のtmuxに設定を反映する場合は、次を実行する。

```bash
tmux source-file ~/.tmux.conf
```

## VS Code
