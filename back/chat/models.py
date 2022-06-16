from django.db import models
from django.db import models
from user.models import User
from django.contrib.postgres.fields import ArrayField
from Seller.models import seller
class chatSession(models.Model):
    session_id = models.ForeignKey(
        User,on_delete=models.CASCADE
    )
    query_input = models.TextField()
    text_input = models.TextField()

class chat(models.Model):
    chatId = models.BigAutoField(primary_key=True)
    text = ArrayField(models.TextField(null=True, blank=True), null=True, blank=True)
    text2 = ArrayField(models.TextField(null=True, blank=True), null=True, blank=True)
    U_id_sender = models.ForeignKey(
        User,on_delete=models.CASCADE,related_name='U_id_sender'
    )
    U_id_receiver = models.ForeignKey(
        User,on_delete=models.CASCADE, related_name='U_id_receiver'
    )

