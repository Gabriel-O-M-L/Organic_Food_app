from rest_framework import serializers
from chat.models import chatSession,chat

class chatSerializer(serializers.ModelSerializer):
    class Meta:
        model = chatSession
        fields = '__all__'

class chatSerial(serializers.ModelSerializer):
    class Meta:
        model = chat
        fields = '__all__'

