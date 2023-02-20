from django.contrib import admin
from .models import Person, Product, Message, PersonMessage

# Register your models here.
admin.site.register(Person) # Registering the Person model
admin.site.register(Product) # Registering the Product model
admin.site.register(Message) # Registering the Message model
admin.site.register(PersonMessage) # Registering the PersonMessage model
