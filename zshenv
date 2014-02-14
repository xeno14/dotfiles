###############################################
# 環境変数                                    #
###############################################
export DEV_DIR=$HOME/Developer

export PATH=/usr/local/bin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:/Users/xeno/Developer//platform-tools
export PATH=$PATH:/Users/xeno/Developer/adt-bundle-mac/sdk/tools
export PATH=$PATH:/Users/xeno/Developer/android-ndk

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/local/lib:

export EDITOR=/usr/bin/vim    # エディタの指定

# 言語の設定
LANG=ja_JP.UTF-8
export LANG

# 補完リストが多いときに尋ねる数
# -1 : 尋ねない
#  0 : ウィンドウから溢れるときは尋ねる
LISTMAX=0
export LISTMAX


#android SDK and NDK
#export TESSERACT_PATH=$DEV_DIR/
#export NDK_PROJECT_PATH=/Users/xeno/Developer/android-ndk


#Go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
