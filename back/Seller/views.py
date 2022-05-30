import hashlib
import django.core.exceptions as exceptions
from rest_framework import viewsets
from rest_framework.response import Response
import back.utils
import Seller.models
from Seller.serializer import SellerSerializer

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

        seller = SellerSerializer(data={
            'S_name': request.data.get('name', None),
        })
        if seller.is_valid(raise_exception=True):
            seller.save()
            return Response(seller.data, status=201)
        else:
            return Response(seller.errors, status=400)

