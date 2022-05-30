from django.db import models
from user.models import User

class Seller(models.Model):
    S_id = models.ForeignKey(
        User,on_delete=models.CASCADE
    )
    S_name = models.TextField()

