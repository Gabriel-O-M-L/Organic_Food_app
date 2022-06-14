import json

import jwt
from rest_framework import viewsets
from rest_framework.response import Response
from cart.models import Cart
from cart.serializer import CartSerializer
from product.models import Product

class CartView(viewsets.ViewSet):
    def create(self, request):
        product = Product.objects.get(P_id=request.data.get('P_id', None))
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')

        cart = CartSerializer(data={
            'user_id': decoded_jwt['user_id'],
            'products': product.P_id
        })
        if cart.is_valid(raise_exception=True):
            cart.save()
            return Response(cart.data, status=201)
        else:
            return Response(cart.errors, status=400)

    def add(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')
        cart = Cart.objects.get(id=decoded_jwt['user_id'])
        cart.products.append(request.data.get('P_id'))
        if cart.is_valid(raise_exception=True):
            cart.save()
            return Response(cart.data, status=201,content_type="application/json")
        else:
            return Response(cart.errors, status=400,content_type="application/json")
    def remove(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(user_id=decoded_jwt['user_id'])
        cart.products.remove(request.data.get('P_id'))
        cart.save()
        return Response(status=200)

    def show(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(id=decoded_jwt['user_id'])

        returns = json.dumps(cart.products)

        return Response({"ids": returns},status=200,content_type="application/json")
