CIの設定
========================

GitLab Runnerの登録は[公式ページ](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/index.md)を参照

## Djangoプロジェクトでの設定

Djangoプロジェクトのディレクトリ構造(略)

＊は後で追加する

```text
repository
├── .gitlab-ci.yml ＊
├── conf
│   └── package.pip(requirements.txt)
├── setup.cfg ＊
└── src
    ├── .coveragerc ＊
    ├── .pylintrc ＊
    ├── manage.py
    └── some
        ├── someapp
        ├── ci_settings.py ＊
        ├── settings.py
        └── test_settings.py
```

## .gitlab-ci.ymlの作成
repository直下に`.gitlab-ci.yml`を作成

```yml
image: image_name

stages:
  - test

test_job:
  type: test
  script:
    - pip3 install -r conf/package.pip
    - pip3 install coverage flake8 isort pylint pylint-django
    - cd src
    - coverage run --source="." manage.py test --settings=some.ci_settings --noinput
    - coverage report
    - coverage html -d ../htmlcov
    - flake8 some
    - isort --recursive --check-only --diff some
    - pylint --load-plugins=pylint_django --rcfile .pylintrc some || exit 0
  artifacts:
    paths:
    - htmlcov/
    expire_in: 2 weeks
  tags:
    - tag_name

services:
  - postgres:latest
variables:
  POSTGRES_DB: db_name
  POSTGRES_USER: user_name
  POSTGRES_PASSWORD: "password"
```

* stages
  * buildのstageを定義し、buildの順番を定義する
  * 同じstageのbuildは並列に処理され、前のstageが正常に完了すると次のstageのbuildが実行される
* job
  * `script`は必須で、Runnerによって実行されるshell scriptを記述する
    * `coverage`, `flake8`, `isort`, `pylint`については後述
  * `type`はstageのalias
  * `tags`はRunnerを選択するために使用するtagのリスト
    * tagはAdmin Area > Overview > Runnersから確認、変更できる
  * `artifacts`はbuildの成果物のリストを定義する
    * Project, Pipelines, BuildsなどからDownloadできる
* image, services
  * build時に使用するdocker image、serviceのリストを定義できる
* variables
  * 環境変数を定義
  * Settings > VariablesからSecret Variablesを定義できる
    * passwordやsshのprivate keyなどはこれを利用する
  * [詳細](https://docs.gitlab.com/ce/ci/variables/README.html)
* .gitlab-ci.ymlの検証
  * Pipelines > CI Lintから.gitlab-ci.ymlの検証ができる
* 参照
  * https://docs.gitlab.com/ce/ci/yaml/README.html

## ci_settings.pyの作成
ci用の設定を記述(主にDB)

```
from .test_settings import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'db_name',
        'USER': 'user_name',
        'PASSWORD': 'password',
        'HOST': 'postgres',
        'PORT': '5432',
    }
}
```

## GitLabにCoverageを表示する
Settings > CI/CD PipelinesのTest coverage parsingに`\d+\%\s*$`を設定

