from rest_framework import serializers
from chat.models import chatSession

class chatSerializer(serializers.ModelSerializer):
    class Meta:
        model = chatSession
        fields = '__all__'
