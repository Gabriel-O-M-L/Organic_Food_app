from django.db import models
from user.models import User

class seller(models.Model):
    S_id = models.ForeignKey(
        User,on_delete=models.CASCADE,unique=True
    )
    S_name = models.TextField()

