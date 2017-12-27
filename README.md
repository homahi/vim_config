# VSCodeからVim環境に移動する

## 背景

AngularをずっとVSCode上で作業して居たが、VSCodeが最近プラグインの入れすぎで重くなってきたことと、Vimが最近面白そうということでVim上でAngular開発用の環境が作れないかをチャレンジ。  
基本的にVim初心者なので、プレーンなVimに色々入れながら試していった感じ。  

### ゴール

* VSCode上と遜色ない環境をVim上に作成する。

### NeoVim

vimを調べていると、最近はNeoVimというのが熱くなって来ているらしい。  
元々のVimはかなりレガシーなコードになっているので、フォークして一から作り直しているとか。基本的に互換性はあるらしいので、今回はこちらで。  

#### インストール

python3でインストールします。

```
pip install neovim
```

neovim用に.vimrcを作ることもできますが、既存のvimと設定を共有するためにlinkにします。

.bashrc

```sh
export XDG_CONFIG_HOME=$HOME/.config
ln -snfv ${HOME}/.vim ${HOME}/.config/nvim/
ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
```
