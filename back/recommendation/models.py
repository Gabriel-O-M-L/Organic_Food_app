from django.db import models
from user.models import User
from product.models import Product

class Register(models.Model):
    Reg_id = models.BigAutoField(primary_key=True)
    P_id = models.ForeignKey(
        Product,on_delete=models.CASCADE
    )
    U_id = models.ForeignKey(
        User,on_delete=models.CASCADE
    )
    P_type = models.TextField()
    P_ratings = models.FloatField()
