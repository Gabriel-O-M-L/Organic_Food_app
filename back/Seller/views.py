import hashlib
import django.core.exceptions as exceptions
from rest_framework import viewsets
from rest_framework.response import Response
import back.utils
import Seller.models
from Seller.serializer import SellerSerializer
from user.models import User
import jwt
import json

class SellerView(viewsets.ViewSet):
    def retrieve(self, request, pk=None):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                seller = Seller.objects.get(id=pk)
                return Response(SellerSerializer(seller).data)
            except Seller.DoesNotExist:
                return Response(status=404)
        else:
            return Response(status=401)

    def list(self, request):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                seller = Seller.objects.all()
                return Response(SellerSerializer(seller, many=True))
            except exceptions.FieldError:
                return Response(status=500)
        else:
            return Response(status=401)
    def create(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')

        seller = SellerSerializer(data={
            'S_name': request.data.get('name', None),
            'S_id': decoded_jwt['user_id']
        })
        if seller.is_valid(raise_exception=True):
            seller.save()
            return Response(seller.data, status=201)
        else:
            return Response(seller.errors, status=400)

    def delete(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        product = Seller.objects.get(P_id=request.data.get('P_id', None))
        if(user.id == product.P_seller.S_id.id):
            product.delete()
            return Response(status=200)
        else:
            return Response(status=401)

    def search(self,request):
        results = Seller.objects.filter(P_name=request.data.get('P_name', None))
        return Response(json.dump(results),status=200)