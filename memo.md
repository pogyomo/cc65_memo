* \*.cfgファイル
    * MEMORYセクション
        * 概要
            * メモリの開始アドレス, 大きさやその他の属性を設定する.
        * 属性について
            * start
                * メモリの開始アドレス.
            * size
                * メモリの大きさ. バイト単位で指定する.
            * file
                * このメモリが配置されるファイル名を""で指定する.
                "%O"は-oで指定されたファイルに内容を書き込む. ""は書き込まない.
            * define
                * メモリに対して以下のシンボルを定義する. .importによって読み込み可.
                    * \_\_HOGEHOGE_START\_\_
                        * メモリの開始アドレス.
                    * \_\_HOGEHOGE_SIZE\_\_ 
                        * メモリの大きさ. バイト単位.
                    * \_\_HOGEHOGE_LAST\_\_
                        * 使われてないエリアの最初のアドレス.
                    * \_\_HOGEHOGE_FILEOFFS\_\_
                        * ドキュメントを参照
            * type
                * ro -> 読み込み専用メモリである.
                * rw -> 読み書き可能なメモリである.
            * fill
                * yesで使用されていないエリアをfillvalで指定された値で埋める.
            * fillval
                * fillで使用する値. デフォルトは0.


    * SEGMENTSセクション
        * 概要
            * メモリに書き込むセグメントを指定する.
            * 上から定義した順番にメモリに書き込んでいく.
                * 以下の例では, 初めにCODEの内容をROMに書き込み, 次にRODATAの内容をROMに書き込む.
                ```
                SEGMENTS {
                    CODE:   load = ROM, ...
                    RODATA: load = ROM, ...
                    :
                }
                ```
        * 属性について
            * load
                * どのメモリにセグメントを書き込むか.
            * type
                * セグメントのタイプを以下の5つから指定する.
                    * ro
                        * 読み込み専用である.
                    * rw
                        * 読み書き可能である.
                    * bss
                        * 未初期化領域である.
                        * 初期化のため, 下記のdefineでシンボルを作成する必要がある.
                    * zp
                        * ゼロページ領域である.
                    * overwrite
                        * 
            * define
                * 以下のシンボルを定義する.
                    * \_\_HOGEHOGE_LOAD\_\_
                        * セグメントが書き込まれたメモリの先頭アドレス.
                    * \_\_HOGEHOGE_RUN\_\_
                        * runで指定したメモリでセグメントが確保した(書き込まれる)エリアの先頭アドレス.
                    * \_\_HOGEHOGE_SIZE\_\_
                        * セグメントの大きさ. バイト単位.
            * run
                * 初期値を持つ変数の初期化のために用いる.
                * つまり, 変数自体はrunで指定されたメモリに確保され, その初期値がloadで指定されたメモリに配置される.
                * もし指定されていないならば, load == runである.
                * この初期値の初期化にはcopydataを用いる(もしくは自作する).
            * optional
                * yesで, そのセグメントが用いられてない時のエラーを抑制する.


    * FEATRUREセクション
        * CONDES機能
            * 概要
                * .constructor, .destructor, .interruptorもしくは.condesでエクスポートされた関数テーブルを作る.
                * これらの関数はconstructorがinitlib, destructorがdonelib, interruptorがcallirqで順次呼び出される.
                * 自作した関数で呼び出すこともできる(つまり, initlibやdonelib, callirqを読み込まなくてもいい).
                * もちろん, これの機能を使用しないこともできる.
            * 属性について
                * segment
                    * 関数のテーブルを作成するセグメントを指定する.
                * type
                    * constructorかdestructor, interruptorまたは0~6を指定できる.
                * label
                    * 関数テーブルの開始アドレスを入れるラベルを指定する.
                * count
                    * 関数テーブルにある関数の数.
                * order
                    * increasing -> 関数が優先度の低い順に並べられる.
                    * decreasing -> 関数が優先度の高い順に並べられる.
            * 関数テーブルの仕様
                * アドレス下位 -> 上位の順に配置されている.
                * 詳細はソースコードのlibsrc/runtime/callirq.sかcondes.sを参照.
            * 注意
                * 関数の実体は固定されたバンクに置かれなければならない.




* \*.libファイル
    * 概要
        * \*.oファイルの詰め合わせ.
        * ar65でファイルを作成, 関数の追加ができる.
    * メモ
        * none.lib -> ランタイムや基本関数の詰め合わせ?
            * condes.o, callirq.oやcopydata.oとかが入ってる
