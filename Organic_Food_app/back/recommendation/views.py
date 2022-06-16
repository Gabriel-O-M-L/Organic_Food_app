from recommendation.serializer import RegisterSerializer
from rest_framework.response import Response
import jwt
from user.models import User
from product.models import Product
import pandas as pd
import django
from rest_framework import viewsets
from Seller.models import seller
from recommendation.recommenderUtils import RecommendUtils
from recommendation.models import Register
import json

class RegisterView(viewsets.ViewSet):
    query = str(Register.objects.all().query)
    Dtfr = pd.read_sql_query(query, django.db.connection)
    hortmart = Dtfr.pivot_table(index='U_id_id', columns='P_id_id', values='P_ratings')

    def create(self, request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None),
                                 key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
                                 algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        product = Product.objects.get(P_id=request.data.get('P_id', None))
        register = RegisterSerializer(data={
            'U_id': user.pk,
            'P_id': product.pk,
            'P_type': product.P_type,
            'P_ratings': float(request.data.get('P_rating'))
        })
        product.P_ratings = (product.P_ratings+int(request.data.get('P_rating')))/2
        if register.is_valid(raise_exception=True):
            register.save()
            return Response(register.data, status=201)
        else:
            return Response(register.errors, status=400)


    def recommendCloser(self,request):
        decoded_jwt = jwt.decode(request.data.get('jwt', None), key='askdasdiuh123i1y98yejas9d812hiu89dqw9',algorithms='HS256')
        user = User.objects.get(id=decoded_jwt['user_id'])
        max_radius = float(160000)
        reccomendArray = RegisterView.methodRecommend(request.data.get('P_id', None))
        ArrayProduct = {}
        P_array = []
        j = 0
        if(len(reccomendArray) != 0):
            for i in range(0,len(reccomendArray)):
                j += 1
                if (j <= 6):
                    p = User.objects.get(seller__product__P_id=reccomendArray.index[i])
                    if(user.latitude is not None or user.longitude is not None):
                        if (p.longitude is not None or p.longitude is not None):
                           if RecommendUtils.getDistanceBetweenPointsNew((user.latitude), float(user.longitude),
                                                                          float(p.latitude),
                                                                          float(p.latitude)) < max_radius:
                                ArrayProduct[p.id] = RecommendUtils.getDistanceBetweenPointsNew(float(user.latitude),
                                                                                                float(user.longitude),
                                                                                                float(p.latitude),
                                                                                                float(p.longitude))
                                P_array.append(p.id)

                    else:
                        return Response("You do not have a set location in personal data")

            if(request.data.get('type',None)== 'recommend'):
                print(ArrayProduct)
                return Response({json.dumps(P_array)},status=200,content_type="application/json")
            else:
                return Response({'reccomendArray': reccomendArray},status=200,content_type="application/json")
        else:
            return Response('Failed to find items to recommend',status=409)

    def methodRecommend(P_id_id):

        P_rating = RegisterView.hortmart[P_id_id]
        similar_to_P = RegisterView.hortmart.corrwith(P_rating)
        corr_P = pd.DataFrame(similar_to_P, columns=['P_Corr'])
        corr_P.dropna(inplace=True)
        corr_P.sort_values('P_Corr', ascending=False)
        return corr_P.sort_values('P_Corr', ascending=False)