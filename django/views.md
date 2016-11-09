viewsのテスト
========================

## テストすべき内容
* ログイン, 非ログイン状態でget, postできるか
* userの種類が複数あり, 閲覧権限があるのであればuserごとでget, postできるか
* その他のmethod

## Tips
* GET/POSTなど

```python
class SomeViewTestCase(TestCase):

    def test_get(self):
        response = self.client.get('/url/')
        # 200 OK
        self.assertEqual(response.status_code, 200)
        # 302 Found
        self.assertRedirects(response, '/redirect/', 302)
        # context
        self.assertEqual(response.context['some'], 'test')
        # content(body of response)
        self.assertEqual(response.content, b'bytestring\n')
        # json(New in Django 1.9.)
        self.assertEqual(response.json()['some'], 'test')

    def test_post(self):
        response = self.client.post('/url/', data={'field1': 'test'})
        self.assertRedirects(response, '/success/', 302)
```

* Login/SSOLogin

```python
from django.test import TestCase, override_settings


class SomeViewTestCase(TestCase):
    ...
    def test_login(self):
        self.client.login(username='user', password='test')
        response = self.client.get('/url/')
        self.assertEqual(response.status_code, 200)

    @override_settings(SSO_SESSION_KEY='__SSO_ARTIFACTS__')
    def test_ssologin(self):
        """
        Require django_shibboleth.
        """
        session = self.client.session
        session[settings.SSO_SESSION_KEY] = {'roleId': 'role_id'}
        session.save()
        response = self.client.get('/url/')
        self.assertEqual(response.status_code, 200)
```

* Using RequestFactory(View method/View Mixin/etc...)

```python
from django.contrib.auth.models import AnonymousUser
from django.test.client import RequestFactory


class SomeListViewTestCase(TestCase):
    ...
    def setUp(self):
        super().setUp()
        self.factory = RequestFactory()

    def test_method(self):
        request = self.factory.get('/url/')
        request.user = self.user1  # login
        # instance
        view_instance = SomeListView(request=request)
        self.assertListEqual(
            list(view_instance.get_queryset().order_by('some')),
            [self.some1, self.some2, self.some3]
        )
        request.user = AnonymousUser()  # no login
        view_instance = SomeListView(request=request)
        self.assertFalse(view_instance.get_queryset().exists())


class SomeMixinTestCase(TestCase):
    ...
    def test_mixin(self):

        class TestView(SomeMixin, TemplateView):
            pass

        request = self.factory.get('/url/')
        # function
        view_func = TestView.as_view()
        response = view_func(request)
        self.assertEqual(response.status_code, 200)
```

* Mailを扱う場合

```python
from django.core import mail
from django.test import TestCase, override_settings

@override_settings(
    EMAIL_BACKEND='django.core.mail.backends.locmem.EmailBackend'
)
class SomeViewTestCase(TestCase):

    def test_mail(self):
        response = self.client.post('/url/', data={'field1': 'test'})
        self.assertRedirects(response, '/success/', 302)
        self.assertEqual(len(mail.outbox), 1)
        self.assertEqual(mail.outbox[0].subject, 'test subject')
        ...
```

* Fileを扱う場合

```python
class UploadViewTestCase(TestCase):
    ...
    def test_upload(self):
        with self.open('test.xlsx', 'rb') as f:
            response = self.client.post(
                '/upload/',
                {'field_name': f}
            )
        ...
```
