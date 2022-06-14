from rest_framework import serializers
from Seller.models import seller

class SellerSerializer(serializers.ModelSerializer):
    class Meta:
        model = seller
        fields = '__all__'
