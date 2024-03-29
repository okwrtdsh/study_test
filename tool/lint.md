Lint Toolについて
=====================

Lint Toolとは
* 構文チェックツールのこと
* 文法的なミスはもちろん、一目見ただけでは気づけないようなものまで知らせてくれる

## チェックツール
### [pep8](http://pep8.readthedocs.io/en/latest/)
Pythonのコーディング規約である[PEP8](https://www.python.org/dev/peps/pep-0008/)([日本語](https://pep8-ja.readthedocs.io/ja/latest/))に従っているかチェックする

### [pydocstyle(pep257)](http://www.pydocstyle.org/en/latest/)
Docstring規約である[PEP257](https://www.python.org/dev/peps/pep-0257/)に従っているかチェックする

### [pyflakes](https://github.com/PyCQA/pyflakes)
未使用の変数や未宣言の変数の使用、不要なインポートのチェックなどを行うことができる

### [import-order](https://github.com/spoqa/import-order)
importの順序をチェックする
>1. Module order: `__future__` , standard libraries, site-packages, local.
2. `CONSTANT_NAMES` must be the first.
3. `ClassNames` must be the second.
4. Rest must be in alphabetical order.

### [flake8](http://flake8.pycqa.org/en/latest/)
pep8とpyflakesの機能をあわせ持つ

プラグインが豊富にある
* hacking
  * flake8 に加えてOpenStack Style Guidelinesのルールをチェックする
* flake8-pep257
  * flake8でPEP257もチェックする
* flake8-import-order
  * flake8でimportの順序もチェックする
* flake8-coding
  * Magic Commentをチェックする
* flake8-double-quotes (flake8-quotes)
  * 文字列を`"`で囲むかチェックする
* flake8-print
  * printを使ってないかチェックする
* flake8-todo
  * TODOの書き方をチェックする
* pep8-naming
  * 命名規則をチェックする
* flake8-copyright
  * 著作権表示をチェックする

### [pylint](https://pylint.readthedocs.io/en/latest/)
文法エラーや警告はもちろん、リファクタリングすべき項目もチェックしてくれる

チェック項目が多く、flake8よりも強力


## 変換ツール

### [autopep8](https://github.com/hhatto/autopep8)
PEP8に対応するように変換する

### [autoflake](https://github.com/myint/autoflake)
pyflakesに対応するように変換する

### [isort](https://github.com/timothycrosley/isort)
importの順序を並び替える

### [docformatter](https://github.com/myint/docformatter)
PEP257に対応するように変換する

### [pyformat](https://github.com/myint/pyformat)
autopep8とautoflakeとdocformatterの機能をあわせ持つ


## Django用の設定
* setup.cfg
  * settingsとmigrationsを除いている

```
[flake8]
max-line-length = 119
exclude = src/some/*settings.py, src/**/migrations/*.py

[isort]
combine_as_imports = true
default_section = THIRDPARTY
include_trailing_comma = true
known_first_party = some
line_length = 79
multi_line_output = 5
not_skip = __init__.py
skip = settings.py, migrations
force_sort_within_sections = true
```

* .pylintrc
  * 自動生成したものを緩めたもの

```
[MASTER]

# Specify a configuration file.
#rcfile=

# Python code to execute, usually for sys.path manipulation such as
# pygtk.require().
#init-hook=

# Add files or directories to the blacklist. They should be base names, not
# paths.
ignore=CVS, migrations, settings, tests, tests.py, testapp, urls.py, wsgi.py

# Add files or directories matching the regex patterns to the blacklist. The
# regex matches against base names, not paths.
ignore-patterns=[A-Za-z0-9_]*settings, test[A-Za-z0-9_]*

# Pickle collected data for later comparisons.
persistent=yes

# List of plugins (as comma separated values of python modules names) to load,
# usually to register additional checkers.
load-plugins=

# Use multiple processes to speed up Pylint.
jobs=1

# Allow loading of arbitrary C extensions. Extensions are imported into the
# active Python interpreter and may run arbitrary code.
unsafe-load-any-extension=no

# A comma-separated list of package or module names from where C extensions may
# be loaded. Extensions are loading into the active Python interpreter and may
# run arbitrary code
extension-pkg-whitelist=

# Allow optimization of some AST trees. This will activate a peephole AST
# optimizer, which will apply various small optimizations. For instance, it can
# be used to obtain the result of joining multiple strings with the addition
# operator. Joining a lot of strings can lead to a maximum recursion error in
# Pylint and this flag can prevent that. It has one side effect, the resulting
# AST will be different than the one from reality. This option is deprecated
# and it will be removed in Pylint 2.0.
optimize-ast=no


[MESSAGES CONTROL]

# Only show warnings with the listed confidence levels. Leave empty to show
# all. Valid levels: HIGH, INFERENCE, INFERENCE_FAILURE, UNDEFINED
confidence=

# Enable the message, report, category or checker with the given id(s). You can
# either give multiple identifier separated by comma (,) or put this option
# multiple time (only on the command line, not in the configuration file where
# it should appear only once). See also the "--disable" option for examples.
#enable=

# Disable the message, report, category or checker with the given id(s). You
# can either give multiple identifiers separated by comma (,) or put this
# option multiple times (only on the command line, not in the configuration
# file where it should appear only once).You can also use "--disable=all" to
# disable everything first and then reenable specific checks. For example, if
# you want to run only the similarities checker, you can use "--disable=all
# --enable=similarities". If you want to run only the classes checker, but have
# no Warning level messages displayed, use"--disable=all --enable=classes
# --disable=W"
disable=delslice-method,nonzero-method,old-octal-literal,hex-method,map-builtin-not-iterating,long-suffix,unpacking-in-except,zip-builtin-not-iterating,print-statement,old-division,parameter-unpacking,apply-builtin,unichr-builtin,basestring-builtin,intern-builtin,backtick,coerce-builtin,raising-string,standarderror-builtin,metaclass-assignment,coerce-method,cmp-builtin,round-builtin,no-absolute-import,long-builtin,dict-view-method,dict-iter-method,buffer-builtin,suppressed-message,setslice-method,useless-suppression,execfile-builtin,reduce-builtin,old-ne-operator,range-builtin-not-iterating,next-method-called,reload-builtin,using-cmp-argument,getslice-method,indexing-exception,cmp-method,oct-method,unicode-builtin,raw_input-builtin,old-raise-syntax,input-builtin,import-star-module-level,xrange-builtin,file-builtin,filter-builtin-not-iterating,C0111,C0112,C0103,R0901,R0903,R0904,R0913,W0201,W0613
# C0103,C0111,C0112,C0325,C0330,R0201,R0801,R0901,R0902,R0903,R0904,R0912,R0913,W0102,W0201,W0212,W0221,W0222,W0401,W0511,W0613,W0622,W0703,E1101,E1305
# invalid-name (C0103): Invalid %s name “%s”%s Used when the name doesn’t match the regular expression associated to its type (constant, variable, class...).
# missing-docstring (C0111): Missing %s docstring Used when a module, function, class or method has no docstring.Some special methods like __init__ doesn’t necessary require a docstring.
# empty-docstring (C0112): Empty %s docstring Used when a module, function, class or method has an empty docstring (it would be too easy ;).
# superfluous-parens (C0325): Unnecessary parens after %r keyword Used when a single item in parentheses follows an if, for, or other keyword.
# bad-continuation (C0330): Wrong %s indentation%s%s. TODO
# no-self-use (R0201): Method could be a function Used when a method doesn’t use its bound instance, and so could be written as a function.
# duplicate-code (R0801): Similar lines in %s files Indicates that a set of similar lines has been detected among multiple file. This usually means that the code should be refactored to avoid this duplication.
# too-many-ancestors (R0901): Too many ancestors (%s/%s) Used when class has too many parent classes, try to reduce this to get a simpler (and so easier to use) class.
# too-many-instance-attributes (R0902): Too many instance attributes (%s/%s) Used when class has too many instance attributes, try to reduce this to get a simpler (and so easier to use) class.
# too-few-public-methods (R0903): Too few public methods (%s/%s) Used when class has too few public methods, so be sure it’s really worth it.
# too-many-public-methods (R0904): Too many public methods (%s/%s) Used when class has too many public methods, try to reduce this to get a simpler (and so easier to use) class.
# too-many-branches (R0912): Too many branches (%s/%s) Used when a function or method has too many branches, making it hard to follow.
# too-many-arguments (R0913): Too many arguments (%s/%s) Used when a function or method takes too many arguments.
# dangerous-default-value (W0102): Dangerous default value %s as argument Used when a mutable value as list or dictionary is detected in a default value for an argument.
# attribute-defined-outside-init (W0201): Attribute %r defined outside __init__ Used when an instance attribute is defined outside the __init__ method.
# protected-access (W0212): Access to a protected member %s of a client class Used when a protected member (i.e. class member with a name beginning with an underscore) is access outside the class or a descendant of the class where it’s defined.
# arguments-differ (W0221): Arguments number differs from %s %r method Used when a method has a different number of arguments than in the implemented interface or in an overridden method.
# signature-differs (W0222): Signature differs from %s %r method Used when a method signature is different than in the implemented interface or in an overridden method.
# wildcard-import (W0401): Wildcard import %s Used when from module import * is detected.
# fixme (W0511): Used when a warning note as FIXME or XXX is detected.
# unused-argument (W0613): Unused argument %r Used when a function or method argument is not used.
# redefined-builtin (W0622): Redefining built-in %r Used when a variable or function override a built-in.
# broad-except (W0703): Catching too general exception %s Used when an except catches a too general exception, possibly burying unrelated errors.
# no-member (E1101): %s %r has no %r member%s Used when a variable is accessed for an unexistent member.
# too-many-format-args (E1305): Too many arguments for format string Used when a format string that uses unnamed conversion specifiers is given too many arguments.


[REPORTS]

# Set the output format. Available formats are text, parseable, colorized, msvs
# (visual studio) and html. You can also give a reporter class, eg
# mypackage.mymodule.MyReporterClass.
output-format=text

# Put messages in a separate file for each module / package specified on the
# command line instead of printing them on stdout. Reports (if any) will be
# written in a file name "pylint_global.[txt|html]". This option is deprecated
# and it will be removed in Pylint 2.0.
files-output=no

# Tells whether to display a full report or only the messages
reports=yes

# Python expression which should return a note less than 10 (10 is the highest
# note). You have access to the variables errors warning, statement which
# respectively contain the number of errors / warnings messages and the total
# number of statements analyzed. This is used by the global evaluation report
# (RP0004).
evaluation=10.0 - ((float(5 * error + warning + refactor + convention) / statement) * 10)

# Template used to display messages. This is a python new-style format string
# used to format the message information. See doc for all details
#msg-template=


[LOGGING]

# Logging modules to check that the string format arguments are in logging
# function parameter format
logging-modules=logging


[TYPECHECK]

# Tells whether missing members accessed in mixin class should be ignored. A
# mixin class is detected if its name ends with "mixin" (case insensitive).
ignore-mixin-members=yes

# List of module names for which member attributes should not be checked
# (useful for modules/projects where namespaces are manipulated during runtime
# and thus existing member attributes cannot be deduced by static analysis. It
# supports qualified module names, as well as Unix pattern matching.
ignored-modules=

# List of class names for which member attributes should not be checked (useful
# for classes with dynamically set attributes). This supports the use of
# qualified names.
ignored-classes=optparse.Values,thread._local,_thread._local

# List of members which are set dynamically and missed by pylint inference
# system, and so shouldn't trigger E1101 when accessed. Python regular
# expressions are accepted.
generated-members=

# List of decorators that produce context managers, such as
# contextlib.contextmanager. Add to this list to register other decorators that
# produce valid context managers.
contextmanager-decorators=contextlib.contextmanager


[BASIC]

# Good variable names which should always be accepted, separated by a comma
good-names=i,j,k,ex,Run,_

# Bad variable names which should always be refused, separated by a comma
bad-names=foo,bar,baz,toto,tutu,tata

# Colon-delimited sets of names that determine each other's naming style when
# the name regexes allow several styles.
name-group=

# Include a hint for the correct naming format with invalid-name
include-naming-hint=no

# List of decorators that produce properties, such as abc.abstractproperty. Add
# to this list to register other decorators that produce valid properties.
property-classes=abc.abstractproperty

# Regular expression matching correct constant names
const-rgx=(([A-Z_][A-Z0-9_]*)|(__.*__))$

# Naming hint for constant names
const-name-hint=(([A-Z_][A-Z0-9_]*)|(__.*__))$

# Regular expression matching correct module names
module-rgx=(([a-z_][a-z0-9_]*)|([A-Z][a-zA-Z0-9]+))$

# Naming hint for module names
module-name-hint=(([a-z_][a-z0-9_]*)|([A-Z][a-zA-Z0-9]+))$

# Regular expression matching correct attribute names
attr-rgx=[a-z_][a-z0-9_]{2,30}$

# Naming hint for attribute names
attr-name-hint=[a-z_][a-z0-9_]{2,30}$

# Regular expression matching correct method names
method-rgx=[a-z_][a-z0-9_]{2,30}$

# Naming hint for method names
method-name-hint=[a-z_][a-z0-9_]{2,30}$

# Regular expression matching correct class names
class-rgx=[A-Z_][a-zA-Z0-9]+$

# Naming hint for class names
class-name-hint=[A-Z_][a-zA-Z0-9]+$

# Regular expression matching correct argument names
argument-rgx=[a-z_][a-z0-9_]{2,30}$

# Naming hint for argument names
argument-name-hint=[a-z_][a-z0-9_]{2,30}$

# Regular expression matching correct class attribute names
class-attribute-rgx=([A-Za-z_][A-Za-z0-9_]{2,30}|(__.*__))$

# Naming hint for class attribute names
class-attribute-name-hint=([A-Za-z_][A-Za-z0-9_]{2,30}|(__.*__))$

# Regular expression matching correct function names
function-rgx=[a-z_][a-z0-9_]{2,30}$

# Naming hint for function names
function-name-hint=[a-z_][a-z0-9_]{2,30}$

# Regular expression matching correct inline iteration names
inlinevar-rgx=[A-Za-z_][A-Za-z0-9_]*$

# Naming hint for inline iteration names
inlinevar-name-hint=[A-Za-z_][A-Za-z0-9_]*$

# Regular expression matching correct variable names
variable-rgx=[a-z_][a-z0-9_]{2,30}$

# Naming hint for variable names
variable-name-hint=[a-z_][a-z0-9_]{2,30}$

# Regular expression which should only match function or class names that do
# not require a docstring.
no-docstring-rgx=^_

# Minimum line length for functions/classes that require docstrings, shorter
# ones are exempt.
docstring-min-length=-1


[ELIF]

# Maximum number of nested blocks for function / method body
max-nested-blocks=5


[SPELLING]

# Spelling dictionary name. Available dictionaries: none. To make it working
# install python-enchant package.
spelling-dict=

# List of comma separated words that should not be checked.
spelling-ignore-words=

# A path to a file that contains private dictionary; one word per line.
spelling-private-dict-file=

# Tells whether to store unknown words to indicated private dictionary in
# --spelling-private-dict-file option instead of raising a message.
spelling-store-unknown-words=no


[SIMILARITIES]

# Minimum lines number of a similarity.
min-similarity-lines=4

# Ignore comments when computing similarities.
ignore-comments=yes

# Ignore docstrings when computing similarities.
ignore-docstrings=yes

# Ignore imports when computing similarities.
ignore-imports=no


[MISCELLANEOUS]

# List of note tags to take in consideration, separated by a comma.
notes=FIXME,XXX,TODO


[FORMAT]

# Maximum number of characters on a single line.
max-line-length=119

# Regexp for a line that is allowed to be longer than the limit.
ignore-long-lines=^\s*(# )?<?https?://\S+>?$

# Allow the body of an if to be on the same line as the test if there is no
# else.
single-line-if-stmt=no

# List of optional constructs for which whitespace checking is disabled. `dict-
# separator` is used to allow tabulation in dicts, etc.: {1  : 1,\n222: 2}.
# `trailing-comma` allows a space between comma and closing bracket: (a, ).
# `empty-line` allows space-only lines.
no-space-check=trailing-comma,dict-separator

# Maximum number of lines in a module
max-module-lines=1000

# String used as indentation unit. This is usually "    " (4 spaces) or "\t" (1
# tab).
indent-string='    '

# Number of spaces of indent required inside a hanging  or continued line.
indent-after-paren=4

# Expected format of line ending, e.g. empty (any line ending), LF or CRLF.
expected-line-ending-format=


[VARIABLES]

# Tells whether we should check for unused import in __init__ files.
init-import=no

# A regular expression matching the name of dummy variables (i.e. expectedly
# not used).
dummy-variables-rgx=(_+[a-zA-Z0-9]*?$)|dummy

# List of additional names supposed to be defined in builtins. Remember that
# you should avoid to define new builtins when possible.
additional-builtins=

# List of strings which can identify a callback function by name. A callback
# name must start or end with one of those strings.
callbacks=cb_,_cb

# List of qualified module names which can have objects that can redefine
# builtins.
redefining-builtins-modules=six.moves,future.builtins


[IMPORTS]

# Deprecated modules which should not be used, separated by a comma
deprecated-modules=optparse

# Create a graph of every (i.e. internal and external) dependencies in the
# given file (report RP0402 must not be disabled)
import-graph=

# Create a graph of external dependencies in the given file (report RP0402 must
# not be disabled)
ext-import-graph=

# Create a graph of internal dependencies in the given file (report RP0402 must
# not be disabled)
int-import-graph=

# Force import order to recognize a module as part of the standard
# compatibility libraries.
known-standard-library=

# Force import order to recognize a module as part of a third party library.
known-third-party=enchant

# Analyse import fallback blocks. This can be used to support both Python 2 and
# 3 compatible code, which means that the block might have code that exists
# only in one or another interpreter, leading to false positives when analysed.
analyse-fallback-blocks=no


[DESIGN]

# Maximum number of arguments for function / method
max-args=5

# Argument names that match this expression will be ignored. Default to name
# with leading underscore
ignored-argument-names=_.*

# Maximum number of locals for function / method body
max-locals=15

# Maximum number of return / yield for function / method body
max-returns=6

# Maximum number of branch for function / method body
max-branches=12

# Maximum number of statements in function / method body
max-statements=50

# Maximum number of parents for a class (see R0901).
max-parents=7

# Maximum number of attributes for a class (see R0902).
max-attributes=7

# Minimum number of public methods for a class (see R0903).
min-public-methods=2

# Maximum number of public methods for a class (see R0904).
max-public-methods=20

# Maximum number of boolean expressions in a if statement
max-bool-expr=5


[CLASSES]

# List of method names used to declare (i.e. assign) instance attributes.
defining-attr-methods=__init__,__new__,setUp

# List of valid names for the first argument in a class method.
valid-classmethod-first-arg=cls

# List of valid names for the first argument in a metaclass class method.
valid-metaclass-classmethod-first-arg=mcs

# List of member names, which should be excluded from the protected access
# warning.
exclude-protected=_asdict,_fields,_replace,_source,_make


[EXCEPTIONS]

# Exceptions that will emit a warning when being caught. Defaults to
# "Exception"
overgeneral-exceptions=Exception
```
