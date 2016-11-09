GitLab CIについて
========================

CI(Continuous Integration) とは
* テストやビルドを継続的に実行していくこと
  * バグの早期発見, 省力化に有効
  * Travis CI, Jenkins, GitLab CIなどの自動化ツールが多数存在

## GitLab CI
![](https://about.gitlab.com/images/ci/arch-1.jpg)

* GitLab CIはGitLabの一機能でありプロジェクトとビルドを管理するためのインターフェースを提供している
* GitLab Runnerはビルドのためのアプリケーションで、APIを通してGitLab CIと連携できる
