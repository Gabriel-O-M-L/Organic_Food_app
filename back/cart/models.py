from django.db import models
from user.models import User
from django.contrib.postgres.fields import ArrayField

# Create your models here.
class Cart(models.Model):
    products = ArrayField(models.IntegerField(null=True, blank=True), null=True, blank=True)
    cart_id = models.BigAutoField(primary_key=True)
    user_id = models.ForeignKey(
        User,on_delete=models.CASCADE,unique=True
    )