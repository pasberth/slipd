
# Usage:

zshrc とかに追記してください:

    source path/to/slipd/slipd.sh
    fpath=$(path/to/slipd/functions $fpath)

すると cd ../../../.. とか書かなくて済みます

```sh

    ~/hoge/fuga/example/working/directory $ cd ../../../.. # -> slipd h
    ~/hoge/fuga/example/working/directory $ cd ../../..    # -> slipd f
    ~/hoge/fuga/example/working/directory $ cd ../..       # -> slipd e
    ~/hoge/fuga/example/working/directory $ cd ..          # -> slipd

```

$HOME より下から $HOME より上に上る事はできません (フルパス指定した方がたぶん早い)  
$HOME より上ではできます。

zsh なら、 _slipd 関数を使って補完できます。  
もし `..` とかに `slipd` を alias して使いたかったら、 `compdef` もいっしょに書くべきです。

    alias ..=slipd
    compdef _slipd ..