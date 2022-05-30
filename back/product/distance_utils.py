from numpy import sin, cos, arccos, pi, round
class DistanceUtils:

    def rad2deg(radians):
        degrees = radians * 180 / pi
        return degrees

    def deg2rad(degrees):
        radians = degrees * pi / 180
        return radians

    def getDistanceBetweenPointsNew(latitude1, longitude1, latitude2, longitude2, unit='kilometers'):

        theta = longitude1 - longitude2

        distance = 60 * 1.1515 * DistanceUtils.rad2deg(
            arccos(
                (sin(DistanceUtils.deg2rad(latitude1)) * sin(DistanceUtils.deg2rad(latitude2))) +
                (cos(DistanceUtils.deg2rad(latitude1)) * cos(DistanceUtils.deg2rad(latitude2)) * cos(DistanceUtils.deg2rad(theta)))
            )
        )

        if unit == 'miles':
            return round(distance, 2)
        if unit == 'kilometers':
            print(round(distance * 1.609344))
            return round(distance * 1.609344, 2)