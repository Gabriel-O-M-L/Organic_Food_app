import json
from user.models import User
import jwt
from rest_framework import viewsets
from rest_framework.response import Response
from cart.models import Cart
from cart.serializer import CartSerializer
from product.models import Product
from chat.models import chat
from chat.serializer import chatSerial
from product.models import Product

class CartView(viewsets.ViewSet):
    def create(self, request):
        product = Product.objects.get(P_id=request.data.get('P_id', None))
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])

        cart = CartSerializer(data={
            'user_id': user.pk,
            'products': product.pk
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

    def delete(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(id=decoded_jwt['user_id'])
        cart.delete()
        return Response(status=200)

    def finish(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(id=decoded_jwt['user_id'])
        chatsend = Product.objects.filter(P_id=cart.products)
        for i in chatsend:
            chat = chatSerial(data={
                "text": "item sold",
                "U_id_sender": cart.user_id.pk,
                "U_id_receiver": chatsend[i].P_seller.S_id.pk
            })
            if chat.is_valid(raise_exception=True):
                chat.save()

        return Response(status=200)



