# Generated by Django 4.1.5 on 2023-01-30 15:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apps', '0002_person_fullname_person_password'),
    ]

    operations = [
        migrations.AddField(
            model_name='person',
            name='number',
            field=models.TextField(default=1),
            preserve_default=False,
        ),
    ]