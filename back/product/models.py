from django.db import models
from Seller.models import Seller

class Product(models.Model):
    P_id = models.BigAutoField(primary_key=True)
    P_name = models.TextField()
    P_value = models.FloatField()
    P_type = models.TextField()
    P_ratings = models.FloatField()
    P_seller = models.ForeignKey(
        Seller,on_delete=models.CASCADE
    )