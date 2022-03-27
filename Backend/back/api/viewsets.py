from rest_framework import viewsets
from back.api import serializers
from back import models

class BackViewSets(viewsets.ModelViewSet):
    serializer_class = serializers.BackSerializers
    queryset = models.Back.objects.all()
