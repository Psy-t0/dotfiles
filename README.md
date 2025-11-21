* 拡張機能の状態を出力。
```bash
    code --list-extensions > extensions.txt
```

* txtをもとに拡張機能をインストール。
```bash
    cat code/extensions.txt | xargs -n 1 code --install-extension
```