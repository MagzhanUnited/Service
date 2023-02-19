from django.contrib import admin
from .models import Person, Product, Message, PersonMessage

# Register your models here.
admin.site.register(Person)
admin.site.register(Product)
admin.site.register(Message)
admin.site.register(PersonMessage)