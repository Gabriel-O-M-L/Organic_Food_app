import hashlib
from datetime import datetime
import jwt
import django.core.exceptions as exceptions
from rest_framework import viewsets
from rest_framework.response import Response
import back.utils
from user.models import User
from user.serializer import UserSerializer


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
        password = hashlib.sha256(request.data.get('password', None).encode())

        user = UserSerializer(data={
            'email': request.data.get('email', None),
            'password': str(password.hexdigest())
        })
        if user.is_valid(raise_exception=True):
            user.save()
            return Response(user.data, status=201)
        else:
            return Response(user.errors, status=400)

    def sign_in(self, request):
        try:
            user = User.objects.get(email=request.data.get('email', None))
            password = hashlib.sha256(request.data.get('password', None).encode())

            if password.hexdigest() == user.password:
                encoded_jwt = jwt.encode({
                    'user_id': user.id,
                    'exp': datetime.now().timestamp() * 1000 + 604800000,
                }, 'askdasdiuh123i1y98yejas9d812hiu89dqw9', algorithm='HS256')
            return Response({
                'jwt': encoded_jwt
            }, status=202)

        except (User.DoesNotExist, exceptions.FieldError):
            return Response(status=401)
