modelsのテスト
========================

## テストすべき内容
* create
  * blank, nullを許容するか
  * 複数テーブルにまたがるunique, `null=True`でのunique
  * `AUTH_USER_MODEL`を変更している場合には、`crateuser`, `cratesuperuser`コマンドが実行できるか
* update
  * createと同様
* delete
  * relationに注意
  * ForeignKeyの`on_delete`の設定忘れがないか
* model methods
* manager methods
