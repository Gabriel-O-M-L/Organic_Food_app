from django.db import models
from uuid import uuid4

# Create your models here.
class Back(models.Model):

    nome = models.CharField(max_length=255)

