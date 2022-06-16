import hashlib
from datetime import datetime
import jwt
import django.core.exceptions as exceptions
from rest_framework import viewsets
from rest_framework.response import Response
import back.utils
from user.models import User
from user.serializer import UserSerializer
from decimal import Decimal

class UserView(viewsets.ViewSet):
    def retrieve(self, request, pk=None):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                user = User.objects.get(id=pk)
                return Response(UserSerializer(user).data)
            except User.DoesNotExist:
                return Response(status=404)
        else:
            return Response(status=401)

    def list(self, request):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                users = User.objects.all()
                return Response(UserSerializer(users, many=True))
            except exceptions.FieldError:
                return Response(status=500)
        else:
            return Response(status=401)
    def create(self, request):

            password = hashlib.sha256(request.data.get('password', None).encode('utf-8'))

            user = UserSerializer(data={
                'email': request.data.get('email', None),
                'password': str(password.hexdigest())
            })
            if user.is_valid(raise_exception=True):
                user.save()
                return Response(user.data, status=201)
            else:
                return Response(user.errors, status=400)

    def add_data(self,request):

            decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')
            user = User.objects.get(id=decoded_jwt['user_id'])
            user.email = request.data.get('email', None)
            user.phone = request.data.get('phone', None)
            user.latitude = float(request.data.get('latitude', None))
            user.longitude = float(request.data.get('longitude', None))
            user.name = request.data.get('name', None)

            user.save(force_update=True)
            return Response(status=200)



    def sign_in(self, request):
        try:
            user = User.objects.get(email=request.data.get('email', None))
            password = hashlib.sha256(request.data.get('password', None).encode())

            if password.hexdigest() == user.password:
                login_jwt = jwt.encode({
                    'user_id': user.id,
                    'exp': datetime.now().timestamp() * 1000 + 604800000,
                }, 'askdasdiuh123i1y98yejas9d812hiu89dqw9', algorithm='HS256')

                return Response({
                    'jwt': login_jwt
                }, status=202,content_type="application/json")
            else:
                return Response(status=401)
        except (User.DoesNotExist, exceptions.FieldError):
            return Response(status=401)

    def change_password(self, request):
        try:
            new_password = hashlib.sha256(request.data.get('password', None).encode())
            User.objects.filter(email=request.data.get('email', None)).update(password=str(new_password.hexdigest()))
            return Response(status=200)

        except(User.DoesNotExist, exceptions.FieldError):
            return Response(status=401)

    def delete(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        password = hashlib.sha256(request.data.get('password', None).encode())
        if(user.password == password):
            user.delete()
            return Response(status=200)
        else:
            return Response(status=401)

    def getUser(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        return Response({
                'email': user.email,
                'name': user.name,
                'phone': user.phone,
                'latitude': user.latitude,
                'longitude': user.longitude
        },status=200,content_type="application/json")