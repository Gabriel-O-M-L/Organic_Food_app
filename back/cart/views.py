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
        list = []
        list.append(product.pk)

        cart = CartSerializer(data={
            'user_id': user.pk,
            'products': list
        })
        if cart.is_valid(raise_exception=True):
            cart.save()
            return Response(cart.data, status=201)
        else:
            return Response(cart.errors, status=400)

    def add(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')
        cart = Cart.objects.get(user_id__id=decoded_jwt['user_id'])
        cart.products.append(request.data.get('P_id'))
        cart.save()
        return Response({
            'user_id': cart.user_id.id,
            'products': cart.products,
            'cart_id': cart.cart_id
        }, status=200,content_type="application/json")

    def remove(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(user_id__id=decoded_jwt['user_id'])
        cart.products.remove(request.data.get('P_id'))
        cart.save()
        return Response(status=200)

    def show(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(user_id__id=decoded_jwt['user_id'])

        returns = json.dumps(cart.products)

        return Response({
             returns
        },status=200,content_type="application/json")

    def delete(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(user_id__id=decoded_jwt['user_id'])
        cart.delete()
        return Response(status=200)

    def finish(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        cart = Cart.objects.get(user_id__id=decoded_jwt['user_id'])

        chatlist = {}
        for i in cart.products:
            chatsend = Product.objects.get(P_id=i)
            list = []
            text = "item sold 1"
            list.append(text)
            p_name = chatsend.P_name + " 1"
            list.append(chatsend.P_name)
            chat = chatSerial(data={
                "text": list,
                "U_id_sender": cart.user_id.pk,
                "U_id_receiver": chatsend.P_seller.S_id.pk
            })
            if chat.is_valid(raise_exception=True):
                chat.save()
                chatlist.update({chatsend.P_id : chat.data})

        return Response({"chat" : chatlist},status=200)



