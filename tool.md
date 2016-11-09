Test Toolについて
=====================

Gitlab CIでDjangoのTestを行う際に以下のToolを用いて統計やTestを行っている
* 使用しているTool
  * coverage.py
  * flake8
  * isort
  * pylint
* 文法ミスなど機械的に発見してくれるのでレビューのコストが減らせる
* TestのないCodeも文法的に正しいことは保障される
