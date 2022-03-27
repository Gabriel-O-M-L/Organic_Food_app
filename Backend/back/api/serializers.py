from rest_framework import serializers
from back import models

class BackSerializers(serializers.ModelSerializer):
    class Meta:
        model =  models.Back
        fields = '__all__'