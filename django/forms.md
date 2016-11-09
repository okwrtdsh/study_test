formsのテスト
========================

## テストすべき内容
* form
  * `is_valid`がTrueになるケース
  * cleanでのerror
  * 検索Formであれば条件ごとのqueryset
  * ModelFormであればsave
  * その他のmethod
* widget
  * 生成されたhtmlが正しいか
  * mediaのjs, cssが正しいか
  * その他のmethod

## Tips
* Fileを扱う場合

```python
from django.core.files.uploadedfile import SimpleUploadedFile


class UploadFormTestCase(TestCase):
    ...
    def test_upload(self):
        with self.open('test.xlsx', 'rb') as f:
            xlsx_data = f.read()
        files = {'field_name': SimpleUploadedFile('upload_filename.xlsx', xlsx_data)}
        form = UploadForm(data={}, files=files)
        ...
```
