その他
========================

## Tips
* test時のみ有効なapp

```python
from django.conf import settings
from django.test import TestCase, override_settings


@override_settings(
    INSTALLED_APPS=list(settings.INSTALLED_APPS) + ['some.testapp'],
    ROOT_URLCONF='some.testapp.urls'
)
class SomeTestCase(TestCase):
    ...
```

* test時にmigrationを行わないmodelの設定(`test_settings.py`)

```python
MIGRATION_MODULES = {'some.testapp': 'some.testapp.migrations_not_used_in_tests'}
```

* sqlの実行

```python
from django.db import connection


class SQLTestCase(TestCase):

    def test_sql(self):
        # from string
        connection.cursor().execute('TRUNCATE no_management_table;')
        # from file
        with open('test.sql', 'r') as f:
            sql = f.read()
        connection.cursor().execute(sql)
```

* commandのtest

```python
from django.core.management import call_command
from django.test.utils import captured_stdout, captured_stdin
from django.utils.six import StringIO

class SomeCommandTestCase(TestCase):

    def test_command(self):
        """
        $ python manage.py hello_world
        Hello World!!  # output
        """
        out = StringIO()
        call_command('hello_world', stdout=out)
        self.assertIn('Hello World!!', out.getvalue())

    def test_command(self):
        """
        $ python manage.py hello
        Name: Taro  # input 'Taro'
        Hello Taro!!  # output
        """
        with self.assertRaises(SystemExit):
            with captured_stdout() as stdout:
                with captured_stdin() as stdin:
                    stdin.write('Taro\n')
                    stdin.seek(0)
                    call_command('hello')
        self.assertEqual('Name: Hello Taro!!\n', stdout.getvalue())
```

* 日時に依存する場合
  * `django.test.utils.freeze_time`は`datetime.datetime.now()`では正しく動作しない
  * `datetime.datetime.today()`, `datetime.date.today()`であれば使用可能

```python
# Using django.test.utils
import datetime
from django.test.utils import freeze_time


class SomeTestCase(TestCase):

    @freeze_time(datetime.datetime(2016, 1, 1).timestamp())
    def test_some(self):
        ...

# Using freezegun
from freezegun import freeze_time


class SomeTestCase(TestCase):

    @freeze_time('2016-01-01')
    def test_some(self):
        ...

```
