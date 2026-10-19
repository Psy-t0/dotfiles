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

## Starship

Bashのプロンプトに[Catppuccin Powerline](https://starship.rs/presets/catppuccin-powerline)を使用する。
配色は標準のMochaで、2行目にコマンドを入力する。

Stowは設定のみをリンクするため、各端末でStarship本体もインストールする。

```bash
mkdir -p ~/.local/bin
curl -fsSL https://starship.rs/install.sh -o /tmp/starship-install.sh
sh /tmp/starship-install.sh --yes --bin-dir ~/.local/bin
stow --no-folding --target="$HOME" starship
stow --target="$HOME" bash
exec bash
```

既存の`~/.config/starship.toml`がある場合は、先にバックアップする。
`~/.local/bin`をPATHに含め、ターミナルのフォントには
`JetBrainsMono Nerd Font Mono`などのNerd Fontを指定する。
`XDG_CONFIG_HOME`を変更している場合は、そのディレクトリに設定を配置する。
`STARSHIP_CONFIG`を設定している場合は、そのパスが優先される。

テーマは`starship/.config/starship.toml`で管理する。
Starship未インストールの場合や`TERM=dumb`の場合は通常のBashプロンプトを使用する。

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

## SSHFS（Hex Archive）

hex の `/home/saito/archive` を `~/mnt/hex-archive` にマウントする。
ユーザーサービスとしてログイン時に起動し、接続できない場合は再試行する。
Ubuntu では `sshfs` をインストールし、`ssh hex` が鍵認証で接続できるようにしておく。

```bash
sudo apt install sshfs
stow --no-folding --target="$HOME" ssh sshfs
systemctl --user daemon-reload
systemctl --user enable --now hex-archive.service
```

既存の `~/.config/systemd/user/hex-archive.service` が通常ファイルの場合は、
先にバックアップしてから Stow を実行する。
サービス設定を変更したら `systemctl --user daemon-reload` を実行し、
`systemctl --user restart hex-archive.service` で反映する。

Nautilus では `~/mnt/hex-archive` を開き、ブックマークに追加する。
ブックマークとサービスの有効化状態は各端末で管理する。
停止と自動起動の解除は `systemctl --user disable --now hex-archive.service`。
このマウントに `/etc/fstab` の設定は不要。

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
