テストの現状とこれから
======================

### 現状
Gitlab CIで何かしらのテストを行っているのは
* Django Projectで12/48
* Python, Django Libraryで11/32

半数はテストが行われていない

不十分なテストを行っているものが多い
* Coverageが半分にも満たない
* ブラウザ(Selenium)のテストをしていない
* JavaScript, jQueryのテストをしていない

### これから(目標)
* Coverageは9割
* テスト駆動開発とは言わないまでも、CodeとTestをセットで開発
* UIのテストを導入
