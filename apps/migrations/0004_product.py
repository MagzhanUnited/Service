# Generated by Django 4.1.5 on 2023-01-31 17:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apps', '0003_person_number'),
    ]

    operations = [
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.TextField()),
                ('text', models.TextField()),
                ('price', models.TextField()),
                ('image', models.TextField()),
            ],
        ),
    ]