Djangoでのテストについて
========================

## テストの書き方(共通)
```python
from django.test import TestCase


class SomeTestCase(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.constant = Hoge.objects.create(...)

    def setUp(self):
        self.variable = Hoge.objects.create(...)

    def tearDown(self):
        ...

    def test_fuga(self):
        ...
```
* 基本的には`TestCase`を継承する
  * 継承関係
![](https://docs.djangoproject.com/en/1.10/_images/django_unittest_classes_hierarchy.svg)
* テストケース内で使い回す定数は`setUpTestData`で定義
  * `setUpClass`時に呼ばれる
  * 変更すると他のテストに影響
* テストごとで変更を加える変数は`setUp`で定義
  * テストごとに呼ばれる
  * 変更しても他のテストに影響しない
* テスト終了ごとに行いたい処理は`tearDown`で定義
* テストメソッドは`test`で始まらなければならない


## テストの実行
* 基本
  * すべてのテストを実行
```bash
$ python manage.py test
```
  * パッケージの実行
```bash
$ python manage.py test hoge
```
  * moduleの実行
```bash
$ python manage.py test hoge.tests
```
  * test caseの実行
```bash
$ python manage.py test hoge.tests.SomeTestCase
```
  * test methodの実行
```bash
$ python manage.py test hoge.tests.SomeTestCase.test_fuga
```
  * coverageを用いる場合(coverageについては[後述](tool/coverage.md))
```
$ coverage run --source=hoge manage.py test
```
* オプション
  * `--keepdb`
    * 通常test_dbはテストを実行するごとにCREATE,DROPする
    * テスト実行後にDROPしなくなり、次回以降CREATEしなくなる(`flush`は実行される)
    * 大半はtest_dbのCREATEに費やされるため、実行時間が短縮される
  * `--noinput`
    * 確認メッセージが抑制される
    * CIなどで実行する場合に有用
  * `--parallel`[New in Django 1.9]
    * 並列プロセスでテストを実行

## テスト作成順
* 依存しているものから順に作成
* 例(Model, Form, Viewのテストを作る場合)

![](http://www.plantuml.com/plantuml/png/oq_AIaqkKV3DJqdDuL9Go8TmtVABSX6yiCpKSYwGa89DZQukc6kbz6JVtAThPoXnWNL2941Ai4fWqs6by6ZY0eYf8EP2Bf0YC7CH0000)


## テストを書く上での注意事項(TWO SCOOPS OF DJANGO 22章 Testing Stinks and Is a Waste of Money!より)
* テストは可能な限り簡単であるべき
  * テストが必要となるような複雑なテストは書くべきではない
* DRYの原則はテストを書く際には適用しない
  * よく似ているが異なるテストデータが必要となる場合がある
  * 特定の引数での実行を保障するためには仕方がない
* fixturesに頼らない
  * 最新のmigrationに合わせ続けるのは難しい
* 失敗のためのテストも書こう
  * 成功を期待したケースは、失敗していると利用者によって報告される
  * 失敗を期待したケースは、発見が遅れ隠れたセキュリティホールになる


## 参照
* https://docs.djangoproject.com/en/1.10/topics/testing/overview/
* https://docs.djangoproject.com/en/1.10/topics/testing/tools/
* https://docs.djangoproject.com/en/1.10/topics/testing/advanced/

