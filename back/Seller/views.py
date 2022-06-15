import django.core.exceptions as exceptions
from rest_framework import viewsets
from rest_framework.response import Response
import back.utils
from Seller.models import seller
from Seller.serializer import SellerSerializer
from user.models import User
import jwt


class SellerView(viewsets.ViewSet):
    def retrieve(self, request, pk=None):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                returns = seller.objects.get(id=pk)
                return Response(SellerSerializer(returns).data)
            except seller.DoesNotExist:
                return Response(status=404)
        else:
            return Response(status=401)

    def list(self, request):
        valid = back.utils.decode(request.META.get("HTTP_AUTHORIZATION", None)).get("valid", False)
        if valid:
            try:
                returns = seller.objects.all()
                return Response(SellerSerializer(returns, many=True))
            except exceptions.FieldError:
                return Response(status=500)
        else:
            return Response(status=401)
    def create(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')

        user = User.objects.get(id=decoded_jwt['user_id'])
        seller = SellerSerializer(data={
            'S_name': request.data.get('S_name', None),
            'S_id': user.pk
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
        delseller = seller.objects.get(S_id=user.id)
        delseller.delete()
        return Response(status=200)

    def search(self,request):
        results = seller.objects.get(S_id=request.data.get('S_id', None))

        return Response({
            'S_name': results.S_name,
            'S_id': results.S_id.pk
        }, status=200, content_type="application/json")


    def searchseller(self,request):
        results = seller.objects.get(P_id=request.data.get('P_id', None))

        return Response({
            'S_name': results.S_name,
            'S_id': results.S_id.pk
        },status=200,content_type="application/json")

    def searchname(self,request):
        results = seller.objects.filter(S_name=request.data.get('S_name', None)).first()
        return Response({
            'S_name': results.S_name,
            'S_id': results.S_id.pk
        },status=200,content_type="application/json")


