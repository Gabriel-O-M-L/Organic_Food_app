import json
import jwt
import django.core.exceptions as exceptions
from rest_framework import viewsets
from rest_framework.response import Response
import back.utils
from product.models import Product
from product.serializer import ProductSerializer
from user.models import User
from Seller.models import seller
from recommendation.serializer import RegisterSerializer

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
        Seller = seller.objects.get(S_id=user.id)
        product = ProductSerializer(data={
            'P_name': request.data.get('P_name', None),
            'P_type': request.data.get('P_type', None),
            'P_ratings': 0.0,
            'P_value': request.data.get('P_value', None),
            'P_seller': Seller.pk
        })
        if product.is_valid(raise_exception=True):
            product.save()
            return Response(product.data, status=201,content_type="application/json")
        else:
            return Response(product.errors, status=400,content_type="application/json")

    def showProducts(self,request):
        product = Product.objects.get(P_id=request.data.get('P_id',None))

        return Response({
            'P_name': product.P_name,
            'P_type': product.P_type,
            'P_ratings': product.P_ratings,
            'P_value':  float(product.P_value),
            'P_seller': product.P_seller.pk,
            "P_seller_name": product.P_seller.S_name,
            "P_id": product.P_id
        }, status=200, content_type="application/json")


    def addRating(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        product = Product.objects.get(P_id=request.data.get('P_id',None))
        user_rating = float(request.data.get('P_rating', None))
        product.P_ratings = (product.P_ratings+user_rating)/2
        register = RegisterSerializer(data={
            'U_id': user.pk,
            'P_id': product.pk,
            'P_type': product.P_type,
            'P_ratings': float(request.data.get('P_rating'))
        })
        product.P_ratings = (product.P_ratings + int(request.data.get('P_rating'))) / 2
        if register.is_valid(raise_exception=True):
            register.save()
            product.save()
            return Response(register.data, status=201)
        else:
            return Response(register.errors, status=400)


    def delete(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
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
        array = []
        for i in results_p:
            array.append(i.P_id)

        return Response({"array": array},status=200,content_type="application/json")

    def seller(self,request):
        products = Product.objects.filter(P_seller__S_id=request.data.get("P_seller"))
        returns = []
        for i in products:
            returns.append(str(i.P_id))


        return Response({"array":returns},status=200,content_type="application/json")

    def myproducts(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')

        user = User.objects.get(id=decoded_jwt['user_id'])
        product = Product.objects.filter(P_seller__S_id__id=user.id)
        returns = []
        for i in product:
            returns.append(str(i.P_id))

        return Response({"array": returns},status=200,content_type="application/json")




