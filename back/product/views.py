import json
import jwt
import django.core.exceptions as exceptions
from rest_framework import viewsets
from rest_framework.response import Response
import back.utils
from django.http import HttpResponse
from product.models import Product
from product.serializer import ProductSerializer
from user.models import User
import array as ArrayUtils
from Seller.models import Seller

class ProductView(viewsets.ViewSet):
    def retrieve(self, request, pk=None):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                product = Product.objects.get(id=pk)
                return Response(ProductSerializer(product).data)
            except Product.DoesNotExist:
                return Response(status=404)
        else:
            return Response(status=401)

    def list(self, request):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                product = Product.objects.all()
                return Response(ProductSerializer(product, many=True))
            except exceptions.FieldError:
                return Response(status=500)
        else:
            return Response(status=401)
    def create(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        product = ProductSerializer(data={
            'P_name': request.data.get('P_name', None),
            'P_type': request.data.get('P_type', None),
            'P_ratings': 0.0,
            'P_value': request.data.get('P_value', None),
            'P_seller': user.id
        })
        if product.is_valid(raise_exception=True):
            product.save()
            return Response(product.data, status=201,content_type="application/json")
        else:
            return Response(product.errors, status=400,content_type="application/json")

    def showProducts(self,request):
        product = Product.objects.get(P_seller=request.data.get('item_id',None))
        returns = ProductSerializer(data={
            'P_name': product.P_name,
            'P_type': product.P_type,
            'P_ratings': product.P_ratings,
            'P_value': product.P_value,
            'P_seller': product.P_seller
        })
        return Response(returns.data,status=200,content_type="application/json")


    def addRating(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        product = Product.objects.get(P_id=request.data.get('P_id',None))
        user_rating = int(request.data.get('P_rating', None))
        product.P_ratings = (product.P_ratings+user_rating)/2
        product.save()
        return Response(status=200)

    def delete(self,request):
        decoded_jwt = jwt.decode(request.get.data('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        product = Product.objects.get(P_id=request.data.get('P_id', None))
        if(user.id == product.P_seller.S_id.id):
            product.delete()
            return Response(status=200)
        else:
            return Response(status=401)

    def search(self,request):
        results_p = Product.objects.filter(P_name=request.data.get('P_name', None))
        array = list()
        for i in results_p:
            array.append(i.P_id)
        returns = json.dumps(array)
        return Response({"array": returns},status=200,content_type="application/json")

    def seller(self,request):
        products = Product.objects.filter(P_seller=request.data.get("P_seller"))
        returns = {}
        for i in products:
            returns.append(i.P_id)

        returns = json.dumps(returns)
        return Response({"array":returns},status=200,content_type="application/json")