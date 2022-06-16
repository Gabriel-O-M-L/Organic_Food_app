from django.db import models
from Seller.models import seller

class Product(models.Model):
    P_id = models.BigAutoField(primary_key=True)
    P_name = models.TextField()
    P_value = models.DecimalField(null=True,max_digits=256,decimal_places=2)
    P_type = models.TextField()
    P_ratings = models.FloatField()
    P_seller = models.ForeignKey(
        seller,on_delete=models.CASCADE
    )
