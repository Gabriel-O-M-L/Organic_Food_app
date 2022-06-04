import django.db
from numpy import sin, cos, arccos, pi, round
import pandas as pd
class ProductUtils:

    def rad2deg(radians):
        degrees = radians * 180 / pi
        return degrees

    def deg2rad(degrees):
        radians = degrees * pi / 180
        return radians

    def getDistanceBetweenPointsNew(latitude1, longitude1, latitude2, longitude2, unit='kilometers'):

        theta = longitude1 - longitude2

        distance = 60 * 1.1515 * ProductUtils.rad2deg(
            arccos(
                (sin(ProductUtils.deg2rad(latitude1)) * sin(ProductUtils.deg2rad(latitude2))) +
                (cos(ProductUtils.deg2rad(latitude1)) * cos(ProductUtils.deg2rad(latitude2)) * cos(ProductUtils.deg2rad(theta)))
            )
        )

        if unit == 'miles':
            return round(distance, 2)
        if unit == 'kilometers':
            print(round(distance * 1.609344))
            return round(distance * 1.609344, 2)

class Recommend:

    def Recommend(product):
        hortmart = Recommend.defineDataframe()
        P_rating = hortmart[product]
        similar_to_P = hortmart.corrwith(P_rating)
        corr_P = pd.DataFrame(similar_to_P, columns=['P_Corr'])
        corr_P.dropna(inplace=True)
        corr_P.sort_values('P_Corr', ascending=False)
        return corr_P.sort_values('P_Corr', ascending=False)

    def defineDataframe(self):
        Dtfr = pd.read_sql("select * from \"Product\"",django.db.connection)
        hortmart = Dtfr.hortmart = Dtfr.pivot_table(index=['P_name'], columns='P_id', values='P_ratings')
        return hortmart