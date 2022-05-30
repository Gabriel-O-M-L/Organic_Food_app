from django.db import models
from django.db import models
from user.models import User

class chatSession(models.Model):
    session_id = models.ForeignKey(
        User,on_delete=models.CASCADE
    )
    query_input = models.TextField()
    text_input = models.TextField()



