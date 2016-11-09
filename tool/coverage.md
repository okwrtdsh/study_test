Code Coverageについて
========================

Code Coverage(コード網羅率)とは
* テストされたコードの割合
* 測定手法
> コード網羅率の測定にはいくつかの手法があり、主なものとしては以下のような手法がある。
  * 文網羅 - ソースコードの各文がテストで実行されたかどうかで判断する。
  * 分岐網羅 - 制御構造上の分岐でそれぞれの分岐方向がテストされたかどうかで判断する。
  * 条件網羅 - 分岐条件の各項で真と偽の両方がテストされたかどうかで判断する。
  * 経路網羅 - 対象コードの考えられる全ての経路についてテストで実行されたかどうかで判断する。
  * 入口/出口網羅 - 存在する全ての関数呼び出しがテストで実行されたかどうかで判断する。
[Wikipedia](https://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%BC%E3%83%89%E7%B6%B2%E7%BE%85%E7%8E%87)より抜粋


## [Coverage.py](http://coverage.readthedocs.io/en/latest/)で測定する
* Coverage.pyとはPython用の測定ツール
* statement coverage(文網羅)に加え、branch coverage(分岐網羅)をサポートしている
* install
```bash
$ pip install coverage
```
* 使い方
  * 測定(`some`以下のcoverageを測定)
```bash
$ coverage run --source=some manage.py test some
```
    * `--source` ディレクトリを指定
    * `--include` 指定したファイル名のパターンを含む
    * `--omit` 指定したファイル名のパターンを除く
  * 結果を表示
```bash
$ coverage report
```
  * 詳細をhtmlで表示([sample](http://nedbatchelder.com/files/sample_coverage_html/index.html))
```bash
$ coverage html -d htmlcov
```
* 設定ファイル(.coveragerc, setup.cfg)
  * .coveragercに記述する場合

```
[run]
branch = True

[report]
exclude_lines =
    # Have to re-enable the standard pragma
    pragma: no cover

    # Don't complain about missing debug-only code:
    if self\.debug
    if settings.DEBUG

    # Don't complain if tests don't hit defensive assertion code:
    raise AssertionError
    raise NotImplementedError

    # Don't complain if non-runnable code isn't run:
    if __name__ == .__main__.:
omit =
    manage.py
    *settings.py
    **/migrations/*.py
    **/wsgi.py
```
  * setup.cfgに記述する場合
    * `[coverage:run]`など`coverage:`のprefixが必要

