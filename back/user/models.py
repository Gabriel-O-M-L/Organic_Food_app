from django.db import models

class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    email = models.TextField()
    password = models.TextField()
    name = models.TextField(null=True)
    phone = models.TextField(null=True)
    latitude = models.DecimalField(null=True,max_digits=256,decimal_places=10)
    longitude = models.DecimalField(null=True,max_digits=256,decimal_places=10)


