from __future__ import absolute_import
from django.db import models


class Person(models.Model):
    # Defining fields for the Person model
    fullname = models.TextField(max_length=100)
    password = models.TextField()
    email = models.TextField()
    number = models.TextField()
    liked = models.ManyToManyField('Product', related_name='liked_by')

class Product(models.Model):
# Defining fields for the Product model
    title = models.TextField()
    text = models.TextField()
    price = models.TextField()
    image = models.TextField()
    states = models.TextField()
    city = models.TextField()
    isDeliver = models.TextField()
    seller = models.ForeignKey(Person, on_delete=models.CASCADE, null=True, related_name='liked_products')
    cartype = models.TextField()
    likes = models.ManyToManyField(Person, related_name='likes')
    views = models.ManyToManyField(Person, related_name='views')
    isBest = models.TextField(null=True, default=0)

class Message(models.Model):
# Defining fields for the Message model
user = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='user') # Person who sent the message
question = models.TextField() # Question asked in the message
answer = models.TextField(null=True) # Answer to the question asked in the message

class PersonMessage(models.Model):
# Defining fields for the PersonMessage model
sender = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='user1', null=True) # Person who sent the message
receiver = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='user2', null=True) # Person who received the message
message = models.TextField(null=True) # Message sent by the sender
created = models.DateTimeField(auto_now_add=True, null=True) # Date and time when the message was sent
    
    class Meta:
        ordering = ['created']
