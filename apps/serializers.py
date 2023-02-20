from rest_framework import serializers
from .models import Person, Product, Message, PersonMessage

class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = '__all__'

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message # Using the Message model
        fields = '__all__'
class PersonMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = PersonMessage # Using the PersonMessage model
        fields = '__all__' # Serializing all the fields of the model
